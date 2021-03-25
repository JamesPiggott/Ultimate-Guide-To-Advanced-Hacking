# Fierce

This tool is used to find IP addresses that might be part of your target. As such it is a precursor step to tools such as NMAP and others. It can also be used as an DNS interrogation tool.

```
python -m pip install fierce
fierce -h
```

Examples:

fierce --domain [target_url] --subdomains accounts admin ads

    --domain: specifies the target domain

fierce --domain facebook.com --subdomains admin --traverse 10

    --traverse: Discover contiguous IP blocks 