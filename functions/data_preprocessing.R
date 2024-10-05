# Function to detect outliers using the IQR method
detect_outliers <- function(x) {
  if (is.numeric(x)) {
    Q1 <- quantile(x, 0.25)
    Q3 <- quantile(x, 0.75)
    IQR <- Q3 - Q1
    lower_bound <- Q1 - 1.5 * IQR
    upper_bound <- Q3 + 1.5 * IQR
    return(x < lower_bound | x > upper_bound)
  }
  else {
    return(FALSE)
  }
}