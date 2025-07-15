# ⚡ Dynamic Power Plan

💡 Dynamic power plan switcher buat Windows berdasarkan **CPU load dan status charger**, cocok buat kamu yang:  
<sub>**Suka atur powerplan sendiri, lol*</sub>
- Mau hemat baterai saat idle 
- Mau performa maksimal saat gaming  
~~Mau laptop nggak rewel ganti brightness tiap ganti plan~~ (mungkin nanti)

## Inspirasi
- Power plan bawaan Windows sering gak sesuai harapan, bikin frustasi sejak dulu punya laptop
- Maunya mode hemat daya tapi malah bikin device throttle 100%, kalo mode performance yang ada boros terus
- [Postingan Reddit](https://www.reddit.com/r/Amd/comments/hine0i/i_made_a_dynamic_powerplan_windows/)

### ✨ Fitur

- Mode silent, gak ada lagi tuh nongol console macam PC lagi kena malware
- **Auto-switch power plan tiap 5 detik**
- Responsif dengan status baterai dan CPU usage
- Tanpa dependensi eksternal (PowerShell langsung di-embed ke EXE)
---
### 🧩 Struktur Plan

| Base Plan        | Tujuan               | Ciri Khas                           |
| ---------------- | -------------------- | ----------------------------------- |
| Power Saver      | Idle / AFK           | CPU 5–50%, no boost CPU   |
| Balanced         | Multitasking ringan  | CPU 5–85% (baterai), 100% (charger) |
| High Performance | Gaming / tugas berat | CPU 100%, full boost CPU |

## ⚙ Cara Setup
### 1. Buat Power Plan (Opsional)
Cari saja di internet / minta bikinkan AI soal power plan / **pakai bawaan dari Windows** aja.  
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
2. Pastikan `dynamic_powerplan.ps1` sudah ditambahkan sebagai **Embedded Resource** (cek di properties-nya)
3. Tekan `Ctrl + Shift + B` untuk build
4. Ambil file `.exe` dari folder `bin\Release` atau `bin\Debug`

### 4. Auto Run di Startup

- Buka **Task Scheduler**
- Buat task baru:
  - Trigger: **At logon / At startup**
  - Action:
    Start a program → `"C:\Arahkan\ke\file.exe"`
    
  - Pastikan opsi “Run with highest privileges” dicentang

---

### ✅ Status

✔️ Works?  
✔️ Aman jalan di background ↘  
⚡️ Ritual <sub>(Optimalisasi)</sub> biar script gak kesambet sama AV kayak Kaspersky  
❌ Tanpa brightness yg tiba-tiba meledak kayak flashbang (mungkin nanti)  
❌ Disuruh mak cuci piring
