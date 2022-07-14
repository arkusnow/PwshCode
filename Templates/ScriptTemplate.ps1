#requires -version 2
<#
##################################
##                              ##
##    ArkusNow | ProjectsNow    ##
##                              ##
##################################
.SYNOPSIS
  <Overview of script>
.DESCRIPTION
  <Brief description of script>
.PARAMETER <Parameter_Name>
    <Brief description of parameter input required. Repeat this attribute if required>
.INPUTS
  <Inputs if any, otherwise state None>
.OUTPUTS
  <Outputs if any, otherwise state None - example: Log file stored in C:\Windows\Temp\<name>.log>
.NOTES
  Version:        1.0
  Author:         <Name>
  Creation Date:  <Date>
  Purpose/Change: Initial script development
  
.EXAMPLE
  <Example goes here. Repeat this attribute for more than one example>
#>

#---------------------------------------------------------[Initializations]--------------------------------------------------------

#Set Error Action to Silently Continue
#$ErrorActionPreference = "SilentlyContinue"

#Dot Source required Function Libraries
#. "C:\Scripts\Functions\Logging_Functions.ps1"

#----------------------------------------------------------[Declarations]----------------------------------------------------------

#Script Version
#$sScriptVersion = "1.0"

#Log File Info
#$sLogPath = "C:\Windows\Temp"

#$sLogName = "<script_name>.log"

#$sLogFile = Join-Path -Path $sLogPath -ChildPath $sLogName

#-----------------------------------------------------------[Functions]------------------------------------------------------------

<#
Function <FunctionName>{
  Param()
  
  Begin{
  }
  
  Process{
    Try{
    }
    
    Catch{
      Break
    }
  }
  
  End{
  }
}
#>

#-----------------------------------------------------------[Execution]------------------------------------------------------------

#Start-Transcript -Path "$Transcriptdir\<ScriptName>_Transcript $( get-date -Format MM-dd-yy_HHmm-ss ).txt" -Verbose

#Script Execution goes here

#Stop-Transcript