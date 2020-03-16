###############################################################################
#                                                                             #
#                            Wiecej o wykresach                               #
#                                                                             #
#                               (CTRL+ENTER)                                  #
#                                                                             #
###############################################################################


###############################################################################
#
########   1 - Wstep #######
#
###############################################################################

# wczytanie i sprawdzenie danych
mov <- read.csv("./data/movies.csv")
str(mov)
summary(mov)

# PYTANIA: 
# - Co przedstawiaja dane? 
# - Jakie maja kolumny?
# - Ile jest filmow trwajacych 120 minut lub wiecej?


# Wykresy w podstawowym R tworzy sie szybko, choc bez dodatkowych ustawien
# nie sa zbyt ladne

# Przyklad 1
barplot(table(mov$genre, mov$year),
        main = "Liczba filmów z poszczególnych gatunków w kolejnych latach")

# Przyklad 2, z kolorami z palety rainbow i legenda
barplot(table(mov$genre, mov$year), col = rainbow(4), 
        main = "Liczba filmów z poszczególnych gatunków w kolejnych latach")
legend("topright", levels(mov$genre), fill = rainbow(4), cex = 0.8)


# Przy odrobinie wysilku i dodatkowych parametrach moga jednak wygladac
# naprawde przyzwoicie

# Przyklad 3

# ustalam swoje kolory
my_colors <- c("#972D15", "#02401B", "#D8B70A", "#81A88D")

# tworze wykres
barplot(table(mov$genre, mov$year), beside = FALSE, 
        col = my_colors, border = "white", ylim = c(0, 120),
        cex.axis = 0.8, cex.names = 0.8, las = 2, cex.main = 1,
        main = "Liczba filmów z poszczególnych gatunków w kolejnych latach")

# dodaje legende
legend("top", levels(mov$genre), fill = my_colors, cex = 0.8,
       bty = "n", horiz = TRUE, inset = c(0, -0.1), xpd = TRUE)



###############################################################################
#
########   2 - Zapisywanie wykresow #######
#
###############################################################################

# w sposob programistyczny wykresy mozna zapisac za pomoca polecen png, bmp itd.
?png
?pdf

# polega to na 
# - wywolaniu odpowiedniej funkcji ze sciezka i nazwa pliku (domyslne urzadzenie 
#   wyswietlajace grafike, czyli okienko, zostanie zmienione na plik),
# - nastepnie utworzenie wykresu, 
# - a pozniej zamkniecie urzadzenia za pomoca dev.off

# ladny wykres uzyskany w ten sposob wymaga jednak troche pracy, 
# np. zmiane domyslnych parametrow


##### Przyklad 1 #####

# uruchamiam nowe "urzadzenie"
png("./figs/fig1.png")
# tworze wykres, nie pojawi sie teraz w oknie
barplot(table(mov$genre, mov$year), beside = FALSE, 
        col = my_colors, border = "white", ylim = c(0, 120),
        cex.axis = 0.8, cex.names = 0.8, las = 2, cex.main = 1,
        main = "Liczba filmów z poszczególnych gatunków w kolejnych latach")
# dodaje legende
legend("top", levels(mov$genre), fill = my_colors, cex = 0.8,
       bty = "n", horiz = TRUE, inset = c(0, -0.1), xpd = TRUE)
# zamykam polaczenie z png
dev.off()
#####


##### Przyklad 2 - jeszcze raz to samo, ale lepiej #####
png("./figs/fig1.png", width = 1000, height = 600)

# tworze wykres, zmieniam troche parametry
barplot(table(mov$genre, mov$year), beside = FALSE, 
        col = my_colors, border = "white", ylim = c(0, 120),
        cex.axis = 1.2, cex.names = 1.2, las = 2, cex.main = 2,
        main = "Liczba filmów z poszczególnych gatunków w kolejnych latach")

# dodaje legende, tez z lekka zmiana
legend("top", levels(mov$genre), fill = my_colors, cex = 1.2,
       bty = "n", horiz = TRUE, inset = c(0, -0.04), xpd = TRUE)

# zamykam polaczenie z png
dev.off()

# w przykladzie 2 zmienily sie nie tylko opcje funkcji png, ale tez 
# doprecyzowane zostaly parametry wykresu, glownie wielkosci napisow (cex)
#####


# chyba najwygodniej jednak zapisywac wykresy za pomoca opcji w RStudio
# (manualny pokaz jak to robic dla png i pdf)



###############################################################################
#
########   3 - Podstawowe wykresy #######
#
###############################################################################


##### wykres kolumnowy - barplot #####
# sluzy glownie do pokazywania liczebnosci wartosci zmiennych kategorycznych

# wymaga podania przynajmniej wektora
barplot(c(4, 5, 2, 7))

# jesli wektor ma nazwane elementy (jak w table), to one sa brane jako nazwy X
barplot(table(mov$genre))

# mozna podac wlasne nazwy
barplot(c(4, 5, 2, 7), names.arg = c("A", "B", "C", "D"))



##### histogram - hist #####
# sluzy glownie do pokazywania rozkladu wartosci liczbowych

