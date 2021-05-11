function Get-MidiFile {
    param (
        [Parameter(Mandatory = $true)]
        [string]
        $path
    )
    $fileBytes = [System.IO.File]::ReadAllBytes($path)
    if (25 -gt $fileBytes.Length) {
        throw "Minimum length for a valid Midi file is 25 bytes"
    }
    $MidiFileHeader = Get-MidiHeaders $fileBytes

    $tracks = @()
  
    $TrackOffset = $MidiFileHeader.HeaderLength
    while (($trackLength + $TrackOffset) -lt $fileBytes.Length) {
        $TrackBytes = $fileBytes[$TrackOffset..($fileBytes.Length - 1)]
        $trackLength = Get-MidiTrackLength -bytes $TrackBytes
   
        $Tracks += [pscustomobject]@{
            TrackContent = [byte[]]$fileBytes[$TrackOffset..$trackLength]
            TrackBounds  = @{
                start = $TrackOffset
                end   = $TrackOffset + $trackLength + 8
            }
            TrackEvents = $null
        }
        $TrackOffset += $trackLength + 8
    }


    foreach ($track in $tracks) {
      $track.TrackEvents = Get-MidiTrackEvents $fileBytes[$track.TrackBounds.start..$track.TrackBounds.end]  -midiheader $MidiFileHeader
      return $track 
    }

}
    
