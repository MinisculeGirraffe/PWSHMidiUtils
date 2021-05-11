function Get-MidiEventList {
    return @{
        #EventTypes
        EVENT_META                     = 0xff
        EVENT_SYSEX                    = 0xf0
        EVENT_DIVSYSEX                 = 0xf7
        EVENT_MIDI                     = 0x8
        EVENT_META_SEQUENCE_NUMBER     = 0x00
        EVENT_META_TEXT                = 0x01
        EVENT_META_COPYRIGHT_NOTICE    = 0x02
        EVENT_META_TRACK_NAME          = 0x03
        EVENT_META_INSTRUMENT_NAME     = 0x04
        EVENT_META_LYRICS              = 0x05
        EVENT_META_MARKER              = 0x06
        EVENT_META_CUE_POINT           = 0x07
        EVENT_META_MIDI_CHANNEL_PREFIX = 0x20
        EVENT_META_END_OF_TRACK        = 0x2f
        EVENT_META_SET_TEMPO           = 0x51
        EVENT_META_SMTPE_OFFSET        = 0x54
        EVENT_META_TIME_SIGNATURE      = 0x58
        EVENT_META_KEY_SIGNATURE       = 0x59
        EVENT_META_SEQUENCER_SPECIFIC  = 0x7f
        EVENT_MIDI_NOTE_OFF            = 0x8
        EVENT_MIDI_NOTE_ON             = 0x9
        EVENT_MIDI_NOTE_AFTERTOUCH     = 0xa
        EVENT_MIDI_CONTROLLER          = 0xb
        EVENT_MIDI_PROGRAM_CHANGE      = 0xc
        EVENT_MIDI_CHANNEL_AFTERTOUCH  = 0xd
        EVENT_MIDI_PITCH_BEND          = 0xe
    }
    
}