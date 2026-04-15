# Cinema Admin Authorization Implementation Guide

## Overview

This system implements role-based access control (RBAC) to ensure each cinema admin can only manage their own cinema's resources (rooms, showtimes, etc).

## Architecture

### Core Components

#### 1. **AuthorizationUtil** (`Util/AuthorizationUtil.java`)

Central utility for checking access permissions.

**Key Methods:**

```java
// Get current user's cinema ID
Integer cinemaId = authorizationUtil.getCurrentUserCinemaId(request);

// Check if user has access to specific cinema
boolean hasAccess = authorizationUtil.hasAccessToCinema(request, cinemaId);

// Check if user is super admin (admin of all cinemas)
boolean isSuperAdmin = authorizationUtil.isSuperAdmin(request);

// Check if user is cinema admin
boolean isCinemaAdmin = authorizationUtil.isCinemaAdmin(request);

// Get comprehensive access info
CinemaAccessInfo info = authorizationUtil.getCinemaAccessInfo(request);
```

#### 2. **Session Requirements**

The application must store these in session:

- `loggedInUserId` (Integer) - User ID
- `userRole` (String) - "ADMIN", "SUPER_ADMIN", "USER", etc.

#### 3. **Database Relations**

```
User (1) ——— (1) Admin (many) ——— (1) Cinema
         user_id              cinema_id

Cinema (1) ——— (many) Room ——— (many) Showtime
        cinema_id              room_id
```

## Implementation Examples

### Example 1: Update RoomController with Authorization

**Before:**

```java
@Controller
@RequestMapping("/admin/rooms")
public class RoomController {
    private final RoomRepo roomRepo;

    @GetMapping
    public String getRooms(Model model) {
        model.addAttribute("rooms", roomRepo.findAll());
        return "rooms_management";
    }

    @GetMapping("/delete/{id}")
    public String deleteRoom(@PathVariable Integer id) {
        roomRepo.deleteById(id);
        return "redirect:/admin/rooms";
    }
}
```

**After (with authorization):**

```java
@Controller
@RequestMapping("/admin/rooms")
@RequiredArgsConstructor
public class RoomController {
    private final RoomRepo roomRepo;
    private final AuthorizationUtil authorizationUtil;

    @GetMapping
    public String getRooms(Model model, HttpServletRequest request) {
        Integer cinemaId = authorizationUtil.getCurrentUserCinemaId(request);

        if (cinemaId == null) {
            model.addAttribute("error", "Bạn không có quyền quản lý rạp");
            return "403";
        }

        // Chỉ lấy rooms của rạp của admin này
        List<Room> rooms = roomRepo.findByCinema_CinemaId(cinemaId);
        model.addAttribute("rooms", rooms);
        return "rooms_management";
    }

    @GetMapping("/delete/{id}")
    public String deleteRoom(
        @PathVariable Integer id,
        HttpServletRequest request,
        RedirectAttributes redirectAttributes) {

        Room room = roomRepo.findById(id).orElse(null);
        if (room == null) {
            redirectAttributes.addFlashAttribute("error", "Phòng không tồn tại");
            return "redirect:/admin/rooms";
        }

        // Kiểm tra quyền
        if (!authorizationUtil.hasAccessToCinema(request, room.getCinema().getCinemaId())) {
            redirectAttributes.addFlashAttribute("error", "Bạn không có quyền xóa phòng này");
            return "redirect:/admin/rooms";
        }

        roomRepo.deleteById(id);
        redirectAttributes.addFlashAttribute("message", "Xóa phòng thành công");
        return "redirect:/admin/rooms";
    }
}
```

### Example 2: Update ShowtimeController with Authorization

