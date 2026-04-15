# Cách Phân Tách Phòng Theo Rạp - Room Cinema Isolation Implementation

## 📋 Tóm Tắt (Summary)

Đã triển khai cơ chế phân tách phòng (Room) theo Cinema, đảm bảo mỗi admin rạp chỉ có thể quản lý phòng của rạp mình.

**Implemented room-cinema isolation so that each cinema admin can only manage their own cinema's rooms.**

---

## 🎯 Vấn Đề Cơ Bản (Problem)

- ❌ `cinema_id` ở bảng `rooms` đang bị **bỏ trống** (NULL)
- ❌ Tất cả admin đều có thể **thấy và quản lý tất cả phòng** (no cinema isolation)
- ❌ Không có kiểm tra authorization cho các thao tác với phòng

---

## ✅ Giải Pháp Đã Thực Hiện (Solution Implemented)

### 1. RoomController - Quản Lý Phòng

**File:** `src/main/java/com/example/btl_web/Controller/RoomController.java`

#### Thay Đổi:

- ✅ Inject `AuthorizationUtil` để lấy `cinemaId` của admin đang đăng nhập
- ✅ Thêm `HttpServletRequest` parameter vào các method cần authorization
- ✅ **Listing rooms**: Chỉ hiển thị phòng của cinema hiện tại (không phải `findAll()`)
  ```java
  List<Room> rooms = roomRepo.findByCinema_CinemaId(cinemaId);
  ```
- ✅ **Create room**: Tự động gán `room.cinema` từ cinema của admin hiện tại
  ```java
  room.setCinema(admin.getCinema());
  ```
- ✅ **Update room**: Kiểm tra xem phòng có thuộc cinema hiện tại không trước khi update
- ✅ **Delete room**: Thêm authorization check trước khi xóa

#### Code Pattern:

```java
@GetMapping
public String roomsPage(@RequestParam(required = false) String keyword,
                       Model model, HttpServletRequest request) {
    // Lấy cinema_id của admin hiện tại
    Integer cinemaId = authorizationUtil.getCurrentUserCinemaId(request);

    // Redirect về login nếu không phải cinema admin
    if (cinemaId == null) {
        return "redirect:/login";
    }

    // Chỉ lấy phòng của cinema này
    List<Room> rooms = roomRepo.findByCinema_CinemaId(cinemaId);

    model.addAttribute("rooms", rooms);
    return "rooms_management";
}
```

---

### 2. SeatController - Quản Lý Ghế

**File:** `src/main/java/com/example/btl_web/Controller/SeatController.java`

#### Thay Đổi:

- ✅ Inject `AuthorizationUtil` và `RoomRepo`
- ✅ **View seats**: Kiểm tra xem phòng có thuộc cinema hiện tại không
- ✅ **Update seat**: Xác minh authorization trước khi thay đổi loại ghế (VIP/NORMAL)

#### Kiểm Tra Authorization:

```java
Room room = roomRepository.findById(roomId).orElse(null);
if (room == null || room.getCinema() == null ||
    !room.getCinema().getCinemaId().equals(cinemaId)) {
    return "redirect:/admin/rooms";
}
```

---

### 3. ShowtimeController - Quản Lý Suất Chiếu

**File:** `src/main/java/com/example/btl_web/Controller/ShowtimeController.java`

#### Thay Đổi:

- ✅ Inject `AuthorizationUtil`
- ✅ **Listing showtimes**: Chỉ hiển thị suất chiếu của cinema hiện tại
  ```java
  List<Showtime> showtimes = showtimeRepo.findByCinema_CinemaId(cinemaId);
  ```
- ✅ **Create form**: Chỉ lấy phòng của cinema này (`findByCinema_CinemaId`)
- ✅ **Create showtime**: Kiểm tra xem phòng được chọn có thuộc cinema hiện tại không
- ✅ **Edit form**: Kiểm tra authorization + chỉ lấy phòng của cinema
- ✅ **Update showtime**: Kiểm tra xem phòng mới có thuộc cinema hiện tại không
- ✅ **Delete showtime**: Thêm authorization check
- ✅ **View seats**: Kiểm tra authorization trước khi hiển thị ghế

---

## 🔧 Cơ Chế Hoạt Động (How It Works)

### Request Flow:

```
1. Admin đăng nhập
   ↓
2. Session attribute: loggedInUserId
   ↓
3. AuthorizationUtil.getCurrentUserCinemaId(request)
   - Lấy userId từ session
   - Query AdminRepo.findByUserUserId(userId)
   - Lấy cinema từ admin record
   ↓
4. Controller filter/authorize dựa trên cinemaId
   - Chỉ hiển thị data của cinema này
   - Reject nếu user cố truy cập data từ cinema khác
```

### Authorization Checks:

```
Mỗi method có flow như sau:
1. GET cinemaId từ AuthorizationUtil
2. IF cinemaId == null → redirect /login
3. LOAD entity từ database
4. IF entity.cinema.cinemaId ≠ cinemaId → reject + error message
5. ALLOW operation
```

---

## 📊 Repository Methods Sử Dụng

### RoomRepo:

```java
List<Room> findByCinema_CinemaId(Integer cinemaId);
```

### ShowtimeRepo:

```java
List<Showtime> findByCinema_CinemaId(Integer cinemaId);
List<Showtime> findTodayShowtimesByCinema(Integer cinemaId);
List<Showtime> findUpcomingShowtimesByCinema(Integer cinemaId);
```

---

## 🚀 Deployment Status

✅ **Code Compiled Successfully**

- Không có compile errors
- Các warnings là Lombok + Java 25 compatibility (bình thường)

✅ **Application Running**

- Port: 8082
- Status: ✓ Started BtlWebApplication in ~4 seconds

✅ **All JPA Repositories Bootstrapped**

- Found 18 JPA repository interfaces
- HikariCP connection pool initialized

---

## 📝 Hành Động Tiếp Theo (Future Enhancements)

### Nếu muốn thêm:

1. **Migration script** cho existing NULL cinema_id:

   ```sql
   UPDATE rooms r
   SET cinema_id = (SELECT cinema_id FROM admins a LIMIT 1)
   WHERE cinema_id IS NULL;
   ```

2. **MovieController cinema filtering** (nếu phim theo cinema)
3. **Admin dashboard** để xem tổng quát cinema data
4. **API endpoints** với authorization checks
5. **Audit logging** để track ai xem/sửa gì

---

## 💡 Kiểm Tra Thủ Công (Manual Testing)

### Test 1: Room Listing

```
✓ Admin 1 đăng nhập → Thấy phòng của Cinema 1
✓ Admin 2 đăng nhập → Thấy phòng của Cinema 2
✓ Admin 1 không thấy phòng của Cinema 2
```

### Test 2: Room Creation

```
✓ Admin tạo room mới
✓ room.cinema_id được set automatically từ admin's cinema
✓ Database lưu correct cinema_id
```

### Test 3: Authorization Bypass

```
✓ Admin 1 cố access /admin/seats/123 (phòng của Cinema 2)
✓ Rejected: "Bạn không có quyền xem ghế của phòng này!"
```

---

## 🔒 Security Notes

- ✅ Server-side authorization (không chỉ client-side)
- ✅ Database relationship enforced (ManyToOne - Room.cinema)
- ✅ Session-based (không stateless - không cần JWT)
- ✅ Every operation checked before execution

---

## 📞 Support

**Nếu có issues:**

1. Check logs cho authorize errors
2. Verify session attributes: `loggedInUserId`, `userRole`
3. Kiểm tra Admin record có cinema_id không?
4. Clear browser cache + re-login
