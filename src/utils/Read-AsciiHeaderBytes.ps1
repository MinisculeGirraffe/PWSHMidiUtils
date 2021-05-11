function Read-AsciiHeaderBytes {
    param (
        $bytes
    )
    return [char[]]$bytes -join ''
    
}