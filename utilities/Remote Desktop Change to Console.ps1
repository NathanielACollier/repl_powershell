
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

function get-ActiveConsole(){
    $results = run-qwinsta
    
}

get-ActiveConsole