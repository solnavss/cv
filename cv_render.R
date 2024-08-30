# This script builds both the HTML and PDF versions of your CV

# If you want to speed up rendering for googlesheets driven CVs you can cache a
# version of your data This avoids having to fetch from google sheets twice and
# will speed up rendering. It will also make things nicer if you have a
# non-public sheet and want to take care of the authentication in an interactive
# mode.
# To use, simply uncomment the following lines and run them once.
# If you need to update your data delete the "ddcv_cache.rds" file and re-run

library(tidyverse)
source("cv_printing_functions.R")
cv_data <- create_CV_object(
  data_location = "https://docs.google.com/spreadsheets/d/1L3ZrTO-p_eH22TQKxJ_TrJW-QQB0IFt3pZnPDy97L1o/edit?usp=sharing"
)

readr::write_rds(cv_data, 'cached_positions.rds')
cache_data <- TRUE

rmarkdown::render("cv_mnm.Rmd",
                  params = list(pdf_mode = FALSE),
                  output_file = "cv_mnm.html")

tmp_html_cv_loc <- fs::file_temp(ext = ".html")
rmarkdown::render("cv_mnm.Rmd",
                  params = list(pdf_mode = TRUE),
                  output_file = tmp_html_cv_loc)

# Convert to PDF using Pagedown ## Failed to generate output. Reason: Failed to open http://127.0.0.1:4414/favicon.ico (HTTP status code: 404)
# pagedown::chrome_print(input = tmp_html_cv_loc,
#                       output = "MarisolNM_CV.pdf")


