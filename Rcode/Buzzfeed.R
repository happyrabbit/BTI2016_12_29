## basic workflow of scraping with rvest
source("00Require.R")
# 1. specify URL
url <- "https://www.buzzfeed.com/?country=us"
browseURL(url)
# 2. download static HTML behind the URL and parse it into an XML file
url_parsed <- read_html(url)
authors <- html_nodes(url_parsed, css = ".small-meta__item:nth-child(1) a") %>% html_text()
table(authors) %>% sort(decreasing = T) %>% data.frame()%>% datatable()
#class(url_parsed)
#html_structure(url_parsed)
#as_list(url_parsed)

# 3. extract specific nodes with CSS (or XPath)
headings_nodes <- html_nodes(url_parsed, css = ".lede__link")

# 4. extract content from nodes
headings <- html_text(headings_nodes)
(headings <- str_replace_all(headings, "\\n", "") %>% str_trim())


