# Cinema Admin Authorization - Quick Reference

## 🎯 One-Sentence Summary

**Each cinema admin can only manage their own cinema's resources (rooms, showtimes, seats). Super admins see all cinemas.**

---

## 📋 Components Checklist

| Component                  | File                                                      | Purpose                       |
| -------------------------- | --------------------------------------------------------- | ----------------------------- |
| ✅ AuthorizationService    | `Service/AuthorizationService.java`                       | Core authorization logic      |
| ✅ AuthorizationUtil       | `Util/AuthorizationUtil.java`                             | Utility methods + helpers     |
| ✅ CinemaAccess Annotation | `Annotation/CinemaAccess.java`                            | Optional parameter annotation |
| ✅ RoomRepo Method         | `Repository/RoomRepo.java`                                | `findByCinema_CinemaId()`     |
| ✅ ShowtimeRepo Methods    | `Repository/ShowtimeRepo.java`                            | Cinema-filtered queries       |
| ✅ Example Controller      | `Controller/Example/RoomManagementControllerExample.java` | Full CRUD example             |
| ✅ Implementation Guide    | `CINEMA_AUTHORIZATION_GUIDE.md`                           | Detailed patterns             |
| ✅ Summary                 | `IMPLEMENTATION_SUMMARY.md`                               | This reference                |

---

## 🔑 Session Requirements

**Set these during login:**

```java
session.setAttribute("loggedInUserId", userId);
session.setAttribute("userRole", roleName);  // "ADMIN" or "SUPER_ADMIN"
```

---

## 💻 Usage Pattern (Copy-Paste Ready)

### View List (Cinema Admin sees only their cinema data)

```java
@GetMapping
public String listRooms(Model model, HttpServletRequest request) {
    Integer cinemaId = authorizationUtil.getCurrentUserCinemaId(request);
    if (cinemaId == null) return "redirect:/login";

    List<Room> rooms = roomRepo.findByCinema_CinemaId(cinemaId);
    model.addAttribute("rooms", rooms);
    return "rooms_management";
}
```

### View Detail (Check permission before showing)

```java
@GetMapping("/{id}")
public String viewRoom(@PathVariable Integer id, HttpServletRequest request,
                       RedirectAttributes redirect) {
    Room room = roomRepo.findById(id).orElse(null);
    if (room == null) { redirect.addFlashAttribute("error", "Not found"); return "redirect:/admin/rooms"; }

    if (!authorizationUtil.hasAccessToCinema(request, room.getCinema().getCinemaId())) {
        redirect.addFlashAttribute("error", "Unauthorized");
        return "redirect:/admin/rooms";
    }

    model.addAttribute("room", room);
    return "room_detail";
}
```

### Delete (Check permission + error handling)

```java
@GetMapping("/{id}/delete")
public String deleteRoom(@PathVariable Integer id, HttpServletRequest request,
                         RedirectAttributes redirect) {
    Room room = roomRepo.findById(id).orElse(null);
    if (room == null) { redirect.addFlashAttribute("error", "Not found"); return "redirect:/admin/rooms"; }

    if (!authorizationUtil.hasAccessToCinema(request, room.getCinema().getCinemaId())) {
        redirect.addFlashAttribute("error", "Unauthorized");
        return "redirect:/admin/rooms";
    }

    try {
        roomRepo.deleteById(id);
        redirect.addFlashAttribute("message", "Deleted successfully");
    } catch (Exception e) {
        redirect.addFlashAttribute("error", "Error: " + e.getMessage());
    }
    return "redirect:/admin/rooms";
}
```

---

## 🔐 Authorization Methods

| Method                                 | Returns          | Use Case                                 |
| -------------------------------------- | ---------------- | ---------------------------------------- |
| `getCurrentUserCinemaId(request)`      | Integer or null  | Get user's cinema to filter data         |
| `hasAccessToCinema(request, cinemaId)` | boolean          | Check if user can access specific cinema |
| `isCinemaAdmin(request)`               | boolean          | Check if user is admin of any cinema     |
| `isSuperAdmin(request)`                | boolean          | Check if user is super admin             |
| `isLoggedIn(request)`                  | boolean          | Check if user is authenticated           |
| `getCinemaAccessInfo(request)`         | CinemaAccessInfo | Get full access info object              |

---

## 📊 Database Relationships

```
users (1) ←has many admins→ (1) cinemas (1) ←has many rooms→ (many)
                                    │
                              has many showtimes
                                    │
                            (through rooms)
```

**Key Foreign Keys:**

