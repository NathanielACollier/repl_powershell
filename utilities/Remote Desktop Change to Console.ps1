
function run-qwinsta(){
    $pinfo = New-Object System.Diagnostics.ProcessStartInfo
    $pinfo.FileName = "cmd.exe"
    $pinfo.RedirectStandardError = $true
    $pinfo.RedirectStandardOutput = $true
    $pinfo.UseShellExecute = $false
    $pinfo.Arguments = "/C qwinsta"
    $p = New-Object System.Diagnostics.Process
    $p.StartInfo = $pinfo
    $p.Start() | Out-Null
    $p.WaitForExit()
    $stdout = $p.StandardOutput.ReadToEnd()
    $stderr = $p.StandardError.ReadToEnd()

    return [PSCustomObject]@{
        stdout= $stdout
        stderror = $stderr
        exitcode = $p.ExitCode
    }
}

function parse-qwinstaOutput(){
    param(
        [string]
        $outputText
    )

    $lines = $outputText.Split("`n")

    # first line is header so skip it, then the columns are tab delimited
    $lines | select -Skip 1 | foreach{
        $columns = $_.Split(" ") | where { -not [string]::IsNullOrWhiteSpace($_)} | foreach{ $_.Trim() }

    }
}

function get-ActiveConsole(){
    $results = run-qwinsta
    $entries = parse-qwinstaOutput $results.stdout
}

get-ActiveConsole