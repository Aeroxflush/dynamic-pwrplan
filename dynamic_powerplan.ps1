$guid = ""  # Powerplan GUID, ganti dengan GUID yang sesuai

while ($true) {
    $powerStatus = (Get-WmiObject -Class Win32_Battery).BatteryStatus
    $cpuLoad = (Get-Counter '\Processor(_Total)\% Processor Time').CounterSamples.CookedValue

    $cpuThresholdLow = 25
    $cpuThresholdHigh = 50
    $onBattery = ($powerStatus -eq 1)

    # Matikan Auto-Brightness
    powercfg -setdcvalueindex $guid SUB_VIDEO ADAPTBRIGHT 0
    powercfg -setacvalueindex $guid SUB_VIDEO ADAPTBRIGHT 0

    if ($onBattery -and $cpuLoad -lt $cpuThresholdLow) {
        # Idle + Baterai: hemat
        powercfg -setdcvalueindex $guid SUB_PROCESSOR PROCTHROTTLEMIN 5
        powercfg -setdcvalueindex $guid SUB_PROCESSOR PROCTHROTTLEMAX 30
        powercfg -setacvalueindex $guid SUB_PROCESSOR PROCTHROTTLEMIN 20
        powercfg -setacvalueindex $guid SUB_PROCESSOR PROCTHROTTLEMAX 50
    }
    elseif ($cpuLoad -ge $cpuThresholdHigh) {
        # Beban Tinggi: performa penuh
        powercfg -setdcvalueindex $guid SUB_PROCESSOR PROCTHROTTLEMIN 100
        powercfg -setdcvalueindex $guid SUB_PROCESSOR PROCTHROTTLEMAX 100
        powercfg -setacvalueindex $guid SUB_PROCESSOR PROCTHROTTLEMIN 100
        powercfg -setacvalueindex $guid SUB_PROCESSOR PROCTHROTTLEMAX 100
    }
    else {
        # Balanced: sedang² aja
        powercfg -setdcvalueindex $guid SUB_PROCESSOR PROCTHROTTLEMIN 20
        powercfg -setdcvalueindex $guid SUB_PROCESSOR PROCTHROTTLEMAX 70
        powercfg -setacvalueindex $guid SUB_PROCESSOR PROCTHROTTLEMIN 40
        powercfg -setacvalueindex $guid SUB_PROCESSOR PROCTHROTTLEMAX 80
    }

    powercfg /s $guid  # pastikan tetap aktif plan ini
    Start-Sleep -Seconds 5
}
