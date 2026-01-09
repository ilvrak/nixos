### Как этим пользоваться при чистой установке
1. Загрузиться с minimal ISO, поднять сеть.
```bash
nmcli device wifi list
nmcli device wifi connect RT-5GPON-****
```

2. Клонировать конфиг:
```bash
git clone https://github.com/ТЫ/nixos-config /mnt/etc/nixos
cd /mnt/etc/nixos
```

3. Разметить диск:
```bash
chmod +x scripts/partition-nvme0n1.sh
sudo ./scripts/partition-nvme0n1.sh
```

4. Сгенерировать hardware‑конфиг:
```bash
nixos-generate-config --root /mnt
cp /mnt/etc/nixos/hardware-configuration.nix .
```

5. Создать local.nix:
```bash
nano local.nix
# Вписываем hostname, username, initialPassword
```

6. Установить систему через flake:
```bash
nixos-install --root /mnt --flake .#laptop
```

7. После установки:
 - ребут,
 - логин под своим пользователем,
 - смена пароля: passwd.
