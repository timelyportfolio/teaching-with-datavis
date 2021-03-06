# fork of http://walkerke.github.io/2014/01/hispanic-pop-by-state/ ;  please direct praise and attibution there
# explore other ways to view data using rCharts
# First, download the Excel file from the Pew Hispanic Center, and save it as a CSV in your working directory

library(stringr)
library(plyr)
library(rCharts)
library(reshape2)

#original way of getting data
getDataOldWay<-function(){
  dat <- read.csv("all_counties_by_top_six_groups.csv")
  keep <- seq(1, 25, 3)
  dat <- dat[,keep]
  nms <- c('Name', 'Total.Hisp', 'Mexican', 'Puerto.Rican', 'Cuban', 'Salvadoran', 'Dominican', 'Guatemalan', 'Other')
  names(dat) <- nms
  dat <- dat[-c(1:3),]
  dat <- cbind(dat, ldply(str_split(dat$Name, ", ")))
  names(dat) <- c(nms, 'County', 'State')
  convCols <- 2:9
  dat[,convCols] <- apply(dat[,convCols], 2, function(x) as.numeric(as.character(gsub(",", "", x))))
  sums <- ddply(dat, .(State), numcolwise(sum))
  
  sorteddf <- sums[order(-sums$Total.Hisp),][1:10,]
  
  newdf <- data.frame(sorteddf$State)
  
  vals <- c('Mexican', 'Puerto.Rican', 'Cuban', 'Salvadoran', 'Dominican', 'Guatemalan', 'Other')
  
  for (v in vals) {
    newdf[[v]] <- round(((sorteddf[[v]] / sorteddf$Total.Hisp) * 100), 1)
  }
  
  names(newdf) <- c('State', vals)
  
  df.melt <- melt(newdf, variable.name = 'Ancestry', value.name = 'Share')
}


