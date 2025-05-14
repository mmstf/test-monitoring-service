chmod 744 ./monitoring.sh

sudo cp monitoring-test.service /etc/systemd/system
sudo cp monitoring-test.timer /etc/systemd/system

sudo systemctl daemon-reload
sudo systemctl enable monitoring-test.service
sudo systemctl start monitoring-test.service
sudo systemctl status monitoring-test.service

sudo systemctl enable --now monitoring-test.timer