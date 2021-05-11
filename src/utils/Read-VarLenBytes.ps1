function Read-VarLenBytes {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateCount(1, 4)]
        [byte[]]
        $bytes
    )
    $v = 0
    $i = 0
    while (4 -gt $i) {
        $b = $bytes[$i]
        if ($b -band 0x80) {
            $v += $b -band 0x7f
            $v = $v -shl 7
            $i += 1
        }
        else {
            return @{
                value  = ($v + $b)
                length = $i
            }
        }
    }
    throw "Varlen cannot be longer than 4 bytes"
}