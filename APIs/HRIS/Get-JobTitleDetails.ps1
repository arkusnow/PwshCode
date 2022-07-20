function Get-JobTitleDetail {
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
            Uri = "https://yourdomain.com/api/v1/job_titles/{id}.json"
            Headers = $Header
            ContentType = "application/json"
        }
    }
    process {
        $nWHtech = Invoke-RestMethod @Parameters
        $nWHtech.job_titles
    }
    end {
    }
}

