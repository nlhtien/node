#!/bin/bash

# Chạy server.js trong terminal đầu tiên
gnome-terminal -- bash -c "node server.js; exec bash"

# Chờ một khoảng thời gian ngắn để đảm bảo server.js đã khởi động trước khi chạy send_message.sh
sleep 2

# Chạy send_message.sh trong terminal thứ hai
gnome-terminal -- bash -c "./send_message.sh; exec bash"
