# 1. Git-Tag setzen (z. B. für Prüfung am 20.02.2026)
git tag exam-2026-02-20
git push origin exam-2026-02-20

# 2. Service umstellen
sudo sed -i 's/-C main/-C exam-2026-02-20/' /etc/systemd/system/lab-config-pull.service
sudo systemctl restart lab-config-pull.timer

