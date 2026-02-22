sudo apt update && sudo apt install -y ansible git
sudo ansible-pull -U https://github.com/GerritMihu/lab_config.git -C main -i localhost, playbooks/site.yml
sudo cp bootstrap/lab-config-pull.* /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable --now lab-config-pull.timer

