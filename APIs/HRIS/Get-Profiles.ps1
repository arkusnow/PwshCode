function Get-Profiles {
    [CmdletBinding()]
 
    param (
        $Token = "tokenHere",

        $Page = ("1", "2", "3", "4", "5", "6"),

        $nprofile = $null
    )

        begin {
            $Header = @{
                "Authorization" = "Bearer $Token"
            }
            $Parameters = @{
                Method = "GET"
                Uri = "enter URI here"
                Headers = $Header
                ContentType = "application/json"
            }

        }
        process {
            foreach ($number in $Page) {
                $Parameters["Uri"] = "https://yourdomain.com/api/v1/profiles.json?page=$number&per_page=50&filter[user_status]=active"
                $nprofile = Invoke-RestMethod @Parameters
        
            }
            
            $nprofile.profiles
        }
        end {
        }
    }