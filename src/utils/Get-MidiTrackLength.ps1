function Get-MidiTrackLength {
    param (
        [byte[]]$bytes
    )
    $trackHeader = Read-AsciiHeaderBytes $bytes[0..3]
    if ($trackHeader -ne 'Mtrk') {
        throw 'Invalid Midi Track Header'
    }
    return Read-Int32Bytes $bytes[4..7]
}