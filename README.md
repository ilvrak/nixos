### Как этим пользоваться при чистой установке
sudo -i

1. Загрузиться с minimal ISO, поднять сеть.
```bash
nmcli device wifi list
nmcli device wifi connect RT-5GPON-**** --ask
```

2. Клонировать репозиторий:
```bash
git clone https://github.com/{username}/nixos /mnt/tmp-nixos
cd /mnt/tmp-nixos
```

3. Разметить диск:
```bash
bash ./partition.sh
```

4. Сгенерировать hardware‑конфиг:
```bash
nixos-generate-config --root /mnt
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
