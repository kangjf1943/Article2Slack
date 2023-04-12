#パッケージのインストール
library(dplyr)
library(rvest)
library(slackr)

# setup
my_channel <- "#test"
my_token <- "xoxb-5095796214786-5081358760999-5hHG9xKO5BoJ0RFqsdJQuy8n"
my_webhook_url <- paste0(
  "https://hooks.slack.com/services/", 
  "T052TPE6AP4/B052UBRSCF4/DJdr4cU3i1IpLr0yXteWqk2I"
)
# bug: does webhook url expire? 

slackr_setup(
  channel = my_channel, 
  token = my_token, 
  incoming_webhook_url = my_webhook_url
)

# setting 
# target vol and issue
vol <- 616
issue <- 7955

# get titles 
title <- read_html(paste0(
  "https://www.nature.com/nature/volumes/", vol, "/issues/", issue
)) %>% 
  html_elements(css = ".u-link-inherit") %>% 
  html_text(trim = TRUE)
# send the titles to Slack
slackr_msg(title)

# future potential features: 
# keep interested articles based on abstract text mining
# update titles when new issue is published - use cloud R?
# add other info to the title list, e.g., links to the articles 
# get highlight points based on GPT? 
