### Advanced Remote Sensing and Geomatics (Fernerkundung und Geomatik für Fortgeschrittene), WiSe 2023/24

## Seminar 1: Intro in R 



### Homework 1 

################################################################################
################################################################################

## Block I

# 1
a <- 2017

# 2
b <- sqrt(1089)

# 3
sum_ab <- a+b

#4 
a = 2018

#5
c <- a # c gets a copy of the current value of a (2018)

#6
  my.fun <- function(var1,var2,var3) {
    l <- c(var1,var2,var3)
    inner.prod <- prod(l)
    inner.final <- sqrt(inner.prod)
    return (inner.final)
  }
#7
  d <- my.fun(a,b,c)
# ...

################################################################################

## Block II

# 1
e <- 42L
class(e)

#2
e <- as.character(e)

#3
friends <- c("Ema","Jay","Alice","Paige")

#4
two.secondElem <- friends[2]

#5
friends[1] = "Isolde"

#6
v1 = c(1,"Hello",2,"World")

#7
v2 = 4:10

#8
first.three = v2[1:3]

#9
v2.subset = v2[-2]

#10
v2.subset.length = length(v2.subset)

#11
mean(v2)
sd(v2.subset)
#
################################################################################

## Block III

# 1
m1 <- matrix(6:20,nrow=3,ncol=5)
#2
m1 <- 0.5*m1
#3
m2 <- matrix(1:5, nrow = 1, ncol = 5)

#4
m2.sum = sum(m2)

#5
m3 = rbind(m1,m2)

#6
m3.sub5 = m3[,5]

#7
m3.line24 = m3[c(2,4),]

#8
m3.colSum = colSums(m3)

#9
m3.sd = sd(m3[,3])

#10
m4 <- m3[1:3,1:3]

##############################################################################

##Block IV

#1
df <- data.frame(
  "name"    = c("Ema","Jay","Alice","Paige"), 
  "age" = c(24,23,22,31),
  "size" = c(160, 160, 170, 175),
  "city" = c("Karslruhe","Berlin" , "Paris" ,"Berlin"  )
)

summary(df)

#3
df.subset = df[2]

#4
age.persons = df[["age"]]

#5
df["weight"] = c(50,50,60,60)


#6
df[5,] = list(name = "Alissa", age = 23 , size= 170, city = "Berlin" , weight = 50)

#7
ages.mean = mean(df[["age"]])

#8
ages.older = df[df["age"]>ages.mean,1]

#9
person.condition = df[(df["weight"] < 100) & df["size"] > 165,1]

#########################################################################

##Block V

#1
df["size.category"] = ifelse(df["size"]<=175,"small","tall")

#2
for (i in 5:15) {
 print(i)    
}

#3
for (i in colnames(df)){
  if(is.numeric(df[[i]])){
    local.mean = mean(df[[i]])
    print(paste(i,local.mean))
  }
}

#########################################################################

##Block VI
stations <- read.csv("https://opendata.dwd.de/climate_environment/CDC/observations_germany/climate/multi_annual/mean_81-10/Temperatur_1981-2010_Stationsliste.txt", encoding = "latin1", sep=";")


my.getdata <- function(file){

data <- read.csv(file, sep=";")
  
data<- merge(data, stations, by = "Stations_id")

data <- data[ , -c(2, 3, 17, 23)]


data$Bundesland <- gsub(" ", "", data$Bundesland) 
data$Stationsname <- gsub(" ", "", data$Stationsname) 

names(data) <- c("Stations_id","Jan", "Feb", "Mae", "Apr", "Mai", "Jun", "Jul", "Aug", "Sep", "Okt", "Nov", "Dez", "Jahr", "Stationsname", "lat", "lon", "Stationshoehe", "Bundesland")
return(data)

} 


ref90 = my.getdata("data/Temperatur_1961-1990.txt")
ref10 = my.getdata("data/Temperatur_1981-2010.txt")

#3
ref90_10 = merge(ref90,ref10,by="Stations_id",suffixes=c("90","10"))

#4
ref90_10$differencesJahr =  ref90_10$Jahr10 - ref90_10$Jahr90

#5
summary(ref90_10)

#6
ref90_10.maximum = ref90_10[abs(ref90_10$differencesJahr) == max(abs(ref90_10$differencesJahr)) ,"Stationsname10"]

#7
test.Pval = t.test(ref90_10$differencesJahr,alternative = "two.sided")


#########################################################################

##Block VII

