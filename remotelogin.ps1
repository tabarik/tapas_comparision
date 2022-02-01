$PSVersionTable.PSVersion
<#<command-name> -<Required Parameter Name> <Required Parameter Value>
[-<Optional Parameter Name> <Optional Parameter Value>]
[-<Optional Switch Parameters>]
[-<Optional Parameter Name>] <Required Parameter Value>
#>
<#New-Alias [-Name] <string> [-Value] <string> [-Description <string>]
[-Force] [-Option {None | ReadOnly | Constant | Private | AllScope}]
[-PassThru] [-Scope <string>] [-Confirm] [-WhatIf] [<CommonParameters>]
The syntax is capitalized for readability, but PowerShell is case-insensitive.
ts alias, such a "gcm" for Get-Command.
#>
Get — To get something
Start — To run something
Out — To output something
Stop — To stop something that is running
Set — To define something
New — To create something<#
#>
Get-ExecutionPolicy
Get-Help -Name Get-Command -Full
Get-CimInstance -Class  Win32_LogicalDisk | Get-Member
Get-Service| Format-Table -Wrap
<#
gett - the details of date #>
(Get-Date).GetType()
Get-Alias
$var1 =1
$var1.GetType()
[int]$var1="2"
Write-Host "Found value $var1"
Get-Variable # for current session
get-something
$Error #Error is environment variable stores all values for the current session
$firstarray = @("Tapas","Baby","Little","Mama",8,5)
$firstarray[4]

#key Value pair 
$myhtable = @{"Fistname" ="Tapas"; "Lastname" ="Barik"}
$myhtable["Fistname"]
#if {} else {}
# regex -match 
#ctrl + j -snipet
<#
foreach ($item in $collection)
{
    
}

#>
$firstarray = @("Tapas","Baby","Little","Mama",8,5)
foreach($i in $firstarray)
{
    Write-Host $i
}

<#
.Synopsis
   Update service with stop or Restart
.DESCRIPTION
   Service will be start or stop based on start or stop status
.EXAMPLE
   Example of how to use this cmdlet
.EXAMPLE
   Another example of how to use this cmdlet
.INPUTS
   Inputs to this cmdlet (if any)
.OUTPUTS
   Output from this cmdlet (if any)
.NOTES
   General notes
.COMPONENT
   The component this cmdlet belongs to
.ROLE
   The role this cmdlet belongs to
.FUNCTIONALITY
   The functionality that best describes this cmdlet
