function Get-MidiTrackEvents {
    param (
        $bytes,
        $midiHeader 
    )
    $len = Get-MidiTrackLength $bytes
    $offset = 8
    $midiEvents = Get-MidiEventList
    $midiArray = @()
    while ($offset -lt $bytes.Length) {
        $varlen, $deltaTime = (Read-VarLenBytes $bytes[$offset..($offset + 3)])["length", "Value"]
        $offset += $varlen
        $Event = $midiEvents.Keys | Where-Object { $midiEvents[$_] -eq $bytes[($offset + 1 )] }

        if (($event.length -eq 0) -or ($event -eq 'EVENT_META_SEQUENCE_NUMBER')) {
            $offsetIncrement = 4
            $4bitEvent = $bytes[($offset + 1)] -shr 4 
            $EventSubType = $midiEvents.Keys | Where-Object { $midiEvents[$_] -eq $4bitEvent }
            $eventData = @{
                Channel  = [byte]($bytes[$offset + 1] -band 0x0f)
                pitch    = $bytes[($offset + 2)]
                Velocity = $bytes[($offset + 3)]
            }
            if ($eventData.Velocity -eq 0) {
                $EventSubType = 'EVENT_MIDI_NOTE_OFF'
            }
        }
        else {
            $offsetIncrement = $bytes[($offset + 3)] + 4
            $EventSubType = $midiEvents.Keys | ? { $midiEvents[$_] -eq $bytes[($offset + 2 )] }
            $eventData = , $bytes[($offset + 4)..($offset + $offsetIncrement - 1)]
        }

        $playtime = if ($deltaTime -eq 0) { 0 } else { $deltaTime * ($midiHeader.tickResolution / 1000 ) }
        $obj = [pscustomobject]@{
            playtime  = $playtime
            deltaTime = $deltaTime
            Event     = $Event
            SubType   = $EventSubType
            data      = $eventData

        }

        $midiArray += $obj
        $offset = $offset + $offsetIncrement 

    }
    return $midiArray
   
}
