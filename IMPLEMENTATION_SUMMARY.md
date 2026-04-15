# Cinema Admin Authorization - Implementation Summary

## ✅ Completed Components

### 1. Core Authorization Service

**File:** `src/main/java/com/example/btl_web/Service/AuthorizationService.java`

Provides session-based authorization checks without requiring Spring Security.

**Key Methods:**

```java
getCurrentUserCinemaId(HttpServletRequest)           // Get user's cinema
hasAccessToCinema(HttpServletRequest, cinemaId)     // Check permission
isCinemaAdmin(HttpServletRequest)                    // Check if cinema admin
isSuperAdmin(HttpServletRequest)                     // Check if super admin
```

### 2. Authorization Utility Class

**File:** `src/main/java/com/example/btl_web/Util/AuthorizationUtil.java`

Simplified utility version with additional helper methods and access info class.

### 3. Custom Annotation

**File:** `src/main/java/com/example/btl_web/Annotation/CinemaAccess.java`

Optional annotation for parameter-level authorization checks.

### 4. Repository Methods for Cinema Filtering

#### RoomRepo

```java
List<Room> findByCinema_CinemaId(Integer cinemaId);
```

#### ShowtimeRepo

```java
@Query("SELECT s FROM Showtime s WHERE s.room.cinema.cinemaId = :cinemaId ...")
List<Showtime> findByCinema_CinemaId(@Param("cinemaId") Integer cinemaId);

@Query("SELECT s FROM Showtime s WHERE ... AND s.showDate = CURRENT_DATE ...")
List<Showtime> findTodayShowtimesByCinema(@Param("cinemaId") Integer cinemaId);

@Query("SELECT s FROM Showtime s WHERE ... AND s.showDate >= CURRENT_DATE ...")
List<Showtime> findUpcomingShowtimesByCinema(@Param("cinemaId") Integer cinemaId);
```

### 5. Documentation & Examples

**Comprehensive Implementation Guide:**
`CINEMA_AUTHORIZATION_GUIDE.md`

Contains:

- Architecture overview
- Implementation patterns with before/after code
- Best practices
- Testing examples
- Security considerations

**Example Controller Implementation:**
`src/main/java/com/example/btl_web/Controller/Example/RoomManagementControllerExample.java`

Shows complete CRUD operations with authorization for all HTTP methods (GET, POST, DELETE).

---

## 🔐 How It Works

### Database Flow

```
User (has role: ADMIN)
    ↓
Admin record (user_id → cinema_id)
    ↓
Cinema (cinema_id)
    ↓
Rooms ← filtered by cinema_id
Showtimes ← filtered through Room.cinema
Seats ← filtered through Room.cinema
```

### Authorization Flow

```
1. User logs in
2. Session stored: loggedInUserId = 5, userRole = "ADMIN"
3. User accesses /admin/rooms
4. Controller checks: authorizationUtil.getCurrentUserCinemaId(request)
5. Service queries: adminRepo.findByUserUserId(5)
6. Returns: cinema_id = 2
7. Load data: roomRepo.findByCinema_CinemaId(2)
8. Display only rooms of cinema 2 ✓
```

---

## 📋 Session Requirements

Your application must set these in session upon login:

```java
// During login
HttpSession session = request.getSession();
session.setAttribute("loggedInUserId", user.getUserId());      // Integer
session.setAttribute("userRole", user.getRole().getRoleName()); // String
```

Example values:

```
loggedInUserId = 5          // User ID
userRole = "ADMIN"          // or "SUPER_ADMIN", "USER"
```

---

## 🎯 Quick Implementation Steps

### For Each Controller (RoomController, ShowtimeController, etc.):

#### 1. Add Authorization Check to List View

```java
Integer cinemaId = authorizationUtil.getCurrentUserCinemaId(request);
if (cinemaId == null) {
    return "redirect:/login";
}

// Filter by cinema
List<Room> rooms = roomRepo.findByCinema_CinemaId(cinemaId);
model.addAttribute("rooms", rooms);
```

#### 2. Add Authorization Check to Detail/Edit/Delete

```java
Room room = roomRepo.findById(id).orElse(null);
if (!authorizationUtil.hasAccessToCinema(request, room.getCinema().getCinemaId())) {
    redirectAttributes.addFlashAttribute("error", "Unauthorized");
    return "redirect:/admin/rooms";
}
```

#### 3. Add Authorization Check to Create/Update

```java
Integer cinemaId = authorizationUtil.getCurrentUserCinemaId(request);
room.setCinema(new Cinema(cinemaId)); // Set cinema before saving
```

---

## ✨ Features

### ✅ Multi-Cinema Support

- Each admin manages exactly ONE cinema
- Super admin (if implemented) can view all cinemas
- No cross-cinema data access

