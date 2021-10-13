param (
[switch]$askLogin = $false
)

$null = (Invoke-WebRequest https://agnigarh.iitg.ac.in:1442/login?) -match '"magic" value="([^"]+)"'

if(($iitg_pass -eq $null) -or ($iitg_user -eq $null) -or $askLogin){
    $iitg_user = [uri]::EscapeDataString((Read-Host "Username"))
    $input_pass = Read-Host "Password" -AsSecureString
    $iitg_pass = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($input_pass))
}

Set-Variable -Name "iitg_magic" -Value ([uri]::EscapeDataString($Matches.1))

Set-Variable -Name "iitg_data" -Value "4Tredir=https%3A%2F%2Fagnigarh.iitg.ac.in%3A1442%2Flogin%3F&magic=$iitg_magic&username=$iitg_user&password=$iitg_pass"

$null = (Invoke-WebRequest -Uri https://agnigarh.iitg.ac.in:1442/ -Method POST -Body $iitg_data) -match "https://agnigarh.iitg.ac.in:1442/logout\?[0-9a-zA-z]+"
echo $Matches.0
