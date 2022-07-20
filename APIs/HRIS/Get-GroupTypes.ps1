function Get-GroupTypes {
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
            Uri = "https://yourdomain.com/api/v1/group_types.json"
            Headers = $Header
            ContentType = "application/json"
        }
    }
    process {
        $ngrouptypes = Invoke-RestMethod @Parameters
        $ngrouptypes.group_types
    }
    end {
    }
}

