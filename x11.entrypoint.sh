#!/bin/sh

if [[ -n "$VNCPASS" ]]; then
    sed -i 's/-localhost //' /etc/supervisor/conf.d/x11vnc.conf 
    sed -i "s/-nopw/-passwd $VNCPASS/" /etc/supervisor/conf.d/x11vnc.conf 
fi

exec "$@"