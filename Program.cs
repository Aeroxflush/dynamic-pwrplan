using System;
using System.Diagnostics;
using System.IO;
using System.Reflection;

namespace DynamicPowerPlan
{
    static class Program
    {
        [STAThread]
        static void Main()
        {
            try
            {
                // Path temp buat nyimpan sementara script
                string tempScript = Path.Combine(Path.GetTempPath(), "dynamic_powerplan.ps1");

                // Ambil isi resource .ps1 yang di-embed
                using (Stream stream = Assembly.GetExecutingAssembly()
                    .GetManifestResourceStream("DynamicPowerPlan.dynamic_powerplan.ps1"))
                using (StreamReader reader = new StreamReader(stream))
                {
                    File.WriteAllText(tempScript, reader.ReadToEnd());
                }

                // Jalankan script dari file sementara
                ProcessStartInfo psi = new ProcessStartInfo
                {
                    FileName = "powershell.exe",
                    Arguments = $"-ExecutionPolicy Bypass -WindowStyle Hidden -File \"{tempScript}\"",
                    CreateNoWindow = true,
                    UseShellExecute = false,
                    WindowStyle = ProcessWindowStyle.Hidden
                };

                Process.Start(psi);
            }
            catch (Exception ex)
            {
                File.AppendAllText(Path.Combine(Path.GetTempPath(), "launcher_error.log"),
                    $"[{DateTime.Now}] {ex.ToString()}\n");
            }
        }
    }
}
