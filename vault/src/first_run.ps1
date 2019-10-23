# define CLI parameters
param (
    [Parameter(Mandatory=$true)] [string]$hostname,
    [Parameter(Mandatory=$true)] [string]$username,
    [Parameter(Mandatory=$true)] [string]$password,
	[Parameter(Mandatory=$true)] [string]$firstname,
	[Parameter(Mandatory=$true)] [string]$lastname,
	[Parameter(Mandatory=$true)] [string]$email
)
function Get-Base64String {
    # base64 encode a string
    param ([String]$plaintext)

    $bytearr = [System.Text.Encoding]::UTF8.GetBytes($plaintext)
    return [Convert]::ToBase64String($bytearr)
}

# check if we've already been through the first-run process. if so, don't do it again
$file_exists = Test-Path C:\OPSWAT\first-run.complete
if ($file_exists)
{
    Write-Host "First run has already been completed. No need to run it again."
} else {
    Write-Host "Starting First-run configuration process"
    
    # build the request object
    $b64_password = Get-Base64String($password)
    $request = @{
        first_name = $firstname
        last_name = $lastname
        user_name = $username
        password = $b64_password
        confirm_password = $b64_password
        email = $email
    }

    # send the first-run configuration
    try {
        $result = Invoke-RestMethod -Uri ("http://{0}:8000/vault_rest/usersetup" -f $hostname) -Body (ConvertTo-Json $request) -Method Post
    }
    catch {
        Write-Host "A first-run error occurred."
        Write-Host $_
    }
    finally {
        # stash a file on the filesystem telling us that we've already been through the first-run config
        echo $null > C:\OPSWAT\first-run.complete
    }

}