#>
function Update-WindowsService
{
    [CmdletBinding()]
        
    Param
    (
        # Param1 help description
        [Parameter(Mandatory=$true, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                    Position=0)]        
        $ServiceName,

        # Param2 help description
        [Parameter(ParameterSetName='StopSet')]
        [switch]$Stop,

                # Param3 help description
        [Parameter(ParameterSetName='RestartSet')]
        [switch]$Restart
        
        )
    
    Begin
    {
        Write-Verbose "Updating Service $ServiceName....."
    }
    Process
    {
        if($Stop)
        {
            Set-Service -Name $ServiceName -Status Stopped
        }
        elseif($Restart)
        {
            Set-Service -Name $ServiceName -Status Running
        }
    }
    End
    {
        Write-Verbose " Service $ServiceName  Updated Successfully....."
    }
}
# This service requires to be run as administrator from Windows Powershell ISE
Get-PSProvider
# provider example cd HKLM:
<#1. Types of Error
.Terminating
Nn-terminating error#>
#whatif
Set-Service -Name ALG -Status Running
<#PS C:\WINDOWS\system32> Set-Service -Name ALG -Status Stopped -WhatIf
What if: Performing the operation "Set-Service" on target "Application Layer Gateway Service (ALG)".
Set-Service -Name ALG -Status Running -Confirm
#>
<#Powershell remoting -wsman -web services Management PRIOR TO WINDOWS REMOTE MANAGEMENT WAS DCOM
WINRM USES WSMAN WORK ON PORT HTTP /HTTPS PROTOCOL
TYPE OF REMOTING 
1. ADHOC REMOTING -DOES NOT NEED WINRM
2. INTERACTIVE REMOTING 
winrm service should be running , winrm powershel should be there . bY default 2012 there
But WIN7 winrm service not there 
#>
<#
[cmdletbinding(DefaultParameterSetName="Default")]
Param(
[Parameter(Position=0,Mandatory,HelpMessage="Enter the URI path starting with HTTP or HTTPS",
ValueFromPipeline,ValueFromPipelineByPropertyName)]
[ValidatePattern( "^(http|https)://" )]
[Alias("url")]
[string]$URI,
[Parameter(ParameterSetName="Detail")]
[Switch]$Detail,
[ValidateScript({$_ -ge 0})]
[int]$Timeout = 30
)
Begin {
    Write-Verbose -Message "Starting $($MyInvocation.Mycommand)" 
    Write-Verbose -message "Using parameter set $($PSCmdlet.ParameterSetName)" 
} #close begin block
Process {
    Write-Verbose -Message "Testing $uri"
    Try {
     #hash table of parameter values for Invoke-Webrequest
     $paramHash = @{
     UseBasicParsing = $True
     DisableKeepAlive = $True
     Uri = $uri
     Method = 'Head'
     ErrorAction = 'stop'
     TimeoutSec = $Timeout
    }
    $test = Invoke-WebRequest @paramHash
     if ($Detail) {
        $test.BaseResponse | 
        Select ResponseURI,ContentLength,ContentType,LastModified,
        @{Name="Status";Expression={$Test.StatusCode}}
     } #if $detail
     else {
       if ($test.statuscode -ne 200) {
            #it is unlikely this code will ever run but just in case
            Write-Verbose -Message "Failed to request $uri"
            write-Verbose -message ($test | out-string)
            $False
         }
         else {
            $True
         }
     } #else quiet
     
    }
    Catch {
      #there was an exception getting the URI
      write-verbose -message $_.exception
      if ($Detail) {
        #most likely the resource is 404
        $objProp = [ordered]@{
        ResponseURI = $uri
        ContentLength = $null
        ContentType = $null
        LastModified = $null
        Status = 404
        }
        #write a matching custom object to the pipeline
        New-Object -TypeName psobject -Property $objProp
        } #if $detail
      else {
        $False
      }
    } #close Catch block
} #close Process block
End {
    Write-Verbose -Message "Ending $($MyInvocation.Mycommand)"
} #close end block
 #close Test-URI Function

#>
Set-PSBreakpoint -Script "C:\Users\tabarik\OneDrive - Microsoft\Find_file_exist.ps1" -Line 7
Break point will apply on the scripts Find_file_exist.ps1 on line number 7 , continue by pressing F10
Get-Command "breakpoint"
Get-PSBreakpoint | remove-breakpoint
#>
Get-PSBreakpoint | remove-breakpoint
<#
TRY CATCH BLOCK
try
{
    1/0
}
catch [DivideByZeroException]
{
    Write-Host "Divide by zero exception"
}
catch [System.Net.WebException],[System.Exception]
{
    Write-Host "Other exception"
}
finally
{
    Write-Host "cleaning up ..."
}
#>
try
{
 $Testvariable = "This is test"
 Write-Host 'statement before the error'
 [System.IO.File]::ReadLines('c:\does\not\exists.txt')
 Write-Host 'statement after the error'
}
catch [System.IO.IOException]
{

    Write-Host "An Exception was caught"
    Write-Host "Exception type:$($_.Exception.GetType().FullName)"
}
catch [System.Net.WebException],[System.Exception]
{
    Write-Host "Some Other Exception was there"
}
finally
{
$Testvariable = "This Block was filnally executed"
    Write-Host "cleaning up ..."
}
$Testvariable
<#
$LASTEXITCODE
Any .exe file run successful

#>

 $?
<#It shows true if last command run successfullyTrue #>
Get-Command "*wmi"
Get-Command "*cim*"
Get-CimInstance -ClassName "CIM_NetworkAdapter"
<#
Visual basic editor
WHAT IS THE DIFFERENCE B/T CIM WMI COM OBJECTS
#>
Get-CimInstance -ClassName "win32_Directory"
Get-CimInstance -ClassName "win32_Directory" -Filter "Name = 'c:\\spanish'"
$ie = New-Object -ComObject InternetExplorer.Application 
$ie.Visible = $true
$ie.Navigate("www.google.com")
<#
close  site if someone type porn ,sex,illict contents-com object
#>
$sysdate = New-Object System.Datetime 2018,01,07
$sysdate
$mystring = New-Object System.String "My Fists .New object programme"
$mystring
$mystring.GetType()
$xmlfilesample = Get-Content C:\Users\tabarik\Downloads\sample_CustomersOrders.xml
[XML] $xmlfilesample = Get-Content C:\Users\tabarik\Downloads\sample_CustomersOrders.xml
$xmlfilesample
Add-Member -InputObject $xmlfilesample -MemberType NoteProperty -Name Description -Value "This is my first xml in powershell"
$xmlfilesample
<#
Create my .NET class of your choice
#>
$Source = @"
public class BasicTest
{
  public static int Add(int a, int b)
    {
        return (a + b);
    }
  public int Multiply(int a, int b)
    {
    return (a * b);
    }
}
"@

