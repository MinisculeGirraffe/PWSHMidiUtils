function Read-Int32Bytes {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateCount(4, 4)]
        [byte[]]
        $bytes
    )
    if ([System.BitConverter]::IsLittleEndian) {
        [Array]::Reverse($bytes)
    }
    return [BitConverter]::ToInt32($bytes,0)
}