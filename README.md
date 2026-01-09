Как этим пользоваться при чистой установке
Загрузиться с minimal ISO, поднять сеть (у тебя уже получается).

Клонировать конфиг:

```bash
git clone https://github.com/ТЫ/nixos-config /mnt/etc/nixos
cd /mnt/etc/nixos
```

Разметить диск:
```bash
chmod +x scripts/partition-nvme0n1.sh
sudo ./scripts/partition-nvme0n1.sh
```

Сгенерировать hardware‑конфиг:
```bash
nixos-generate-config --root /mnt
cp /mnt/etc/nixos/hardware-configuration.nix .
```

(файл есть локально, но в git не пойдёт благодаря .gitignore).

Создать local.nix:
```bash
nano local.nix
# Вписываешь hostname, username, initialPassword как в шаблоне выше
```

Установить систему через flake:
```bash
nixos-install --root /mnt --flake .#laptop
```

После установки:
 - ребут,
 - логин под своим пользователем,
 - смена пароля: passwd.
 