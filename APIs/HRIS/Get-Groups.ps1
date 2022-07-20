function Get-Groups {
    [CmdletBinding()]
    param (
        $Token = "token"
    )
    begin {
        $Header = @{
            "Authorization" = "Bearer $Token"
        }
        $Parameters = @{
            Method = "GET"
            Uri = "https://yourdomain.com/api/v1/groups.json"
            Headers = $Header
            ContentType = "application/json"
        }
    }
    process {
        $ngroups = Invoke-RestMethod @Parameters
        $ngroups.groups
    }
    end {
    }
}

