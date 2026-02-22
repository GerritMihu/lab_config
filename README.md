# Lab Config – Ansible für Workshop-PCs und Workshop-Infrastruktur
**Standardisierte Debian 13 Trixie + KDE Umgebung für Elektronik und Technische Informatik/Mechatronik/IT und Netzwerktecknik**

[![Ansible Lint](https://github.com/GerritMihu/lab_config/actions/workflows/ansible-lint.yml/badge.svg)](https://github.com/GerritMihu/lab_config/actions/workflows/ansible-lint.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

---
## **Zweck**
Dieses Repo verwaltet die Konfiguration von **12 Workshop-PCs** (Debian 13 Trixie + KDE) für:
- **Elektronik und Netzwerktechnik** (KiCad, PlatformIO, ESP32/RPi Pico)
- **IT und Netzwerktechnik** (Server-Administration, Troubleshooting)
- **Mechatronik** (3D-Druck mit Klipper, Elektronik)

**Features:**
✅ `ansible-pull` (stündlich)
✅ KDE-Wallpaper zentralisiert
✅ VS Code + Extensions
✅ Unattended Upgrades (sicherheitsrelevant)
✅ **Exam-Mode** (Freeze via Git-Tags)

---

## **Struktur**
```mermaid
flowchart TD
    A[lab_config Repo] --> B[/inventories/]
    A --> C[/playbooks/]
    A --> D[/roles/]
    A --> E[/templates/]
    A --> F[/docs/]

    B --> B1[production/]
    B --> B2[testing/]
    B1 --> B1a[hosts.yml]
    B1 --> B1b[group_vars/]

    C --> C1[site.yml]
    C --> C2[exam_mode.yml]

    D --> D1[common]
    D --> D2[kde]
    D --> D3[vscode]


    E --> E1[lab.jpg]
    E --> E2[printer.cfg]

    F --> F1[setup_guide.md]
    F --> F2[exam_mode.md]




