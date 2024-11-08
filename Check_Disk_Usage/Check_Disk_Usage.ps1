Function Get-DiskSpace {
	Get-WmiObject Win32_Volume |Where { $_.drivetype -eq '3' -and $_.driveletter} |
		Select driveletter, label, @{LABEL='Capacity';EXPRESSION={"{0:N2}" -f ($_.Capacity/1GB)} }, 
			@{LABEL='Disk_Usage';EXPRESSION={"{0:N2}" -f (($_.Capacity - $_.freespace)*100/$_.Capacity)} }, 
			@{LABEL='GBfreespace';EXPRESSION={"{0:N2}" -f ($_.freespace/1GB)} }
}

$css = Get-Content C:\Scripts\conf_mail_css.txt
$server = "<Server_Name>"
$Email_From = "<From_Email>"
$Email_To = "<To_Email>"
$smtpserver = "<smtp_server>"
$smtp_port = "<smtp_port>"

$disk = Get-DiskSpace | ConvertTo-Html -Head $css -Body "<h1>$server Disk Usage</h1>"
Send-MailMessage -From $Email_From -To $Email_To -SmtpServer $smtpserver -Port $smtp_port -subject "$server Disk Usage Report" -Body ($disk | Out-String) -BodyAsHtml
