#!/bin/sh
pass_file=/etc/tigervnc.pass

if [[ -n "$VNCPASS" ]]; then
    echo "$VPNCPASS" | vncpasswd -f > "$pass_file"
    sed -i 's/-localhost //' /etc/supervisor/conf.d/tigervnc.conf 
    sed -i "s#-SecurityTypes None#-rfbauth $pass_file#" /etc/supervisor/conf.d/tigervnc.conf 
fi

exec "$@"