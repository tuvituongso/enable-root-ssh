#!/bin/bash

# Đặt password cho user root
echo "root:123456@@" | sudo chpasswd

# Sao lưu file cấu hình SSH
sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak

# Sửa cấu hình SSH để cho phép root login và password auth
sudo sed -i 's/^#\?PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config
sudo sed -i 's/^#\?PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config

# Kiểm tra nếu các dòng không tồn tại thì thêm vào cuối
grep -q "^PermitRootLogin" /etc/ssh/sshd_config || echo "PermitRootLogin yes" | sudo tee -a /etc/ssh/sshd_config
grep -q "^PasswordAuthentication" /etc/ssh/sshd_config || echo "PasswordAuthentication yes" | sudo tee -a /etc/ssh/sshd_config

# Restart SSH
sudo systemctl restart ssh

echo "✅ Đã cấu hình xong. Bây giờ bạn có thể SSH bằng root@IP và password: Ngoclinh1@@"
