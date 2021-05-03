# Google-Fu

The Google search can be utilized to gather information on a target. Besides a raw string search you can also use directives to narrow searches to specific targets, names and filetypes. Directives can be chained for maximum control.

## site:

The 'site:' directive is the most useful of all, you will only see results directly found on the input site as crawled by the Google spider bot. So instead of seeing the search results for all the internet that has been crawled and index you will only see the results for that specific URL.

Examples:

site:[target_url] [search_term] 

    target_url: the website you are targeting
    search_term: the term you are searching for on the target website, can be more than one word

    site:cnn.com donald trump

## intitle: and allintitle:

Returns only those webpages that contains the search term in the title. In case of 'intitle:' just one keyword will suffice while with 'allintitle:' all keywords defined must be in the title.

Examples:

intitle:[search_term] 

    search_term: the term you are searching for in the title of a webpage, can be more than one word

    intitle:star trek

## inurl:

Returns only those webpages that contains the search term in the url. Often used to find configuration or administration pages. Deprecated as Google does not allow this

Examples:

inurl:[search_term] 

    search_term: the term you are searching for in the url of a webpage such as 'admin', 'portal' etc.

    inurl:admin