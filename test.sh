#!/bin/bash

exec 3< <(node << EOF
  "use strict"
  var net = require("net")
  net.createServer(function(conn) {
    setTimeout(function () {
      conn.on("data", function(data) {

        var json = JSON.parse(data.toString());
        console.log(json.name)
        console.log(json.value)
        console.log(json.ok)
        process.exit()
      })
    }, 1000)
  }).listen(3333)
EOF
)

bin/numbat-send -a foo -n bar --tag "ok=there"

code=0
read <&3 line
if [ ! "$line" == "foo.bar" ]; then
  printf "[\x1b[31mFAIL\x1b[0m] name: got \"%s\", expected \"foo.bar\"\n" "$line"
  code=1
else
  printf "[\x1b[32mPASS\x1b[0m] name: got \"%s\"\n" "$line"
fi

read <&3 line
if [ ! "$line" == "1" ]; then
  printf "[\x1b[31mFAIL\x1b[0m] value: got \"%s\", expected \"1\"\n" "$line"
  code=1
else
  printf "[\x1b[32mPASS\x1b[0m] value: got \"%s\"\n" "$line"
fi

read <&3 line
if [ ! "$line" == "there" ]; then
  printf "[\x1b[31mFAIL\x1b[0m] tag: got \"%s\", expected \"1\"\n" "$line"
  code=1
else
  printf "[\x1b[32mPASS\x1b[0m] tag: got \"%s\"\n" "$line"
fi

exit $code
