function Get-Events {
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
            Uri = "https://yourdomain.com/api/v1/events.json"
            Headers = $Header
            ContentType = "application/json"
        }
    }
    process {
        $nevents = Invoke-RestMethod @Parameters
        $nevents.events
    }
    end {
    }
}

