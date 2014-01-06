#!/bin/sh
teststring="blah blah blah"

for pastebin in $(./pastebinit -l | egrep "^-" | sed "s/^- //g")
do
    echo "Trying http://$pastebin"
    URL=$(echo "$teststring\n$teststring\n$teststring" | ./pastebinit -b http://$pastebin)

    if [ "$pastebin" = "paste.ubuntu.org.cn" ]; then
        out=$(wget -O - -q "$URL" | gzip -d | grep "$teststring")
    else
        out=$(wget -O - -q "$URL" | grep "$teststring")
    fi

    if [ -n "$out" ]; then
        echo "PASS: http://$pastebin ($URL)"
    else
        echo "FAIL: http://$pastebin ($URL)"
    fi
    echo ""
done
