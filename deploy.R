install.packages("connectapi", repos = "https://colorado.rstudio.com/rspm/internal/__linux__/bionic/latest");
library(connectapi)
myip <- httr::content(httr::GET("http://ipecho.net/plain"), as = "text")
rsc <- paste0("http://ec2-", stringr::str_replace_all(myip, "\\.", "-"), ".us-east-2.compute.amazonaws.com/rsconnect/")
client <- connectapi:::create_first_admin(
    url = rsc,
    user = "rstudio-admin",
    password = Sys.getenv("PASSWORD"), 
    provider = "pam"
)

bnd <- bundle_dir(".")

myapp <- deploy(client, bnd)

poll_task(myapp)