Add-Type -TypeDefinition $Source

[BasicTest]::Add(4, 3)
$BasicTestObject = New-Object BasicTest
$BasicTestObject.Multiply(5, 2)
<#
Create your own .Net Class in Powershell
#>
$myclassPsnew = @"
public class PSclass 
{
public string sayHello(){return "My fist .Net Class in Powershell class concept";}
} 
"@
Add-Type -TypeDefinition $myclassPsnew
$myclassinstance = New-Object PSclass
$myclassinstance.sayHello()

<#
How to Create own Form in Powershell
#>
$form = New-Object System.Windows.Forms.Form
$form.Text = "My Form !!"
$mybutton = New-Object System.Windows.Forms.Button
$mybutton.Text = "Click Me!!"
$mybutton.Dock = "Fill"
$form.Controls.Add($mybutton)
$mybutton.BackColor = "Green"
$form.AddOwnedForm({$form.Activate()})
$form.ShowDialog()
<#
You should create your moule 
help get-module 
Get public module from Powershell Gallery-https://github.com/Azure/azure-powershell
#>
<#
Save Module as .psm1. This module does not require .\ . We can just import the module by running command Import-Module .\firstps.psm1 
 .\firstps.psm1  -Module Name
#>
Get-Module -ListAvailable

function Add-num {
   function add-number ($a, $b)
   {
    $a=10
    $b =20
    return $b +$a
   
    }
    function sub-number ($a, $b)
   {
    $a=10
    $b =20
    return $b -$a
   
    }
    Get-PSProvider
    <#WinRM is the capability of WSman
    DCOM was there prior to inRM
    WinRM was introduced in Powershell 2.0 onwards
    1. Adhoc Remoting
    2. Interactive Remoting-Enabled WinRM remoting
    3. Persistent Remoting -Enabled WinRM remoting
    4. Implicit Remoting-Enabled WinRM remoting
    Server above WS 2012 R2  WinRM enabled
computername -give ip address if not domain joined 
 For more information on how to set TrustedHosts run the following command: winrm help config. For more information, see  
the about_Remote_Troubleshooting Help topic.
At line:1 char:1
    #>
    Enable-PSRemoting
    #Enter-PSSession -ComputerName "192.168.1.10" -Credential Get-Credential 
    #Enter-PSSession -ComputerName WIN-RBHTI62LERM -Credential Get-Credential
    <#
     For more information on how to set TrustedHosts run the following command: winrm help config. For more information, see  
the about_Remote_Troubleshooting Help topic.
At line:1 char:1
Then check below command whether host you are trying to remoting is added to trusted hosts lists
    #>

    Get-Item WSMan:\localhost\Client\TrustedHosts
    <#
    Get-Item WSMan:\localhost\Client\TrustedHosts

   WSManConfig: Microsoft.WSMan.Management\WSMan::localhost\Client

Type            Name                           SourceOfValue   Value                                                                                                                                                                                             
----            ----                           -------------   -----                                                                                                                                                                                             
System.String   TrustedHosts                                             
    #>
    Set-Item WSMan:\localhost\Client\TrustedHosts -Value "*"
    <#
    This computer will enable remote login for all the computers
        #>
# Exit-PSSession
#Get-Module -Name Microsoft.PowerShell.Management
#Import-PSSession
#Export-PSSession

        #persistent Remoting 
       # $myremotekingdom = New-PSSession -ComputerName "WIN-20UOUEOFV8R" -Credential Get-Credential
# Invoke-Command -Session $myremotekingdom -FilePath Invoke-Command -FilePath C:\Users\Administrator\Desktop\find_computername.ps1
        