#get data from JSON
getDataFromJSON <- function(){
  return(jsonlite::fromJSON('[
    {
      "State": "California",
      "Ancestry": "Mexican",
      "Share":   81.5 
    },
    {
      "State": "Texas",
      "Ancestry": "Mexican",
      "Share":     84 
    },
    {
      "State": "Florida",
      "Ancestry": "Mexican",
      "Share":   14.9 
    },
    {
      "State": "New York",
      "Ancestry": "Mexican",
      "Share":   13.4 
    },
    {
      "State": "Illinois",
      "Ancestry": "Mexican",
      "Share":     79 
    },
    {
      "State": "Arizona",
      "Ancestry": "Mexican",
      "Share":   87.5 
    },
    {
      "State": "New Jersey",
      "Ancestry": "Mexican",
      "Share":     14 
    },
    {
      "State": "Colorado",
      "Ancestry": "Mexican",
      "Share":   72.9 
    },
    {
      "State": "New Mexico",
      "Ancestry": "Mexican",
      "Share":     62 
    },
    {
      "State": "Georgia",
      "Ancestry": "Mexican",
      "Share":   60.9 
    },
    {
      "State": "California",
      "Ancestry": "Puerto.Rican",
      "Share":    1.4 
    },
    {
      "State": "Texas",
      "Ancestry": "Puerto.Rican",
      "Share":    1.4 
    },
    {
      "State": "Florida",
      "Ancestry": "Puerto.Rican",
      "Share":   20.1 
    },
    {
      "State": "New York",
      "Ancestry": "Puerto.Rican",
      "Share":   31.3 
    },
    {
      "State": "Illinois",
      "Ancestry": "Puerto.Rican",
      "Share":      9 
    },
    {
      "State": "Arizona",
      "Ancestry": "Puerto.Rican",
      "Share":    1.8 
    },
    {
      "State": "New Jersey",
      "Ancestry": "Puerto.Rican",
      "Share":   27.9 
    },
    {
      "State": "Colorado",
      "Ancestry": "Puerto.Rican",
      "Share":    2.2 
    },
    {
      "State": "New Mexico",
      "Ancestry": "Puerto.Rican",
      "Share":    0.8 
    },
    {
      "State": "Georgia",
      "Ancestry": "Puerto.Rican",
      "Share":    8.4 
    },
    {
      "State": "California",
      "Ancestry": "Cuban",
      "Share":    0.6 
    },
    {
      "State": "Texas",
      "Ancestry": "Cuban",
      "Share":    0.5 
    },
    {
      "State": "Florida",
      "Ancestry": "Cuban",
      "Share":   28.7 
    },
    {
      "State": "New York",
      "Ancestry": "Cuban",
      "Share":    2.1 
    },
    {
      "State": "Illinois",
      "Ancestry": "Cuban",
      "Share":    1.1 
    },
    {
      "State": "Arizona",
      "Ancestry": "Cuban",
      "Share":    0.6 
    },
    {
      "State": "New Jersey",
      "Ancestry": "Cuban",
      "Share":    5.4 
    },
    {
      "State": "Colorado",
      "Ancestry": "Cuban",
      "Share":    0.6 
    },
    {
      "State": "New Mexico",
      "Ancestry": "Cuban",
      "Share":    0.5 
    },
    {
      "State": "Georgia",
      "Ancestry": "Cuban",
      "Share":    2.9 
    },
    {
      "State": "California",
      "Ancestry": "Salvadoran",
      "Share":    4.1 
    },
    {
      "State": "Texas",
      "Ancestry": "Salvadoran",
      "Share":    2.4 
    },
    {
      "State": "Florida",
      "Ancestry": "Salvadoran",
      "Share":    1.3 
    },
    {
      "State": "New York",
      "Ancestry": "Salvadoran",
      "Share":    4.5 
    },
    {
      "State": "Illinois",
      "Ancestry": "Salvadoran",
      "Share":    0.7 
    },
    {
      "State": "Arizona",
      "Ancestry": "Salvadoran",
      "Share":    0.6 
    },
    {
      "State": "New Jersey",
      "Ancestry": "Salvadoran",
      "Share":    3.6 
    },
    {
      "State": "Colorado",
      "Ancestry": "Salvadoran",
      "Share":    1.2 
    },
    {
      "State": "New Mexico",
      "Ancestry": "Salvadoran",
      "Share":    0.2 
    },
    {
      "State": "Georgia",
      "Ancestry": "Salvadoran",
      "Share":    3.8 
    },
    {
      "State": "California",
      "Ancestry": "Dominican",
      "Share":    0.1 
    },
    {
      "State": "Texas",
      "Ancestry": "Dominican",
      "Share":    0.1 
    },
    {
      "State": "Florida",
      "Ancestry": "Dominican",
      "Share":    4.1 
    },
    {
      "State": "New York",
      "Ancestry": "Dominican",
      "Share":   19.7 
    },
    {
      "State": "Illinois",
      "Ancestry": "Dominican",
      "Share":    0.3 
    },
    {
      "State": "Arizona",
      "Ancestry": "Dominican",
      "Share":    0.2 
    },
    {
      "State": "New Jersey",
      "Ancestry": "Dominican",
      "Share":   12.7 
    },
    {
      "State": "Colorado",
      "Ancestry": "Dominican",
      "Share":    0.2 
    },
    {
      "State": "New Mexico",
      "Ancestry": "Dominican",
      "Share":    0.1 
    },
    {
      "State": "Georgia",
      "Ancestry": "Dominican",
      "Share":    1.8 
    },
    {
      "State": "California",
      "Ancestry": "Guatemalan",
      "Share":    2.4 
    },
    {
      "State": "Texas",
      "Ancestry": "Guatemalan",
      "Share":    0.7 
    },
    {
      "State": "Florida",
      "Ancestry": "Guatemalan",
      "Share":      2 
    },
    {
      "State": "New York",
      "Ancestry": "Guatemalan",
      "Share":    2.2 
    },
    {
      "State": "Illinois",
      "Ancestry": "Guatemalan",
      "Share":    1.7 
    },
    {
      "State": "Arizona",
      "Ancestry": "Guatemalan",
      "Share":    0.7 
    },
    {
      "State": "New Jersey",
      "Ancestry": "Guatemalan",
      "Share":    3.1 
    },
    {
      "State": "Colorado",
      "Ancestry": "Guatemalan",
      "Share":    0.7 
    },
    {
      "State": "New Mexico",
      "Ancestry": "Guatemalan",
      "Share":    0.3 
    },
    {
      "State": "Georgia",
      "Ancestry": "Guatemalan",
      "Share":    4.3 
    },
    {
      "State": "California",
      "Ancestry": "Other",
      "Share":    9.9 
    },
    {
      "State": "Texas",
      "Ancestry": "Other",
      "Share":   10.9 
    },
    {
      "State": "Florida",
      "Ancestry": "Other",
      "Share":   28.9 
    },
    {
      "State": "New York",
      "Ancestry": "Other",
      "Share":   26.9 
    },
    {
      "State": "Illinois",
      "Ancestry": "Other",
      "Share":    8.1 
    },
    {
      "State": "Arizona",
      "Ancestry": "Other",
      "Share":    8.6 
    },
    {
      "State": "New Jersey",
      "Ancestry": "Other",
      "Share":   33.2 
    },
    {
      "State": "Colorado",
      "Ancestry": "Other",
      "Share":   22.2 
    },
    {
      "State": "New Mexico",
      "Ancestry": "Other",
      "Share":   36.2 
    },
    {
      "State": "Georgia",
      "Ancestry": "Other",
      "Share":   17.9 
    } 
    ]'
  ))
}

