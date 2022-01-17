library(rtweet)
library(tidyverse)
library(openxlsx)

# on Twitter App, set callback url as http://127.0.0.1:1410
token <- create_token(app = "rtweet_tokens", #whatever you named your app
               consumer_key = "xxxx",
               consumer_secret = "xxxx")

# load the list
user_list <- read.xlsx("/Users/yujinkim/Downloads/Tweeter_ideology/dataverse_files/replicate2/TwitterPoliticalList_2.6.21.xlsx")

# set a folder for downloaded files
outfolder <- '~/Downloads/Tweeter_ideology/dataverse_files/elites_list'
accounts.done <- gsub(".rds", "", list.files(outfolder))

# repeat this when downloading connection fails

user_list <- user_list[!user_list$user_name %in% accounts.done, ]
accounts.left <- unlist(user_list$user_name)


for (i in 1:length(accounts.left)) {
    temp <- get_followers(
      accounts.left[i], retryonratelimit = TRUE, token = token)
    saveRDS(temp, paste0(outfolder, i, ".rds"))
    cat(i, "of", length(accounts.left), "\n")
}



