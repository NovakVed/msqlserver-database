/*


													JEDNOSTAVNI UPITI


*/
--Ispisuje sve korisnike
SELECT * FROM Korisnik;

--Ispisuje sve hotele
SELECT * FROM Hotel;

--Ispisuje sve goste
SELECT * FROM Gost;

--Gosti koji imaju barem jedan referal!
SELECT * FROM Gost
WHERE [Id_referal] IS NOT NULL;

SELECT * FROM Korisnik;

--Pretraga specifičnog zaposlenika sa određenim ID-em
SELECT * FROM Zaposlenik
WHERE Id_zaposlenika = 16;

--Pretraga zaposlenika s ID-eovima od 10 do 16
SELECT * FROM Zaposlenik
WHERE Id_zaposlenika BETWEEN 10 AND 16;

--Pretraga svih uloga
SELECT u.[Opis uloge], u.Uloga  FROM Uloge u

--Pretraga svih uloga koji koje izvršavaju recepcioneri
SELECT * FROM Uloge
WHERE [Uloga] LIKE '%recepcioner%'

--Pretraga soba i apartmana kojima noćenje dođe manje od 170€
SELECT * FROM Soba s
WHERE s.[Cijena/noć] < 170;

--Pretraga svih soba koje imaju pogled na more i da noćenje dođe manje od 180€
SELECT Broj_sobe AS "Broj sobe", [Cijena/noć] AS "Cijena noćenja"
FROM Soba
WHERE [Pogled na more] = 'Da' AND [Cijena/noć] > 180;

/*


											SLOŽENI UPITI


*/

--Prikazuje Ime, Prezime i Adresu iz zablice zaposlenika koji imaju ID jednak 1, 5, 6, 8 i/ili 10,
--te poredani su uzlazno
SELECT k.Ime, k.Prezime, k.Adresa 
FROM Zaposlenik z
JOIN Korisnik k
ON k.Id_korisnik = z.Id_korisnik
WHERE Id_zaposlenika IN (5, 6, 8, 10)
ORDER BY Ime ASC;

--Ukupan broj gostiju
SELECT COUNT(*) AS 'Ukupan broj gositju' FROM Gost;

--Ukupan broj gostiju koji nisu dobili nikakvu preporuku od drugog gosta
SELECT COUNT(*) AS 'Broj gostiju bez dobivenih preporuka' FROM Gost
WHERE Id_referal IS NULL;

--Ukupan broj gostiju koji su dobili preporuku od drugog gosta
SELECT COUNT(Id_referal) AS 'Broj gostiju koji su dobili preporuku od drugog gosta' FROM Gost;

--Najsuplja soba s noćenjem
SELECT MAX([Cijena/noć]) AS 'Najveća cijena sobe' FROM	Soba;

--Najjeftinija soba s noćenjem
SELECT MIN([Cijena/noć]) AS 'Najmanja cijena sobe' FROM	Soba;

--Nađi ime i prezime gosta koji je plaio racun i rezervirao apartman/sobu!          NADOPUNI PODATKE U TABLICI!!!
SELECT	k.[Ime] AS "Ime gosta", k.[Prezime] AS "Prezime gosta", k.Godište--, g.Državljanstvo
FROM	Gost g JOIN Rezervacije r
ON		g.Id_gosta = r.Id_gosta
JOIN	Racun ra
ON		ra.Id_rezervacije = r.Id_rezervacija
JOIN	Korisnik k
ON		g.Id_korisnik = k.Id_korisnik

--Nađi sve o zaposlenicima
SELECT	k.Ime AS "Ime Zaposlenika", k.Prezime AS "Prezime Zaposlenika",
		k.Adresa, k.Email, u.Uloga, u.[Opis uloge]
FROM	Zaposlenik z JOIN Uloge u
ON		z.Id_uloga = u.Id_uloge
JOIN	Korisnik k
ON		z.Id_korisnik = k.Id_korisnik

--Nađi sve o zaposleniku koji je ispisao račun gostu
SELECT	k.Ime + k.Prezime AS "Zaposlenik", k.Adresa, u.Uloga, u.[Opis uloge],
		r.Id_racuna AS "ID ispisanog racuna", r.[Ukupan trošak] AS "Cijena za uplatiti",
		r.[Datum plačanja] AS "Datum ispisanog racuna"
