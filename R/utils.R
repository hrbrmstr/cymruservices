# remove leading/trailing blanks around strings
trim_df <- function(df, stringsAsFactors=FALSE) {
  data.frame(lapply(df, function (v) {
    if (is.character(v)) {
      trimws(v)
    } else {
      v
    }
  }), stringsAsFactors=stringsAsFactors)
}
