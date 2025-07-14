# ⚡ Dynamic Power Plan

Sistem ini secara otomatis mengganti power plan berdasarkan **CPU load dan status charger**, cocok buat kamu yang:

- Mau hemat baterai saat idle
- Mau performa maksimal saat gaming
- Mau laptop nggak rewel ganti brightness tiap ganti plan

---

## 🧩 Struktur Plan

| Base Plan        | Tujuan               | Ciri Khas                           |
| ---------------- | -------------------- | ----------------------------------- |
| Power Saver      | Idle / AFK           | CPU 5–50%, no boost, kipas aktif    |
| Balanced         | Multitasking ringan  | CPU 5–85% (baterai), 100% (charger) |
| High Performance | Gaming / tugas berat | CPU 100%, full boost, kipas pasif   |

---

## ⚙ Cara Setup

### 1. Buat Power Plan (Opsional)
Cari saja di internet atau minta bikinkan AI soal power plan.

yang penting, Pastikan saja ada 3 pwrplan:
- Power Saver
- Balanced
- High Performance

### 2. Jalankan Script Dinamis

Edit `dynamic_powerplan.ps1` dan sesuaikan:

```powershell
$powerSaver   = "<GUID Power Saver>"
$balanced     = "<GUID Balanced>"
$performance  = "<GUID High Performance>"
```

Lihat GUID kamu lewat:

```powershell
powercfg /l
```

### 3. Auto Run di Startup (opsional)

- Buka **Task Scheduler**
- Buat task baru:
  - Trigger: **At logon**
  - Action:
    ```
    powershell.exe -WindowStyle Hidden -ExecutionPolicy Bypass -File "C:\Path\to\dynamic_powerplan.ps1"
    ```

---

## 🚫 Matikan Auto Brightness

Jalankan:

```powershell
powercfg -setdcvalueindex SCHEME_CURRENT SUB_VIDEO ADAPTBRIGHT 0
powercfg -setacvalueindex SCHEME_CURRENT SUB_VIDEO ADAPTBRIGHT 0
```

Atau pastikan di:

```
Settings > System > Display > Brightness
```

→ Matikan opsi "Change brightness automatically..."

---

## ✅ Status

✔️ Hemat saat idle  
✔️ Ngebut saat gaming  
✔️ Tanpa brightness kejungkel  
✔️ Aman jalan di background

---
