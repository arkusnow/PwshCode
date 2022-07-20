function Get-JobTitles {
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
            Uri = "https://yourdomain.com/api/v1/job_titles.json"
            Headers = $Header
            ContentType = "application/json"
        }
    }
    process {
        $njobtitle = Invoke-RestMethod @Parameters
        $njobtitle.job_titles

    }
    end {
    }
}

