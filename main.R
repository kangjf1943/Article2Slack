#パッケージのインストール
library(dplyr)
library(rvest)
library(slackr)

# setup
user_info <- read.csv("secret.csv")
# bug: does webhook url expire? 

slackr_setup(
  channel = user_info[1, 2], 
  token = user_info[2, 2], 
  incoming_webhook_url = user_info[3, 2]
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
slackr_msg(head(title, 10))

# future potential features: 
# keep interested articles based on abstract text mining
# update titles when new issue is published - use cloud R?
# add other info to the title list, e.g., links to the articles 
# get highlight points based on GPT? 
