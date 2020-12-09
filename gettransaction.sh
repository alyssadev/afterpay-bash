#!/bin/bash
# returns details on a specific transaction. call with transaction IDs as arguments
authtoken=$(cat /tmp/afterpay-authtoken)
get() {
curl "https://portalapi.afterpay.com/portal/consumers$1" -H 'authority: portalapi.afterpay.com' -H 'accept: application/json, text/plain, */*' -H "x-auth-token: $authtoken" -H 'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.67 Safari/537.36 Edg/87.0.664.55' -H 'origin: https://portal.afterpay.com' -H 'sec-fetch-site: same-site' -H 'sec-fetch-mode: cors' -H 'sec-fetch-dest: empty' -H 'referer: https://portal.afterpay.com/' -H 'accept-language: en-US,en;q=0.9' -c /tmp/afterpay-cookie.jar --compressed 2>/dev/null
}

main() {
    echo -n "["
    for arg in "$@"; do
        get "/ordertransactions/$arg"
        echo -n ","
    done
    echo "]"
}

main $@ | sed 's/\},\]$/\}\]/'
