#Midi Resolution is Microseconds per tick Or Microseconds per frame
function Get-MidiResolution {
    param (
        [int16]$tickDiv,
        #Default midi tempo is 120 BPM or 500000 Microseconds per beat
        [int]$tempo = 500000
    ) 
    switch ($MidiFileHeader.TickDivision -band 0x8000) {
        #Ticks
        0 {
            return @{
                Resolution   = $tempo / $tickDiv
                TicksPerBeat = $tickDiv
            }
        }
        #SMTPE FRAMES
        { $_ -ne 0 } {
            $smtpeFrames = $tickDiv -band 0x7f00
            if (@(24, 25, 29, 30).IndexOf($smtpeFrames) -eq -1) {
                throw 'Invalid SMTPE frame header'
            }
            if ($smtpeFrames -eq 29) {
                $smtpeFrames = 29.97
            }
            $TicksPerFrame = $smtpeFrames -band 0x00ff
            return @{
                SmtpeFrames   = $smtpeFrames
                TicksPerFrame = $TicksPerFrame
                Resolution    = 1000000 / ($smtpeFrames * $TicksPerFrame)
            }
            
        }

    }

}