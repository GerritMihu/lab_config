# Vibe Progress Documentation

## Session: Ansible Workshop PC Configuration

### Date
2025-05-19

---

## Objective
Configure Ansible automation for 8 Debian workshop PCs (ap1@ap1.local through ap8@ap8.local) to install standard programs: KiCad, VS Code, avrdude, FreeCAD, etc.

---

## Actions Taken

### 1. Inventory Configuration
**File:** `production/hosts.yml`

**Changes:**
- Updated inventory to use `.local` hostnames for all 8 workshop PCs
- Added hosts: ap1 through ap8 with `ansible_host: apX.local` and `ansible_user: apX`
- Organized in hierarchical groups: `all` → `workshop_pcs` → `all_purpose`
- Added `purpose: all_purpose` metadata for each host
- Preserved legacy test host (ansible-test) for backward compatibility

**Before:**
```yaml
all:
  children:
    lab:
      hosts:
        ansible-test:
          ansible_host: 192.168.122.166
          ansible_user: ap14
```

**After:**
```yaml
all:
  children:
    workshop_pcs:
      children:
        all_purpose:
          hosts:
            ap1:
              ansible_host: ap1.local
              ansible_user: ap1
              purpose: all_purpose
            # ... ap2 through ap8
    test:
      hosts:
        ansible-test:
          ansible_host: 192.168.122.166
          ansible_user: ap14
```

---

### 2. Playbook Fix
**File:** `playbooks/site.yml`

**Changes:**
- Removed `connection: local` (was forcing local execution, preventing SSH to remote hosts)
- Added `gather_facts: true` for proper host fact gathering

**Rationale:** The original playbook had `connection: local` which would run all tasks on the Ansible control machine instead of connecting via SSH to the target hosts. This was the critical bug preventing remote provisioning.

**Before:**
```yaml
- name: Lab-Clients standardisieren (Debian Trixie + KDE)
  hosts: all
  connection: local
  become: true
```

**After:**
```yaml
- name: Lab-Clients standardisieren (Debian Trixie + KDE)
  hosts: all
  become: true
  gather_facts: true
```

---

### 3. Backup Inventory Sync
**File:** `production/inventory.yml`

**Changes:**
- Updated to match the structure of `production/hosts.yml`
- Now uses `.local` hostnames instead of placeholder IPs (`192.168.129.___`)
- Added comments explaining it's a backup/alternative inventory

---

## Package Audit

Verified that all requested standard programs are already configured across existing roles:

| Program | Role | Status |
|---------|------|--------|
| KiCad + libraries + packages3d | elektronik | ✅ Already present |
| VS Code | vscode + common | ✅ Already present |
| avrdude | elektronik | ✅ Already present |
| FreeCAD | mechatronik | ✅ Already present |
| OpenSCAD | mechatronik | ✅ Already present |
| Arduino IDE | elektronik | ✅ Already present |
| git, curl, htop | site.yml | ✅ Already present |
| wireshark, nmap, tcpdump | it_netzwerk | ✅ Already present |
| docker, docker-compose | it_netzwerk | ✅ Already present |
| Python3, pip, pipx | elektronik | ✅ Already present |
| KDE Plasma | kde + site.yml | ✅ Already present |

**Configuration Strategy:** Since `site.yml` applies ALL roles to ALL hosts, every workshop PC (ap1-ap8) receives ALL packages, making them true "Allzweck-PCs" (general purpose).

---

## Files Modified

1. `production/hosts.yml` - Primary inventory with .local hostnames
2. `playbooks/site.yml` - Fixed connection method
3. `production/inventory.yml` - Synchronized backup inventory

---

## Current State

All changes are staged locally but not yet committed. The configuration is ready for:
- Connectivity testing: `ansible -i production/hosts.yml all -m ping`
- Full provisioning: `ansible-playbook -i production/hosts.yml playbooks/site.yml -K`

---

## Next Steps (Recommended)

1. Test SSH connectivity to all hosts
2. Run ansible ping test
3. Commit changes to git
4. Run full playbook against one test host first
5. Deploy to all 8 PCs

---

## Prerequisites Checklist

- [ ] SSH server installed on all 8 PCs
- [ ] User accounts ap1-ap8 created on respective PCs
- [ ] SSH key-based authentication configured (or password auth)
- [ ] `.local` DNS resolution working (Avahi/mDNS)
- [ ] Ansible installed on control machine
- [ ] Sudo access configured for each user

---

## Notes

- The `ansible.cfg` already points to `production/hosts.yml` as the default inventory
- The `become_ask_pass = True` in ansible.cfg requires the `-K` flag for sudo password
- All roles are properly structured and include necessary tasks
