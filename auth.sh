#!/bin/bash
# proof of concept, successfully logs into afterpay and retrieves transactions and amount due, returns to stdout for processing. pipe to jq for fun times
# expects environment variables AFTERPAY_EMAIL, AFTERPAY_PASSWORD
curl 'https://portalapi.afterpay.com/portal/consumers/emails/lookup' -H 'authority: portalapi.afterpay.com' -H 'accept: application/json, text/plain, */*' -H 'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.67 Safari/537.36 Edg/87.0.664.55' -H 'content-type: application/json;charset=UTF-8' -H 'origin: https://portal.afterpay.com' -H 'sec-fetch-site: same-site' -H 'sec-fetch-mode: cors' -H 'sec-fetch-dest: empty' -H 'referer: https://portal.afterpay.com/' -H 'accept-language: en-US,en;q=0.9' -c /tmp/afterpay-cookie.jar -D /tmp/afterpay-headers.tmp --data-binary "{\"email\":\"$AFTERPAY_EMAIL\"}" --compressed 2>/dev/null >/dev/null
authtoken=$(grep 'x-auth-token:' /tmp/afterpay-headers.tmp | awk '{print $2}' | tr -d '\r\n')
curl 'https://portalapi.afterpay.com/portal/consumers/auth/login' -H 'authority: portalapi.afterpay.com' -H 'accept: application/json, text/plain, */*' -H "x-auth-token: $authtoken" -H 'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.67 Safari/537.36 Edg/87.0.664.55' -H 'content-type: application/x-www-form-urlencoded' -H 'origin: https://portal.afterpay.com' -H 'sec-fetch-site: same-site' -H 'sec-fetch-mode: cors' -H 'sec-fetch-dest: empty' -H 'referer: https://portal.afterpay.com/' -H 'accept-language: en-US,en;q=0.9' -c /tmp/afterpay-cookie.jar -D /tmp/afterpay-headers.tmp --data-raw "username=$AFTERPAY_EMAIL&password=$AFTERPAY_PASSWORD&remember-me=false" --compressed 2>/dev/null >/dev/null
authtoken=$(grep 'x-auth-token:' /tmp/afterpay-headers.tmp | awk '{print $2}' | tr -d '\r\n')
echo -n $authtoken > /tmp/afterpay-authtoken

#rm /tmp/afterpay-cookie.jar /tmp/afterpay-headers.tmp
