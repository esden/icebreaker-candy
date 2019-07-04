# Panel Test

Light up LED in different test patterns.

The User button on the iCEBreker performs a reset. The reset sets the state of
the color outputs back to "all off". The reset also sends the FM chip init
sequence. The FM init sequence is only sent out on reset and never again.

The Buttons on the "head pmod" sequence each color through 8 modes. The modes
are:

1: Off
2: all on
3: even columns on
4: odd columns on
5: even rows on
6: odd rows on
7: pixels that are both on even rows and columns on
8: pixels that are both on odd rows and columns on

