#requires -module EnhancedHTML2
<#
.SYNOPSIS
Generates an HTML-based system report for one or more computers.
Each computer specified will result in a separate HTML file; 
specify the -Path as a folder where you want the files written.
Note that existing files will be overwritten.

.PARAMETER ComputerName
One or more computer names or IP addresses to query.

.PARAMETER Path
The path of the folder where the files should be written.

.PARAMETER CssPath
The path and filename of the CSS template to use. 

.EXAMPLE
.\New-HTMLSystemReport -ComputerName ONE,TWO `
                       -Path C:\Reports\ 
#>
[CmdletBinding()]
param(
    $Token = "token",

    $Page = ("1", "2", "3", "4", "5", "6"),

    $nprofile = $null
)
BEGIN {
    Remove-Module EnhancedHTML2
    Import-Module EnhancedHTML2
}
PROCESS {

    $style = @"
    body {
        color:#333333;
        font-family:Calibri,Tahoma;
        font-weight:normal;
        font-size: 8pt;
    }
    
    h1 {
        text-align:center;
    }
    
    h2 {
        border-top:1px solid #666666;
    }
    
    th {
        font-weight:normal;
        color:#eeeeee;
        background-color:#333333;
        cursor:pointer;
    }
    
    .odd  { background-color:#ffffff; }
    
    .even { background-color:#dddddd; }
    
    .paginate_enabled_next, .paginate_enabled_previous {
        cursor:pointer; 
        border:1px solid #222222; 
        background-color:#dddddd; 
        padding:2px; 
        margin:4px;
        border-radius:2px;
    }
    
    .paginate_disabled_previous, .paginate_disabled_next {
        color:#666666; 
        cursor:pointer;
        background-color:#dddddd; 
        padding:2px; 
        margin:4px;
        border-radius:2px;
    }
    
    .dataTables_info { margin-bottom:4px; }
    
    .sectionheader { cursor:pointer; }
    
    .sectionheader:hover { color:red; }
    
    .grid { width:100% }
    
    .red {
        color:red;
        font-weight:bold;
    } 
"@
function Get-Profiles {
    begin {
        $Header = @{
            "Authorization" = "Bearer $Token"
        }
        $Parameters = @{
            Method = "GET"
            Uri = "https://yourdomain.com/api/v1/profiles.json?page=1&per_page=50&filter[user_status]=active"
            Headers = $Header
            ContentType = "application/json"
        }
    }
    process {
        foreach ($number in $Page) {
            $Parameters["Uri"] = "https://yourdomain.com/api/v1/profiles.json?page=$number&per_page=50&filter[user_status]=active"
            $nprofile = Invoke-RestMethod @Parameters
            $nprofile.profiles
        }
    }
    end {
    }
}

function Get-ProfileFields {
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

function Get-JobTitles {
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

function Get-JobTitleDetail {
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

function Get-Groups {
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

function Get-GroupTypes {
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

$parms = @{
    'As'='Table';
    'PreContent'='<h2>Profiles<h2>';
    'EvenRowCssClass'='even';
    'OddRowCssClass'='odd';
    'MakeTableDynamic'=$true;
    'TableCssClass'='grid';
    'Properties'='first_name',
        'last_name','full_name','email','job_title','employee_type'
}
$profilehtml = Get-Profiles | ConvertTo-EnhancedHTMLFragment @parms 

$ProfileFieldPrms = @{
    'As'='Table';
    'PreContent'='<h2>ProfileFields<h2>';
    'EvenRowCssClass'='even';
    'OddRowCssClass'='odd';
    'MakeTableDynamic'=$true;
    'TableCssClass'='grid';
    'Properties'='label', 'name'
}
$ProfileFieldHTML = Get-ProfileFields | ConvertTo-EnhancedHTMLFragment @ProfileFieldPrms

$JobTitlePrms = @{
    'As'='Table';
    'PreContent'='<h2>JobTitles<h2>';
    'EvenRowCssClass'='even';
    'OddRowCssClass'='odd';
    'MakeTableDynamic'=$true;
    'TableCssClass'='grid';
    'Properties'='title', 'active'
}
$JobTitleHTML = Get-JobTitles | ConvertTo-EnhancedHTMLFragment @JobTitlePrms

$GroupPrms = @{
    'As'='Table';
    'PreContent'='<h2>Groups<h2>';
    'EvenRowCssClass'='even';
    'OddRowCssClass'='odd';
    'MakeTableDynamic'=$true;
    'TableCssClass'='grid';
    'Properties'='title', 'type', 'count', 'is_team', 'links'
}
$GroupHTML = Get-Groups | ConvertTo-EnhancedHTMLFragment @GroupPrms

$GroupTypePrms = @{
    'As'='Table';
    'PreContent'='<h2>Group Types<h2>';
    'EvenRowCssClass'='even';
    'OddRowCssClass'='odd';
    'MakeTableDynamic'=$true;
    'TableCssClass'='grid';
    'Properties'='title', 'x_groups_as_teams'
}
$GroupTypeHTML = Get-GroupTypes | ConvertTo-EnhancedHTMLFragment @GroupTypePrms

$prms = @{
    'CssStyleSheet'=$style;
    'Title'="NamelyReport";
    'PreContent'="<h1>Namely Report</h1>";
    'HTMLFragments'=@($profilehtml,$ProfileFieldHTML,$JobTitleHTML,$GroupHTML,$GroupTypeHTML)
}

ConvertTo-EnhancedHTML @prms | out-file -FilePath C:\Users\$env:username\Documents\HRIS-API-Report_$( get-date -Format MM-dd-yy_HHmm-ss ).html

}
