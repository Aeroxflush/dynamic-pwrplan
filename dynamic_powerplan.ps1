
while ($true) {
    $powerStatus = (Get-WmiObject -Class Win32_Battery).BatteryStatus
    $cpuLoad = (Get-Counter '\Processor(_Total)\% Processor Time').CounterSamples.CookedValue

    # Matikan Auto-Brightness tiap ganti pwrplan
    powercfg -setdcvalueindex $targetPlan SUB_VIDEO ADAPTBRIGHT 0
    powercfg -setacvalueindex $targetPlan SUB_VIDEO ADAPTBRIGHT 0

    # Ambang batas
    $cpuThreshold = 25  # persen
    $onBattery = ($powerStatus -eq 1)  # 1 = on battery, 2 = charging/plugged in

    # Power Plan GUIDs (ganti sesuai kepunyaan sendiri)
    $powerSaver = " "   # Power saver
    $balanced = " "     # Balanced
    $performance = " "  # High performance

    if ($onBattery -and $cpuLoad -lt $cpuThreshold) {
        # Hemat saat idle + baterai
        powercfg /s $powerSaver
    }
    elseif ($cpuLoad -ge $cpuThreshold) {
        # Performa saat CPU aktif
        powercfg /s $performance
    }
    else {
        # Default ke balanced
        powercfg /s $balanced
    }

    Start-Sleep -Seconds 5
}
