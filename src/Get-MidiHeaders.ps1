function Get-MidiHeaders {
    param (
        $bytes
    )
    $headerAscii = [char[]]$bytes[0..3] -join ''

    if ($headerAscii -ne 'MThd') {
        throw "Invalid Midi File header"
    }

    $MidiFileHeader = [pscustomobject]@{
        HeaderChunkLength = Read-Int32Bytes $bytes[4..7]
        MidiFormat        = Read-Int16Bytes $bytes[8..9]
        TrackCount        = Read-Int16Bytes $bytes[10..11]
        TickDivision      = Read-Int16Bytes $bytes[12..13] 
        HeaderLength      = (Read-Int32Bytes $bytes[4..7]) + 8
        Resolution        = Get-MidiResolution -tickDiv (Read-Int16Bytes $bytes[12..13])
    }

    return $MidiFileHeader

}