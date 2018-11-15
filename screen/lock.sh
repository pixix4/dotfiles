#!/bin/bash
TMPBG=/tmp/screen.png
LOCK=~/dotfiles/screen/lock_darken.png
RES=1920x1080

#ffmpeg -f x11grab -video_size $RES -y -i $DISPLAY -i $LOCK -filter_complex "boxblur=16:8,overlay=(main_w-overlay_w)/2:(main_h-overlay_h)/2" -vframes 1 $TMPBG
ffmpeg -f x11grab -video_size $RES -y -i $DISPLAY -i $LOCK -filter_complex "overlay=0:0,boxblur=16:8" -vframes 1 $TMPBG

let COUNT=`pactl list | grep "State: RUNNING" | wc -l`
let MUTE=`amixer -D pulse sget Master | grep "off" | wc -l`

MUTE=false
UNBLOCK=false
for var in "$@"
do
    if [ "$var" == "--mute" ] ; then
        MUTE=true
    fi
    if [ "$var" == "--unblock" ] ; then
        UNBLOCK=true
    fi
done

if [ "$MUTE" == true ] ; then
    amixer -q -D pulse sset Master mute
    mpc pause
fi

B='#00000000'  # blank
C='#00000033'  # clear ish
D='#013766dd'  # default
T='#ffffffee'  # text
W='#dd0000cc'  # wrong
BS='#ff0000cc'  # backspace
V='#4ee1e0dd'  # verifying

I='#aad3eddd'  # input

BLOCK_STRING='-n'
if [ "$UNBLOCK" == true ]; then
    BLOCK_STRING=''
fi

i3lock -c 101010 -i $TMPBG $BLOCK_STRING -f   \
-k --indicator \
\
--insidevercolor=$C      \
--ringvercolor=$V        \
\
--insidewrongcolor=$C    \
--ringwrongcolor=$W      \
\
--insidecolor=$C         \
--ringcolor=$D           \
--linecolor=$B           \
--separatorcolor=$D      \
\
--timecolor=$T           \
--datecolor=$T           \
--verifcolor=$T          \
--wrongcolor=$T          \
--timecolor=$T           \
--keyhlcolor=$I          \
--bshlcolor=$BS          \
--timestr="%H:%M"        \
--datestr="%A, %d %b %Y" \
--veriftext="verifying…" \
--wrongtext="wrong!"     \
--wrongtext="clean"      \
--timesize=28            \
--datesize=12            \
--layoutsize=24          \
--verifsize=24           \
--wrongsize=24           \

COUNT=0

if [ $COUNT -eq 0 ] && [ $MUTE == false ]; then
    amixer -q -D pulse sset Master unmute
fi


