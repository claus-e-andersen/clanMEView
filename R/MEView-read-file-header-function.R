#' @title Read data optained with MEView
#' @description Read data optained with MEView
#' @usage See MEView-40 user guide.
#' @name MEView.read.file.header
#' @author Claus E. Andersen
#' @return Alist with data and meta data in separate dataframes.
#' @param file.name: Name of file to be read
#' @export MEView.read.file.header
MEView.read.file.header <- function(file.name='c:/data/exp91160.csv'){
  print(paste('Reading :',file.name))
  x <- readLines(file.name, n = 1000)
  nn.end <- seq(along=x)[x=="%end"] 
  print(nn.end)
  x <- readLines(file.name, n = nn.end)
  ok <- substring(x,1,5)=='META.'
  x.META <- x[ok]
  yy <- unlist(strsplit(x.META,':='))
  N <- length(yy) 
  yy.1 <- yy[seq(1,N-1,by=2)]
  yy.2 <- yy[seq(2,N,by=2)]
  # #yy.1 <- sub('[[:space:]]+$', '', yy.1)
  # #yy.2 <- sub('[[:space:]]+$', '', yy.2)
  yy.1 <- str_trim(yy.1)
  yy.2 <- str_trim(yy.2)
  df.META <- data.frame(id=yy.1, Value=yy.2, stringsAsFactors=F)
  df.META.for.stack <- 0
  ok <- substring(x,1,10)=='set config'
  x.config <- strsplit(x[ok]," ")
  x.var <- NULL
  for(i in 1:length(x.config)){
    yy <- x.config[[i]]
    yy <- sub('[[:space:]]+$', '', yy)
    ok <- !yy==''
    yy <- yy[ok]
    yy <- yy[5]
    yy <- chartr("\'", " ", yy)
    yy <- str_trim(yy)
    if(is.null(x.var)) {x.var <- yy} else {x.var <- c(x.var,yy)}
  } #for loop
  txt1 <- paste("list(",paste(x.var,'= 0.0',sep=" ",collapse=", "),")")
  txt2 <- paste('scan("',file.name,'",what =',txt1,',skip =',nn.end+1,',sep=",")',sep='')
  print(txt2)
  zzz <- data.frame(eval(parse(text=txt2)))
  list(df=zzz, df.META=df.META, col.names=x.var)
} # end function
