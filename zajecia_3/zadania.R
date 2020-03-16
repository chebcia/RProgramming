auta<-mtcars
samochody(samochody$cyl == 6)

b.cars <- read.csv2("./data/koty_ptaki.csv", dec=';') 
str(b.cars)
b.cars$waga<-as.numeric(b.cars$waga)
mean(which(b.cars$habitat== "Afryka" ))
sex2<-b.cars$habitat== "Afryka" 

tapply(b.cars$waga, b.cars$habitat= "Afryka", mean)

koty_ptaki$waga <- as.numeric(koty_ptaki$waga)
mean(koty_ptaki$waga[koty_ptaki$habitat=='Afryka'])

koty_ptaki[,-1]

set.seed(42)
x <- rnorm(500, mean=175, sd=7)
summary(x)[3]


mean(koty_ptaki$predkosc[koty_ptaki$druzyna =='Kot'])

set.seed(42)
x <- rnorm(500, mean=175, sd=7)
subset(koty_ptaki$dlugosc, koty_ptaki$habitat == "Azja")


koty_ptaki$dlugosc<-as.numeric(sub(",", ".", koty_ptaki$dlugosc))
mean(koty_ptaki$dlugosc[koty_ptaki$habitat=='Azja'])
mean(auta$Cena[auta$Marka=='Volkswagen'])
mean(auta$Pojemnosc[auta$Paliwo=='diesel'])

w <- as.factor(c("a", "b", "a", "a", "b")) 

w[4] <- "c"
iris_c<-iris


min()


tt<-read.csv(file="./data/titanic.csv")
# zamieniamy odpowiednie kolumny na znakowe 
tt$Name <- as.character(tt$Name) 
tt$Ticket <- as.character(tt$Ticket) 
tt$Cabin <- as.character(tt$Cabin)
# kolumne survived zamieniamy na factor z nowymi levelami 
tt$Survived <- factor(tt$Survived, levels = c("0", "1"), labels = c("not survived", "survived"))
# i kolumne Pclass tez 
tt$Pclass <- as.factor(tt$Pclass)

mean(tt$Age[tt$Pclass == 1], na.rm = TRUE)


tapply(tt$Fare, tt$Ticket, mean)

boxplot(  dane1$Survived  ~  dane1$Age)
tt$Name[is.na(tt$Age)]

is.na(tt$Age)

tt$Survived<-as.character(tt$Survived)

dane1<-tt[ tt$Sex == 'female', ]
dane2<-tt[ tt$Sex == 'male', ]


tt$Relatives <- tt$SibSp + tt$Parch
str(tt)

which(tt$Relatives ==0)
summary(tt$Relatives ==0)

pokemon1_4 <- read_csv("data/pokemon1_4.csv",   skip = 3, )
pokemon1_4$Name<-as.factor(pokemon1_4$Name)

sex<-read.csv2("data/IMDB.csv", header = TRUE, sep = ";")
plik<-rbind(pokemon1_4, pokemon5_6)

names(plik)[c(1,3,4)] <- c('No', 'Type1', 'Type2')

names(plik)[c(9,10)] <- c('Sp.Atk', 'Sp.Def')

plik$Name[plik$Legendary]

boxplot( plik$Attack ~ plik$Legendary )
boxplot( plik$Defense ~ plik$Legendary  )
hist(sex$Runtime.Minutes., xlim=c(60,200) )
plot(sex$Runtime.Minutes. ~ sex$Rating)

sort(tt$Age, decreasing = TRUE, n=50)

x <- c(14, 11, 16, 18, 13) # przykladowy wektor 
y <- c("Jacek", "Marek", "Kasia", "Wojtek", "Kinga")
order(x)	# indeksy wektora x posortowane wg wartosci x
y[order(x)]	
# wektor y posortowany wg wartosci wektoa x

head(tt[order(tt$SibSp, decreasing = TRUE), ], n=15)

order(tt$Name)


