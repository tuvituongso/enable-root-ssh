#!/bin/bash

# Đảm bảo chạy với quyền sudo
if [ "$(id -u)" != "0" ]; then
   echo "Vui lòng chạy script với quyền root hoặc sudo." 
   exit 1
fi

# Đặt mật khẩu cho root
echo "root:123456@@" | chpasswd
echo "[✓] Đã đặt mật khẩu cho root."

# Kích hoạt đăng nhập SSH cho root
sed -i 's/^#\?PermitRootLogin .*/PermitRootLogin yes/' /etc/ssh/sshd_config
sed -i 's/^#\?PasswordAuthentication .*/PasswordAuthentication yes/' /etc/ssh/sshd_config
echo "[✓] Đã chỉnh sửa file cấu hình SSH."

# Khởi động lại dịch vụ SSH
systemctl restart sshd
echo "[✓] Đã khởi động lại dịch vụ SSH."

# Hoàn tất
echo "✅ Cấu hình thành công! Bây giờ bạn có thể SSH bằng root và mật khẩu."