df.melt <- getDataFromJSON()


#original chart
d1 <- dPlot(
  x = "Share", 
  y = "State", 
  groups = "Ancestry", 
  data = df.melt, 
  type = 'bar')

d1$xAxis(type = "addPctAxis")
d1$yAxis(type = "addCategoryAxis", orderRule = "State")

d1$legend(
  x = 60,
  y = 10,
  width = 700,
  height = 20,
  horizontalAlign = "left",
  orderRule = "Ancestry"
)
d1

require(XML)
#get States and Census data
#had hoped for a more elegant way of getting
#than this tangled mess to read a Census html list
statesCensus <- readHTMLList(
  "http://www.census.gov/econ/census07/www/geography/regions_and_divisions.html"
)[17:20]
splitUp <- strsplit(statesCensus[[1]],"([\n:,])")
#here my regex weakness shows; also need split on and
splitUp <- lapply(splitUp,function(x){
  unlist(strsplit(x,"\\b and \\b"))
})

options(stringsAsFactors=F)
statesRegions <- do.call(rbind,lapply(
  1:length(splitUp),
  function(n){
    regionloc = as.numeric(
      which(
        sapply(
          splitUp[[n]],
          function(x){grep(".*Region.*",x)}
        )==1
      )
    )
    divisionloc = as.numeric(
      which(
        sapply(
          splitUp[[n]],
          function(x){grep(".*Division.*",x)}
        )==1
      )
    )
    states = splitUp[[n]][-c(regionloc,divisionloc)]
    data.frame(
      Region = rep(splitUp[[n]][regionloc],length(states)),
      Division = unlist(lapply(
        1:length(divisionloc),
        function(x){
          rep(
            splitUp[[n]][divisionloc[x]],
            (c(divisionloc[-1],length(splitUp[[n]])+1) - divisionloc - rep(1,length(divisionloc)))[x]
          )
        }
      )),
      State = gsub(states,pattern="^\\s+",replacement="") #remove leading space
    )
  }
))

require(dplyr)

#use dplyr handy join to combine our new region data
#with prior df.melt data
dataPlot <- left_join(df.melt,statesRegions)

#now one other tiny issue is that with dimple
#handling colors with facets will be better handled
require(plyr)
dataPlot <- ddply(
  dataPlot
  ,.(Division,Region,State,Ancestry)
  ,transform
  ,Share
)

d2 <- dPlot(
  Share ~ State,
  data = dataPlot,
  groups = c("Ancestry"),
  type = "bar"
  ,margins = list(left=60,top=20,right=20,bottom=20)  
)
d2$yAxis(type = "addPctAxis")
d2$params$facet = list(x = "Region", y = NULL)
d2$templates$script = 
  #"../rCharts_dimple/chart_multiselect.html"
  "http://timelyportfolio.github.io/rCharts_dimple/chart_multiselect.html"
#use d3 color scale
d2$params$defaultColors = "#!d3.scale.category10()!#"
#if you wanted to specify colors for each value
#d2$params$defaultColors = sprintf(
#  "#!d3.scale.category10().range(JSON.parse('%s')).domain(JSON.parse('%s'))!#"
#  ,toJSON(RColorBrewer::brewer.pal(n=9,"BuPu"))
#  ,toJSON(unique(dataPlot$Ancestry))
#)
d2

#now add some Angular goodness
d2$addControls(
  "x",
  value = d2$params$x,
  values = colnames(dataPlot[-3])
)
d2$addControls(
  "groups",
  value = d2$params$groups,
  values = colnames(dataPlot[-3])
)
d2$addControls(
  "facetx",
  value = "Region",
  values = colnames(dataPlot[-3])
)
d2$addFilters("Ancestry")
d2


d2$params$facet = list( x = NULL, y = NULL, removeAxes = TRUE)
d2