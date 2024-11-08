# Create Local account called svc_schedule_task
$Password = ConvertTo-SecureString -String 'Strong_Password' -AsPlainText -Force
$params = @{
    Name        = 'svc_schedule_task'
    Password    = $Password
    Description = 'Service account for schedule task'
}
# Account password never expired and user cannot change password
New-LocalUser @params -PasswordNeverExpires - UseMayNotChangePassword
# Add the account into Administrators group
Add-LocalGroupMember -Group "Administrators" -Member "svc_schedule_tasl"
