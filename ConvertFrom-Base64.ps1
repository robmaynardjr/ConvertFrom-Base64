<#
.Synopsis
   Convert a string of Base64 encoded text to plaintext
.DESCRIPTION
   This cmdlet can cconvert a string of Base64 text and convert it to plaintext. It can display the output in the host or to a file.
.EXAMPLE
   ConvertFrom-Base64 -code "<Base64EncodeText>" -OutFile -Path <FilePath>
.EXAMPLE
   cfb64 -code "<Base64EncodeText>" -OutFile -Path <FilePath>
.EXAMPLE
   ConvertFrom-Base64 -code "<Base64EncodeText>"
.EXAMPLE
    cfb64 -code "<Base64EncodeText>"
.EXAMPLE
    ConvertFrom-Base64 -code "<Base64EncodeText>" -OutFile
.AUTHOR
    Rob Maynard Jr.
#>
function ConvertFrom-Base64
{
    [CmdletBinding()]
    [Alias("cfb64")]
    [OutputType([string])]
    Param
    (
        # Param1 help description
        [Parameter(Mandatory=$true,
                    ValueFromPipeline=$true,
                    ValueFromPipelineByPropertyName=$true,
                    Position=0)]
        $Code,
        [Parameter(Mandatory=$false,
                    ValueFromPipelineByPropertyName=$false,
                    Position=1)]
                   
        [switch]$OutFile,

        $Path
    )

    Begin
    {
        Clear-Host
    }
    Process
    {
        try
        {
            $output = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($code))        
        }
        catch
        {
            Write-Error "Please make sure this the parameter is Base64"
            break
        }
    }
    End
    {
        if ($OutFile -eq $true)
        {
            if ($Path -ne $null)
            {
                try
                {
                    $output | Out-File -FilePath $Path
                }
                catch
                {
                    Write-Error "Please make sure the path parameter is a valid file path."
                    break
                }
            }
            else
            {
               $filePath = ((Get-Location).path)
               $output | Out-File -FilePath ($filePath + "\" + "output.txt")
            }
        }
        else
        {
            $output
        }
    }
}