function Get-ProfileFields {
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
            Uri = "https://yourdomain.com/api/v1/profiles/fields.json"
            Headers = $Header
            ContentType = "application/json"
        }
    }
    process {
        $nprofilefield = Invoke-RestMethod @Parameters
        $nprofilefield.fields
    }
    end {
    }
}





