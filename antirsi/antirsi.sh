#!/bin/sh -euo pipefail

mkdir -p "$HOME/var"
STATE_FILE="$HOME/var/antirsi.timestamp"

now=$( date +%s )

if [ -f $STATE_FILE ]; then
    timestamp=$( stat -f %m "$STATE_FILE" )
else
    let timestamp="$now - 1"
    touch $STATE_FILE
fi

case "${1:-}" in
    on)
        touch $STATE_FILE
        open -a AntiRSI -g
        ;;

    off)
        hours="${2:-1}"
        let timestamp="$now + ($hours * 3600)"
        perl -e "utime $timestamp, $timestamp, '$STATE_FILE';"
        pid=$(ps x | grep '[A]ntiRSI' | awk '{ print $1 }')
        [ -n "$pid" ] && kill $pid
        ;;

    '')
        if [ "$timestamp" -lt $now ]; then
            open -a AntiRSI -g
        fi
        ;;

    *)
        cat <<'        EOF' | sed -e 's/^            //'
            antirsi -- control whether AntiRSI is running

            Usage:
                antirsi on          start AntiRSI now
                antirsi off [n]     turn AntiRSI off for n hours (default: 1)
                antirsi             start AntiRSI if it is time to

            Add "*/5 * * * antirsi" to your crontab to have AntiRSI automatically
            restart if you quit it, whilst still being able to run 'antirsi off'
            to have it stop for a while (eg. when playing games).
        EOF
        ;;
esac
