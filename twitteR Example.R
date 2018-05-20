EnsurePackage<-function(x)
{
  x <- as.character(x)
  if (!require(x,character.only=TRUE))
  {
    install.packages(pkgs=x,
                     repos="http://cran.r-project.org")
    require(x,character.only=TRUE)
  }
}
PrepareTwitter<-function()
{
  EnsurePackage("bitops")
  EnsurePackage("RCurl")
  EnsurePackage("RJSONIO")
  EnsurePackage("twitteR")
  EnsurePackage("ROAuth")
  EnsurePackage("httr")
}
PrepareTwitter()
credential <- OAuthFactory$new (consumerKey="C1LaH8knIQm9uLKiWk5o8kyBO",
                   consumerSecret="i94hHTwiUizY8n8gSyOKDzgMjbW9Zj6yMxeuSYs7657VEl35rJ",
                   requestURL="https://api.twitter.com/oauth/request_token",
                   accessURL="https://api.twitter.com/oauth/access_token",
                   authURL="https://api.twitter.com/oauth/authorize")

credential

credential$handshake()
#registerTwitterOAuth(credential)
setup_twitter_oauth("C1LaH8knIQm9uLKiWk5o8kyBO","i94hHTwiUizY8n8gSyOKDzgMjbW9Zj6yMxeuSYs7657VEl35rJ")
tweetList <- searchTwitter("@blitztimo", n=500)