# wymaga zmiennej liczbowej, najlepiej z duza liczba wartosci
hist(mov$budget)

# liczbe przedzialow mozna zmienic, ale podana liczba jest tylko sugestia
hist(mov$budget, breaks = 5)
hist(mov$budget, breaks = 11)

# mozna tez podac wlasne przedzialy
hist(mov$rating, breaks = seq(0, 10, 0.25))



##### wykres pudelkowy - boxplot #####
# sluzy do pokazywania rozkladu wartosci liczbowych, takze z podzialem wg 
# zmiennej kategorycznej
boxplot(mov$budget / 1000000)
boxplot(mov$budget / 1000000 ~ mov$genre) # rozdzielamy wg gatunkow



##### wykres punktowy - plot #####
# sluzy pokazaniu relacji miedzy dwiema zmiennymi ilosciowymi
# mozna tez podac jedna zmienna, wtedy wartosci sa wyswietlane w kolejnosci 
plot(mov$rating, mov$reviews)
plot(mov$gross)



##### macierzowy wykres punktowy - pairs #####
# pozwala na sprawdzenie zaleznosci miedzy kilkoma zmiennymi liczbowymi

# torze nowa ramke tylko z kolumnami liczbowymi
mov.num <- mov[, c("duration", "gross", "budget", "cast_facebook_likes", 
                   "votes", "reviews", "rating")]
pairs(mov.num)



###############################################################################
#
########   4 - najwazniejsze parametry wykresow #######
#
###############################################################################

# sciagawka: https://www.statmethods.net/advgraphs/parameters.html

# col, border
# main, xlab, ylab
# cex
# pch
# xlim, ylim
# type


##### col, border (w przypadku slupkow i pudelek) - kolor #####
# mozna podac kolor po nazwie, w notacji z # albo za pomoca funkcji rgb
barplot(table(mov$genre), col = "lightgreen")
barplot(table(mov$genre), col = "#553322")
barplot(table(mov$genre), col = rgb(0.1, 0.4, 0.5))
barplot(table(mov$genre), col = "green", border = "navy")

boxplot(mov$budget / 1000000 ~ mov$genre, col = my_colors, border = "darkgrey")


# pojedyncze punkty mozna rozdzielac za pomoca koloru wg factora
plot(mov$rating, mov$reviews, col = mov$genre)

# jesli chcemy wlasne kolory, to mozna to zrobic tak:
plot(mov$rating, mov$reviews, col = my_colors[mov$genre])
# z kolorow tworzymy wektor wg wartosci factora


#### main, xlab, ylab - tytul, etykiety osi #####
plot(mov$rating, mov$reviews, 
     main = "Zależność miedzy oceną a liczbą recenzji",
     xlab = "Ocena", ylab = "Liczba recenzji")


##### cex - wielkosc (punktow, tekstu) #####
plot(mov$rating, mov$reviews, 
     main = "Zależność miedzy oceną a liczbą recenzji",
     xlab = "Ocena", ylab = "Liczba recenzji",
     cex = 0.5, cex.main = 2, cex.axis = 1.2, cex.lab = 1.5)


##### pch - ksztalt punktu #####
plot(mov$rating, mov$reviews, pch = 19, col = "navy")
plot(mov$rating, mov$reviews, pch = 6, col = "purple")
plot(mov$rating, mov$reviews, pch = c(1, 2, 3, 6)[mov$genre], col = "brown")

# WAZNE - ksztalty 21-25 maja dodatkowa opcje bg - kolor wypelnienia
plot(mov$rating, mov$reviews, pch = 21, bg = "orange")
plot(mov$rating, mov$reviews, pch = 21, bg = my_colors[mov$genre])


##### xlim, ylim - zakres osi X i Y #####
plot(mov$rating, mov$reviews, pch = 21, bg = my_colors[mov$genre], 
     xlim = c(0, 10))


##### type - pozwala zmienic sposob wyswietlania punktu #####
# przydaje sie przy prostych wykresach punktowych

# obliczamy sredni przychod z filmow wg lat
mean.gross <- tapply(mov$gross, mov$year, mean)
mean.gross <- round(mean.gross / 1000000, 2) # dzielimy i zaokraglamy


plot(mean.gross)
plot(mean.gross, type = "l") # l = line
plot(mean.gross, type = "b") # b = both (punkt i linia)
plot(mean.gross, type = "s") # s = schody ;)


##### wiecej parametrow graficznych mozna sprawdzic za pomoca
?par


###############################################################################
#
########   5 - adnotacje i linie referencyjne #######
#
###############################################################################

# po utworzeniu wykresu mozna do niego dolozyc adnotacje albo linie
?text
?abline


plot(mov$rating, mov$reviews, pch = 21, bg = "orange")
abline(v = mean(mov$rating), lty = 2, col = "red", lwd = 2)
abline(h = mean(mov$reviews), lty = 2, col = "red", lwd = 2)
text(x = 5.6, y = 4500, 
     labels = paste("średnia = ", round(mean(mov$rating), 2)), col = "red")
text(x = 2.4, y = 1100, 
     labels = paste("średnia = ", round(mean(mov$reviews), 2)), col = "red")




