# ⚡ Dynamic Power Plan

Sistem ini secara otomatis mengganti power plan berdasarkan **CPU load dan status charger**, cocok buat kamu yang:

- Mau hemat baterai saat idle
- Mau performa maksimal saat gaming
- Mau laptop nggak rewel ganti brightness tiap ganti plan

### ✨ Fitur

- Mode silent, tanpa jendela console
- **Auto-switch power plan tiap 5 detik**
- Responsif terhadap status baterai dan penggunaan CPU
- Tanpa dependensi eksternal (PowerShell di-embed ke EXE)
---
### 🧩 Struktur Plan

| Base Plan        | Tujuan               | Ciri Khas                           |
| ---------------- | -------------------- | ----------------------------------- |
| Power Saver      | Idle / AFK           | CPU 5–50%, no boost CPU   |
| Balanced         | Multitasking ringan  | CPU 5–85% (baterai), 100% (charger) |
| High Performance | Gaming / tugas berat | CPU 100%, full boost CPU |

## ⚙ Cara Setup
### 1. Buat Power Plan (Opsional)
Cari saja di internet atau minta bikinkan AI soal power plan atau **pakai bawaan dari Windows**.  
yang penting, Pastikan saja ada 3 pwrplan, untuk:
- Power Saver (Hemat daya)
- Balanced
- High Performance

<sub>*Lihat aja tujuannya di tabel atas</sub>

### 2. Edit Script Pwsh

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

### 3. Build
1. Buka project dengan **Visual Studio**
2. Pastikan `dynamic_powerplan.ps1` sudah ditambahkan sebagai **Embedded Resource**
3. Tekan `Ctrl + Shift + B` untuk build
4. Ambil file `.exe` dari folder `bin\Release` atau `bin\Debug`

### 4. Auto Run di Startup

- Buka **Task Scheduler**
- Buat task baru:
  - Trigger: **At logon / At startup**
  - Action:
    ```
    powershell.exe -WindowStyle Hidden -ExecutionPolicy Bypass -File "C:\Arahkan\ke\file.exe"
    ```
  - Pastikan opsi “Run with highest privileges” dicentang

---

### ✅ Status

✔️ Works?  
✔️ Aman jalan di background ↘  
⚡️ Ritual <sub>(Optimalisasi)</sub> biar script gak kesambet sama AV kayak Kaspersky  
❌ Tanpa brightness tiba-tiba kayak flashbang (mungkin nanti)  
❌ Disuruh mak cuci piring
