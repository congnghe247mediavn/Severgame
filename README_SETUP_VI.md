# Cài đặt Tài Xỉu / Chẵn Lẻ / Bầu Cua trên iPhone

## Quan trọng trước khi bắt đầu
- ZIP source bạn gửi không có bản dump SQL gốc. `database.sql` trong gói này là schema khởi tạo được dựng lại từ các câu truy vấn PHP, không phải bản sao database gốc. Có thể cần thêm/sửa cột nếu một trang quản trị hoặc tính năng phụ truy cập trường chưa được suy ra.
- Không nhập file này vào database đang có dữ liệu trước khi sao lưu.
- Chỉ dùng cho môi trường thử nghiệm/website bạn có quyền quản trị. Không nạp tiền thật trước khi kiểm thử kết quả game, số dư và phân quyền.
- Không gửi mật khẩu database hay token lên chat/GitHub công khai.

## A. Tạo database trên InfinityFree bằng iPhone
1. Đăng nhập InfinityFree Client Area.
2. Chọn hosting account -> Control Panel -> MySQL Databases.
3. Tạo database mới. Ghi lại chính xác MySQL Hostname, Database Name, Username; đặt mật khẩu mạnh.
4. Mở phpMyAdmin từ trang MySQL Databases.
5. Chọn database vừa tạo -> Import -> Choose File -> chọn `database.sql` trong ứng dụng Files của iPhone -> Go.
6. Nếu file không có trong Files: tải ZIP đính kèm về iPhone, mở app Files, chạm ZIP để giải nén, sau đó chọn `database.sql` khi Import.

Lưu ý: InfinityFree thường gán tiền tố cho database và user. Hãy dùng đúng thông tin được hiển thị trong control panel; không tự đoán `sqlXXX.infinityfree.com`.

## B. Sửa kết nối PHP
Mở `htdocs/core/system/config.php` trong File Manager và tìm dòng:
```php
$mysqli = new mysqli("DB_HOST_HERE", "DB_USER_HERE", "DB_PASSWORD_HERE", "DB_NAME_HERE");
```
Thay bốn chuỗi bằng thông tin MySQL do InfinityFree cấp. Giữ dấu ngoặc kép và dấu phẩy đúng. Ví dụ chỉ để minh họa:
```php
$mysqli = new mysqli("sqlXXX.infinityfree.com", "if0_12345678", "YOUR_DB_PASSWORD", "if0_12345678_game");
$mysqli->set_charset("utf8mb4");
```
Không dùng ví dụ này làm thông tin thật. Nếu file cấu hình có lỗi cú pháp, website có thể trắng.

## C. Cấu hình Socket.IO server trên Render
1. Tải `taixiu-server-new.zip`, giải nén và đưa các file vào một GitHub repository riêng tư.
2. Trên Render chọn New -> Web Service, kết nối repository.
3. Runtime Node; Build Command: `npm install`; Start Command: `npm start`.
4. Thêm Environment Variables:
   - `PHP_BASE_URL` = `https://gameceilne99.ct.ws`
   - `ALLOWED_ORIGINS` = `https://gameceilne99.ct.ws`
   - `GAME_KEYCODE` = khóa ngẫu nhiên do bạn tự tạo, ví dụ chuỗi dài khó đoán
5. Deploy và mở `https://TEN-SERVICE.onrender.com/health`; kết quả cần có JSON `{"ok":true,...}`.
6. Trong `htdocs/core/system/head.json`, trường `socket` phải là URL Render, ví dụ `https://TEN-SERVICE.onrender.com` (không có dấu `/` cuối cũng được).
7. Trong cùng `head.json`, trường `keycode` phải khớp chính xác với biến `GAME_KEYCODE` trên Render.
8. Mở `https://gameceilne99.ct.ws/websocket/game.html`. Kết quả cần là JSON, không phải HTML lỗi hay trang trắng.

Lưu ý: server PHP gọi các route `/websocket/game.html` và `/websocket/socket.io.html`; `.htaccess` gốc rewrite `*.html` sang PHP. Nếu rewrite bị tắt hoặc `.htaccess` không được đọc, endpoint sẽ lỗi. InfinityFree chạy PHP/MySQL; không chạy Node.js trực tiếp trong `htdocs`.

## D. Chẩn đoán lỗi trắng màn hình
Thực hiện theo thứ tự:
1. Mở `https://gameceilne99.ct.ws/` và thêm `?diag=1` không tự bật debug; query này không có chức năng sửa lỗi.
2. Trong File Manager, mở `htdocs/error_log` hoặc mục Error Logs trong Control Panel; tải lại trang rồi xem lỗi mới nhất.
3. Kiểm tra `config.php`: host/database/user/password đúng; không còn `DB_HOST_HERE`, `DB_USER_HERE`, v.v.
4. Kiểm tra `core/system/head.json` tồn tại và là JSON hợp lệ. Đặc biệt trường `socket` là URL Render và trường `keycode` trùng với Render.
5. Kiểm tra thư mục gốc có `index.php`. Nếu có `index.html` rỗng, đổi tên tạm thành `index.html.bak`.
6. Đổi tên `.htaccess` thành `.htaccess.bak` chỉ để thử trong vài giây. Nếu lỗi chuyển thành 404/route hỏng thì đổi lại ngay. File gốc có ép HTTPS và rewrite `.html` sang PHP; không nên xóa hẳn.
7. Trong `config.php`, thêm tạm ngay sau `<?php`:
```php
ini_set('display_errors', '1');
ini_set('display_startup_errors', '1');
error_reporting(E_ALL);
mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);
```
Chỉ bật tạm khi kiểm tra; sau khi xem lỗi hãy xóa các dòng debug vì chúng có thể lộ thông tin nhạy cảm.
8. Nếu trang vẫn trắng, gửi ảnh/dòng cuối của error_log và lỗi cụ thể. Che mật khẩu/token trước khi gửi.

## E. Kiểm tra sau khi cài
- Mở `/health` trên Render.
- Mở `/websocket/game.html` trên domain PHP: phải trả JSON có `id`, `cancua`, `thoigian`...
- Kiểm tra trang chủ; sau đó thử đăng ký tài khoản thử nghiệm.
- Nếu lỗi kiểu `Table ... doesn't exist` thì database schema cần điều chỉnh; gửi đúng tên bảng/cột báo lỗi để cập nhật. Không tự tạo cột ngẫu nhiên.
