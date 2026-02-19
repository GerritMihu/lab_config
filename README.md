# Lab Config (Debian Trixie + KDE)

- Konfiguration via `ansible-pull` (stündlich)
- KDE-Wallpaper zentral aus `/usr/share/wallpapers/lab.jpg`, per Autostart
- VS Code + Extensions (siehe `roles/vscode/vars/extensions.yml`)
- Unattended Upgrades aktiv

## Bootstrap (Client)
```bash
sudo apt update && sudo apt install -y ansible git
sudo ansible-pull -U https://github.com/<github-user>/lab-config.git -C main -i localhost, playbooks/site.yml
sudo cp bootstrap/lab-config-pull.* /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable --now lab-config-pull.timer
```

## Schnell testen
```bash
sudo systemctl start lab-config-pull.service
journalctl -u lab-config-pull -n 200
```

## Exam-Mode einfrieren
- Git-Tag setzen (z. B. `exam-2026-02`) und Service auf `-C exam-2026-02` umstellen.
- Optional Pakete per `apt-mark hold` in role `common` einfrieren.
