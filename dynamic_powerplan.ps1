while ($true) {
    $powerStatus = (Get-WmiObject -Class Win32_Battery).BatteryStatus
    $cpuLoad = (Get-Counter '\Processor(_Total)\% Processor Time').CounterSamples.CookedValue

    # Ambang batas / Threshold
    $cpuThreshold = 25  # persen
    $onBattery = ($powerStatus -eq 1)  # 1 = on battery, 2 = charging/plugged in

    # Power Plan GUIDs (ganti sesuai kepunyaan sendiri)
    $powerSaver = " "   # Power saver
    $balanced = " "     # Balanced
    $performance = " "  # High performance

    if ($onBattery -and $cpuLoad -lt $cpuThreshold) {
        # Hemat saat idle + baterai
        $targetPlan = $powerSaver
    }
    elseif ($cpuLoad -ge $cpuThreshold) {
        # Performa saat CPU aktif
        $targetPlan = $performance
    }
    else {
        # Default ke balanced
        $targetPlan = $balanced
    }

    # Matikan Auto-Brightness
    powercfg -setdcvalueindex $targetPlan SUB_VIDEO ADAPTBRIGHT 0
    powercfg -setacvalueindex $targetPlan SUB_VIDEO ADAPTBRIGHT 0

    # Apply plan
    powercfg /s $targetPlan

    # Set brightness secara paksa setelah ganti plan
    $brightnessLevel = 30  # Bisa kamu sesuaikan
    (Get-WmiObject -Namespace root/wmi -Class WmiMonitorBrightnessMethods).WmiSetBrightness(1, $brightnessLevel)

    Start-Sleep -Seconds 5
}