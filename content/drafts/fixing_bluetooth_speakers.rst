If connected but no sound, first check in pavucontrol settings.
It should be benabled as an a2dp device

If you do this and still no sound, kill pulseaudion


pulseaudio --kill

If it cannot connect / pair:
    remove the device
    set scan to off
    scna on
    pair to device
    connect to device

