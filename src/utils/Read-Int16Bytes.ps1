function Read-Int16Bytes {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateCount(2, 2)]
        [byte[]]
        $bytes
    )
    if ([System.BitConverter]::IsLittleEndian) {
        [Array]::Reverse($bytes)
    }
    return [BitConverter]::ToInt16($bytes, 0)
}