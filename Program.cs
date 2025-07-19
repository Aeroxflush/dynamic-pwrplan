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
            string tempScript = Path.Combine(Path.GetTempPath(), "dynamic_powerplan.ps1");

            try
            {
                // Hapus jika temp file udah ada
                if (File.Exists(tempScript))
                    File.Delete(tempScript);

                // Ambil isi resource .ps1 yang di-embed
                var resourceName = "DynamicPowerPlan.dynamic_powerplan.ps1";
                using (Stream stream = Assembly.GetExecutingAssembly().GetManifestResourceStream(resourceName))
                {
                    if (stream == null)
                        throw new FileNotFoundException("Embedded script tidak ditemukan.", resourceName);

                    using (StreamReader reader = new StreamReader(stream))
                    {
                        // Script ditulis sementara ke folder Temp
                        File.WriteAllText(tempScript, reader.ReadToEnd());
                    }
                }

                // Jalankan script dari folder Temp
                var psi = new ProcessStartInfo
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
                File.AppendAllText(Path.Combine(Path.GetTempPath(), "dynamic-Pwrplan_error.log"),
                    $"[{DateTime.Now}] {ex}\n");
            }
        }
    }
}
