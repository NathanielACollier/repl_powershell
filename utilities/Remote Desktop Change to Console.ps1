
function Get-TSSessions {
    param(
        $ComputerName = "localhost"
    )

    qwinsta /server:$ComputerName |
    #Parse output
    ForEach-Object {
        $_.Trim() -replace "\s+",","
    } |
    #Convert to objects
    ConvertFrom-Csv
}

Get-TSSessions