FROM	Zaposlenik z, Racun r, Uloge u, Korisnik k
WHERE	z.Id_zaposlenika = r.Id_zaposlenika AND z.Id_uloga = u.Id_uloge AND k.Id_korisnik = z.Id_korisnik

--Nađi sve o ispisanog računu!
SELECT	k.Ime, k.Prezime, r.Id_racuna AS "ID ispisanog racuna", r.[Ukupan trošak] AS "Cijena za uplatiti",
		r.[Datum plačanja] AS "Datum ispisanog racuna"
FROM	Zaposlenik z JOIN Racun r
ON		z.Id_zaposlenika = r.Id_zaposlenika
JOIN	Korisnik k
ON		k.Id_korisnik = z.Id_korisnik

--Ostvareni popust na isplati racuna!
SELECT	r.Id_racuna, 
		(s.[Cijena/noć]*DATEDIFF(DAY,rezer.[Datum check-in],rezer.[Datum check-out])) AS "Cijena Soba bez uključenog popousta",
		r.[Ukupan trošak], p.[Opis popusta], p.[Postotak skinute cijene]
FROM	Popusti p JOIN Racun r
ON		p.Id_popust = r.Id_popust
JOIN	Rezervacije rezer
ON		rezer.Id_rezervacija = r.Id_rezervacije
JOIN	Soba s
ON		s.Id_sobe = rezer.Id_soba

--U kojem hotelu se nalazi koja soba
SELECT	s.Broj_sobe AS "Broj Sobe", h.Ime AS "Naziv Hotela", g.Ime_grada AS "Grad u kojem se nalazi hotel", h.Adresa AS "Adresa hotela"
FROM	Soba s join Hotel h
ON		s.Id_hotel = h.Id_hotel
JOIN	Grad g
ON		g.Id_grad = h.Id_grad

/*



								UPISI U TABLICE RADI TESTIRANJA TRIGGERA I CHECK CONSTRAINT-A



*/

--Upisuje upisivanja 'values' u tablicu
INSERT INTO Apartmani ([Adresa], [Broj soba], [Pogled na more], [Perilica], [Terasa], [Cijena/noć]) values ('Adresa Besa ul. 16', 1, 'Da', 'Ne', 'Ne', 80);

--Provjera 'CHECK constraint' kod rezervacije da se ne moze rezervirati apartman/ili soba ako je check-out prije nego check-in!
INSERT INTO Rezervacije ([Id_soba], [Id_apartman], [Id_gosta], [Datum check-in], [Datum check-out], [Id_ugovaranje_putem]) 
values (2, NULL, 6546846,'2019/10/10', '2019/09/09', 1);

--Proba Triggera da gost ne moze rezervirati sobu ili apartman ako je vec unaprijed rezervirana od nekog drugog gosta
INSERT INTO Rezervacije ([Id_soba], [Id_apartman], [Id_gosta], [Datum check-in], [Datum check-out], [Id_ugovaranje_putem]) 
values (9, NULL, 6546846,'2018/11/21', '2018/12/09', 1);

INSERT INTO Rezervacije ([Id_soba], [Id_apartman], [Id_gosta], [Datum check-in], [Datum check-out], [Id_ugovaranje_putem]) 
values (7, NULL, 6546846,'2018/11/21', '2018/12/09', 1);

INSERT INTO Rezervacije ([Id_soba], [Id_apartman], [Id_gosta], [Datum check-in], [Datum check-out], [Id_ugovaranje_putem]) 
values (9, NULL, 6546846,'2019/12/21', '2019/12/29', 1);

INSERT INTO Rezervacije ([Id_soba], [Id_apartman], [Id_gosta], [Datum check-in], [Datum check-out], [Id_ugovaranje_putem]) 
values (2, NULL, 6546846,'2018/11/16', '2018/11/29', 1);

--Proba Trigger Gost koji je preporucio hotel drugom gostu
INSERT INTO Gost ([Id_gosta], [Ime],[Prezime], [Adresa], [Državljanstvo], [Godište], [E-mail], [Id_referal])
values (9815809, 'Dovak', 'Brovak', NULL, 'Rusija', '2000/09/09', NULL, 6546846);

--Proba Trigger Racun 
INSERT INTO Racun(Id_popust, Id_zaposlenika, [Datum plačanja], Id_rezervacije, Id_nacin_placanja)
values (1, 13, '2019/01/31', 4, 2);

/*

											SYSTEMSKI UPITI!

*/

--Nađi sve triggere koji postoje
select * from sys.triggers