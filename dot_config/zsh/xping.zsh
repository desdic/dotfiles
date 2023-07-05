if [ -x /sbin/xping ]; then
    alias xping='xping -B'
fi
if [ -x /sbin/xping-http ]; then
    alias xping-http='xping-http -B'
fi
