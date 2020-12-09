afterpay-bash
=============

A couple shell scripts to retrieve user account data from your Afterpay account and return json for your records

This script makes use of the user's email and password to authenticate with Afterpay, and writes cookies and an active authentication token to /tmp. As a result this script currently supports just one active instance per machine, but the scripts could be modified to replace /tmp with some other more local temporary path (and in fact this would be better for security and is advised before using this anywhere but a local test environment)

Usage
-----

```bash
# add the below lines to .bashrc for easier use
export AFTERPAY_EMAIL='test@example.com'
export AFTERPAY_PASSWORD='example password'

# authenticates with afterpay and writes cookies/auth token to temporary directory
./auth.sh

# returns general account data; a full list of accessed endpoints can be found in the header of getdata.sh
./getdata.sh | jq

# returns information on a specific transaction or set of transactions
./gettransaction.sh 123456 234567

# deletes cached authentication data
./logout.sh
```
