# theHarvester

With theHarvester it is possible to scour a target and common sources such as Google for email addresses and other information

## Installation instructions

```
git clone https://github.com/laramies/theHarvester 
cd theHarvester
python -m pip install -r requirements/base.txt
```

Examples:

python3 theHarvester.py -d [target_url] -l 10 -b all

    -d: domain that is the target
    -l: number of results
    -b: sources that can be used (all, google etc)


