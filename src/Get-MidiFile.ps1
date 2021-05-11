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
    $MidiHeader = Get-MidiHeaders $fileBytes



}
    
