#!/bin/bash

echo "Content-Type:text/plain"
echo ""

input=$(cat)

if [[ $input =~ type...confirmation ]]; then
    # this IF is used only when bot is set up, could be removed later
    printf "yourConfirmationValue"
    exit 0
fi

if [[ $input == *"yourSecretKeyGoesHere"* ]]; then
    re="type.\:.message_new.*user_id.\:([0-9]+).*body.\:.(.+)owner_ids.*"
    if [[ $input =~ $re ]]; then
        body=${BASH_REMATCH[2]//[^[:alpha:][:space:]]/}
	echo "uid="${BASH_REMATCH[1]}", msg: $body">>msgs.txt
        uid=${BASH_REMATCH[1]}
        key="yourGroupTokenShouldBeHere"
        msg="Got+${#input}+bytes+from+you"
        resp=$(curl "https://api.vk.com/method/messages.send?user_id=$uid&message=$msg&access_token=$key&v=5.50")
    else
        echo "not new">>msgs.txt
    fi
fi
printf "ok"
