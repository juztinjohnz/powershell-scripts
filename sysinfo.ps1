#This script uses Windows Management Instrumentation (WMI) and Common Information Model (CIM) to get system CPU, memory, operating system version,
#and uptime, IT also uses the Windows Forms assembly to create a GUI.
#To run this script, open Windows PowerShell and navigate to the directory where the script is saved. and type .\sysinfo.ps1 


# Import Windows Forms assembly
Add-Type -AssemblyName System.Windows.Forms

# Create a form
$form = New-Object System.Windows.Forms.Form
$form.Text = "System Information"
$form.Size = New-Object System.Drawing.Size(400, 200)
$form.StartPosition = "CenterScreen"
$form.FormBorderStyle = "FixedDialog"
$form.MaximizeBox = $false

# Create labels to display system information
$cpuLabel = New-Object System.Windows.Forms.Label
$cpuLabel.Location = New-Object System.Drawing.Point(10, 20)
$cpuLabel.Size = New-Object System.Drawing.Size(380, 20)

$ramLabel = New-Object System.Windows.Forms.Label
$ramLabel.Location = New-Object System.Drawing.Point(10, 50)
$ramLabel.Size = New-Object System.Drawing.Size(380, 20)

$osLabel = New-Object System.Windows.Forms.Label
$osLabel.Location = New-Object System.Drawing.Point(10, 80)
$osLabel.Size = New-Object System.Drawing.Size(380, 20)

$uptimeLabel = New-Object System.Windows.Forms.Label
$uptimeLabel.Location = New-Object System.Drawing.Point(10, 110)
$uptimeLabel.Size = New-Object System.Drawing.Size(380, 20)

# Get system information
$cpu = Get-WmiObject -Class Win32_Processor | Select-Object -ExpandProperty Name
$ram = Get-WmiObject -Class Win32_OperatingSystem | Select-Object -ExpandProperty FreePhysicalMemory
$ram = [math]::Round($ram / 1024 / 1024)
$os = Get-CimInstance -ClassName CIM_OperatingSystem | Select-Object -ExpandProperty Caption
$uptime = Get-CimInstance -ClassName Win32_OperatingSystem | Select-Object -ExpandProperty LastBootUpTime
$uptime = (Get-Date) - $uptime
$uptime = $uptime.TotalSeconds

# Set label text
$cpuLabel.Text = "CPU model name: $cpu"
$ramLabel.Text = "Free RAM: $ram MB"
$osLabel.Text = "Operating system version: $os"
$uptimeLabel.Text = "Uptime: $uptime seconds"

# Add labels to form
$form.Controls.Add($cpuLabel)
$form.Controls.Add($ramLabel)
$form.Controls.Add($osLabel)
$form.Controls.Add($uptimeLabel)

# Show form
$form.ShowDialog() | Out-Null
