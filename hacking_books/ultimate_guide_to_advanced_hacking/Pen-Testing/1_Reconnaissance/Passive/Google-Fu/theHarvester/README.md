# theHarvester

With theHarvester we can scour the internet for email addresses, subdomains and IPs belonging to the target.

Examples:

python3 theHarvester.py -d [target_url] -l 10 -b google

    -d: specifies target domain
    -l: limit returns to 10 results
    -b: specify public repository (google, bing, linkedin or 'all')

python3 theHarvester.py -d [target_url] -l 10 -b all