- `admins.user_id` → `users.user_id`
- `admins.cinema_id` → `cinemas.cinema_id`
- `rooms.cinema_id` → `cinemas.id`
- `showtimes.room_id` → `rooms.room_id`

---

## ✅ Implementation Checklist

For each controller that manages cinema-specific data:

- [ ] Inject `AuthorizationUtil`
- [ ] Add `HttpServletRequest` parameter to methods
- [ ] Get cinemaId: `authorizationUtil.getCurrentUserCinemaId(request)`
- [ ] Check nullity (user must be logged in)
- [ ] Load data: `findByCinema_CinemaId(cinemaId)` or check permission
- [ ] For operations on specific rows: use `hasAccessToCinema(request, rowCinemaId)`
- [ ] Return error/redirect if unauthorized
- [ ] Add try-catch for database exceptions

---

## 🧪 Testing Scenarios

| Scenario                                                | Expected Result               |
| ------------------------------------------------------- | ----------------------------- |
| Admin1 views their rooms                                | ✅ Sees Cinema 1 rooms only   |
| Admin1 tries to delete Cinema 2 room                    | ❌ Error "Unauthorized"       |
| Admin1 accesses /admin/rooms/detail/555 (Cinema 2 room) | ❌ Redirected, "Unauthorized" |
| Super Admin views rooms                                 | ✅ Sees all cinemas' rooms    |
| Unauthenticated user accesses /admin/rooms              | ❌ Redirected to /login       |
| Session timeout → user accesses page                    | ❌ Redirected to /login       |

---

## 🚨 Common Mistakes to Avoid

❌ **DON'T:**

```java
// Wrong: Listing ALL rooms for everyone
List<Room> rooms = roomRepo.findAll();

// Wrong: Trusting client-side cinema_id
room.setCinema(new Cinema(request.getParameter("cinemaId")));

// Wrong: Only client-side filtering
List<Room> allRooms = roomRepo.findAll();
List<Room> filtered = allRooms.stream()
    .filter(r -> r.getCinema().getId().equals(userCinemaId))
    .collect(toList()); // Bad! Can leak data
```

✅ **DO:**

```java
// Right: Server-side database filtering
Integer cinemaId = authorizationUtil.getCurrentUserCinemaId(request);
List<Room> rooms = roomRepo.findByCinema_CinemaId(cinemaId);

// Right: Set cinema from authenticated user
Integer userCinemaId = authorizationUtil.getCurrentUserCinemaId(request);
room.setCinema(new Cinema(userCinemaId));

// Right: Check permission for every operation
if (!authorizationUtil.hasAccessToCinema(request, room.getCinema().getCinemaId())) {
    throw new AccessDeniedException("Unauthorized");
}
```

---

## 📖 Documentation Files

| File                                   | Content                                          |
| -------------------------------------- | ------------------------------------------------ |
| `CINEMA_AUTHORIZATION_GUIDE.md`        | **Detailed implementation guide** - Read first   |
| `IMPLEMENTATION_SUMMARY.md`            | **Complete summary** - Architecture & next steps |
| `QUICK_REFERENCE.md`                   | **This file** - Usage examples at a glance       |
| `RoomManagementControllerExample.java` | **Full example controller** - Copy the pattern   |

---

## 🎓 Learning Path

1. **First Reading:** `QUICK_REFERENCE.md` (this file) - 5 min
2. **Implementation:** Review `RoomManagementControllerExample.java` - 10 min
3. **Deep Dive:** Read `CINEMA_AUTHORIZATION_GUIDE.md` - 15 min
4. **Apply:** Update your controllers copying the pattern - 30 min
5. **Test:** Verify with multiple admin accounts - 15 min

---

## 💬 FAQ

**Q: What if I forget to add authorization check?**
A: Cinema admins could access other cinemas' data → Security vulnerability

**Q: Can I modify cinema_id in a request?**
A: No! Always get it from AuthorizationUtil, never from user input

**Q: How do I handle bulk operations?**
A: Always check permission for EACH row before operating

**Q: What about API endpoints?**
A: Apply same pattern using SecurityContext or JWT instead of session

**Q: Do I need to modify database schema?**
A: No! The existing schema already supports this design

---

## 🚀 Ready to Implement?

1. ✅ All components created and compiled
2. ✅ Example controller provided
3. ✅ Documentation complete
4. ✅ No database changes needed

**Start implementing now!** Copy the pattern from `RoomManagementControllerExample.java` to your actual controllers.

---

**Questions?** Check `CINEMA_AUTHORIZATION_GUIDE.md` for detailed explanation of each component.