```java
@Controller
@RequestMapping("/admin/showtimes")
@RequiredArgsConstructor
public class ShowtimeController {
    private final ShowtimeRepo showtimeRepo;
    private final RoomRepo roomRepo;
    private final AuthorizationUtil authorizationUtil;

    @GetMapping
    public String showtimesPage(Model model, HttpServletRequest request) {
        Integer cinemaId = authorizationUtil.getCurrentUserCinemaId(request);

        if (cinemaId == null) {
            return "403"; // Unauthorized
        }

        // Lấy showtimes của cinema này
        List<Room> cinemaRooms = roomRepo.findByCinema_CinemaId(cinemaId);
        List<Integer> roomIds = cinemaRooms.stream()
            .map(Room::getRoomId)
            .toList();

        // Lấy showtimes từ các phòng của cinema này
        List<Showtime> showtimes = showtimeRepo.findAll()
            .stream()
            .filter(s -> roomIds.contains(s.getRoom().getRoomId()))
            .toList();

        model.addAttribute("showtimes", showtimes);
        return "showtimes";
    }

    @GetMapping("/delete/{id}")
    public String deleteShowtime(
        @PathVariable Integer id,
        HttpServletRequest request,
        RedirectAttributes redirectAttributes) {

        Showtime showtime = showtimeRepo.findById(id).orElse(null);
        if (showtime == null) {
            redirectAttributes.addFlashAttribute("error", "Suất chiếu không tồn tại");
            return "redirect:/admin/showtimes";
        }

        // Kiểm tra quyền: showtime phải thuộc room của cinema của admin
        Integer showtime CinemaId = showtime.getRoom().getCinema().getCinemaId();
        if (!authorizationUtil.hasAccessToCinema(request, showtimeCinemaId)) {
            redirectAttributes.addFlashAttribute("error", "Bạn không có quyền xóa suất chiếu này");
            return "redirect:/admin/showtimes";
        }

        // ... rest of method
    }
}
```

## Repository Methods to Add

### RoomRepo

```java
public interface RoomRepo extends JpaRepository<Room, Integer> {
    // Filter by cinema
    List<Room> findByCinema_CinemaId(Integer cinemaId);
}
```

### ShowtimeRepo

```java
public interface ShowtimeRepo extends JpaRepository<Showtime, Integer> {
    // Filter by cinema (through room)
    @Query("SELECT s FROM Showtime s WHERE s.room.cinema.cinemaId = :cinemaId")
    List<Showtime> findByCinema_CinemaId(@Param("cinemaId") Integer cinemaId);
}
```

## Best Practices

### ✅ DO's

1. **Always check authorization** before returning or modifying data
2. **Use AuthorizationUtil** for consistent permission checks
3. **Check cinema_id through object relationships** (e.g., showtime.room.cinema)
4. **Return 403 or error message** when user lacks permission
5. **Log unauthorized access attempts** for security audit

### ❌ DON'Ts

1. Don't trust client-side cinema_id parameters
2. Don't skip authorization checks for "convenience"
3. Don't return all data and filter client-side
4. Don't hardcode admin credentials
5. Don't expose error details that could leak information

## Testing Authorization

```java
@Test
void testAdminCanOnlyManageOwnCinema() {
    // Setup: Admin of Cinema 1
    Integer admin1UserId = 1;
    Integer cinema1Id = 1;

    // Admin 1 can access his cinema
    assertTrue(authorizationUtil.hasAccessToCinema(
        createMockRequest(admin1UserId),
        cinema1Id
    ));

    // Admin 1 CANNOT access Cinema 2
    assertFalse(authorizationUtil.hasAccessToCinema(
        createMockRequest(admin1UserId),
        2 // Cinema 2
    ));
}
```

## Security Considerations

### Database Constraints

Ensure `admins` table has proper constraints:

```sql
ALTER TABLE admins
ADD UNIQUE KEY unique_user_cinema (user_id, cinema_id);
```

### Session Management

- Use secure session cookies: `HttpOnly`, `Secure`, `SameSite`
- Set appropriate session timeout
- Clear session on logout

### Logging

Log all admin actions with cinema context:

```java
logger.info("Showtime deleted - cinema_id: {}, showtime_id: {}, by_admin_id: {}",
    cinemaId, showtimeId, adminId);
```

## Migration Guide

1. **Add AuthorizationUtil** to your service/controller
2. **Inject AuthorizationUtil** where needed
3. **Add authorization checks** before data access
4. **Add repository methods** for cinema filtering
5. **Test thoroughly** with multiple admin accounts
6. **Update documentation** with new permissions

## Example Flow

```
User Logs In
    ↓
Session stored: loggedInUserId=5, userRole="ADMIN"
    ↓
User accesses /admin/rooms
    ↓
Controller calls: authorizationUtil.getCurrentUserCinemaId(request)
    ↓
AuthorizationUtil queries: adminRepo.findByUserUserId(5)
    ↓
Returns: Admin record with cinemaId=2
    ↓
Controller loads: roomRepo.findByCinema_CinemaId(2)
    ↓
Display only rooms of Cinema 2 ✓

If user tries to access /admin/rooms/delete/99
    ↓
Controller checks: hasAccessToCinema(request, room.cinema.id)
    ↓
If room belongs to different cinema: Deny access ✓
```
