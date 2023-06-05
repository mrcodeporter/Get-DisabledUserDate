function Get-DisabledUserDate {
    # Clear the console
    Clear-Host

    # Import the Active Directory module
    Import-Module ActiveDirectory > $null

    # Ask for the username to query
    $userName = Read-Host -Prompt 'Input the username'

    # Get the user object from Active Directory
    $userObject = Get-ADUser -Identity $userName -Properties whenChanged, GivenName, Surname, Enabled 2> $null

    # Check if the account is disabled
    if ($userObject.Enabled -eq $false) {
        # Output the user's first name, last name, and the date the account was disabled
        $result = New-Object PSObject -Property @{
            FirstName = $userObject.GivenName
            LastName = $userObject.Surname
            DateDisabled = $userObject.whenChanged
        }
        $result | Format-Table -AutoSize
    } else {
        Write-Output "Account is not disabled or does not exist."
    }
}

# Call the function
Get-DisabledUserDate