### ✅ Automatic Filtering

- Repository methods filter by cinema_id
- No manual filtering needed in controllers
- Consistent authorization across app

### ✅ Session-Based (No Spring Security Required)

- Works with existing session management
- Simple `loggedInUserId` and `userRole` attributes
- Easy integration with current login flow

### ✅ Granular Permission Control

```
Super Admin:  Can access ALL cinemas
Cinema Admin: Can access ONLY their cinema
Regular User: Can access user panel only
```

### ✅ Error Handling

- Returns 403/error page on unauthorized access
- Flash messages for user feedback
- Exception handling for database errors

---

## 🧪 Testing Checklist

- [ ] Admin 1 can view only Cinema 1 data
- [ ] Admin 1 CANNOT view Cinema 2 data
- [ ] Admin 1 CANNOT delete Cinema 2 rooms
- [ ] Admin 1 CANNOT create rooms for Cinema 2
- [ ] Super Admin can view all cinema data
- [ ] Unauthenticated users redirected to login
- [ ] Session timeout logs out user
- [ ] Direct URL access with wrong cinema_id blocked

---

## 📝 Database Verification Queries

```sql
-- Check admin assignments
SELECT u.username, a.admin_id, c.cinema_name
FROM admins a
JOIN users u ON a.user_id = u.user_id
JOIN cinemas c ON a.cinema_id = c.cinema_id;

-- Check rooms per cinema
SELECT c.cinema_name, COUNT(r.room_id) as room_count
FROM cinemas c
LEFT JOIN rooms r ON c.cinema_id = r.cinema_id
GROUP BY c.cinema_id;

-- Check showtimes per cinema
SELECT c.cinema_name, COUNT(s.showtime_id) as showtime_count
FROM cinemas c
JOIN rooms r ON c.cinema_id = r.cinema_id
JOIN showtimes s ON r.room_id = s.room_id
GROUP BY c.cinema_id;
```

---

## 🚀 Next Steps

1. **Review** the example controller implementation
2. **Update** your existing controllers following the pattern
3. **Test** with multiple admin accounts
4. **Verify** database permissions restrict cross-cinema access
5. **Deploy** with confidence that data is isolated by cinema

---

## 📚 Files Created/Modified

### Created:

- `AuthorizationService.java` - Main authorization service
- `AuthorizationUtil.java` - Utility class with helpers
- `CinemaAccess.java` - Custom annotation
- `RoomManagementControllerExample.java` - Complete example
- `CINEMA_AUTHORIZATION_GUIDE.md` - Detailed guide
- `IMPLEMENTATION_SUMMARY.md` - This file

### Modified:

- `RoomRepo.java` - Added `findByCinema_CinemaId()`
- `ShowtimeRepo.java` - Added cinema filtering methods

### Database (No Changes Required)

- Existing schema already supports this design!
- Just ensure `admins` table has proper constraints

---

## ⚠️ Important Notes

1. **Database Schema** - No changes needed! The existing structure supports cinema-based authorization
2. **Session Management** - Ensure session attributes are set during login
3. **Super Admin** - If you have super admins, they should NOT have an admin record (or have cinema_id = NULL)
4. **Logging** - Consider logging admin actions including cinema_id for audit trail
5. **API Endpoints** - If you have REST APIs, apply same authorization checks

---

## 💡 Common Questions

**Q: What if an admin needs to manage multiple cinemas?**
A: Create multiple Admin records with same user_id but different cinema_id. Then modify AuthorizationUtil.getUserCinemaIds() to return List.

**Q: How do I super-admin access?**
A: A super admin either:

- Has no Admin record (NULL cinema_id)
- Has userRole = "SUPER_ADMIN" in session
- The isSuperAdmin() method returns true

**Q: Can I use this with Spring Security?**
A: Yes! Just extract user from SecurityContextHolder instead of session.

**Q: How do I handle API requests?**
A: Pass HttpServletRequest to service layer or create similar authorization checks for REST controllers using SecurityContext or JWT.

**Q: What about reporting across cinemas?**
A: Super admins can generate reports. Cinema admins see only their data.

---

## 🔗 Related Files

- [CINEMA_AUTHORIZATION_GUIDE.md](CINEMA_AUTHORIZATION_GUIDE.md) - Detailed implementation guide
- [RoomManagementControllerExample.java](src/main/java/com/example/btl_web/Controller/Example/RoomManagementControllerExample.java) - Complete example
- [AuthorizationService.java](src/main/java/com/example/btl_web/Service/AuthorizationService.java) - Service class
- [AuthorizationUtil.java](src/main/java/com/example/btl_web/Util/AuthorizationUtil.java) - Utility class
