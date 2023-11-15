--
-- File generated with SQLiteStudio v3.4.3 on Wed May 10 16:57:45 2023
--
-- Text encoding used: UTF-8
--
PRAGMA foreign_keys = off;
BEGIN TRANSACTION;

-- Käyttötapaus 1: Uuden opiskelijan rekisteröinti
SELECT MAX(opiskelijanumero) + 1 AS uusi_opiskelijanumero
FROM Opiskelijat;

SELECT opiskelijanumero
FROM Opiskelijat
WHERE opiskelijanumero = 10002004;

INSERT INTO Opiskelijat (opiskelijanumero, nimi, syntymäaika, tutkinto_ohjelma,
otettuKirjoille, opiskeluOikeudenLoppu)
VALUES(10002004, 'Maija Meikäläinen', '1990-01-01', 'Tietotekniikka',
CURRENT_DATE, '2030-06-01');

-- Käyttötapaus 2: Ilmoitetaan opiskelija tenttiin
SELECT opiskelijanumero
FROM Opiskelijat
WHERE opiskelijanumero = 10002004;

SELECT kurssikoodi
FROM Kurssit
WHERE kurssikoodi = 'CS-A1150';

SELECT MAX(tenttiilmoitustunnus) + 1 AS uusi_tenttiilmoitustunnus
FROM Tentti_ilmoittautumiset;

INSERT INTO Tentti_ilmoittautumiset (opiskelijanumero, tenttiilmoitustunnus,
ilmoittautumispäivä, tenttikysymystenKieli, kurssikoodi, päivämäärä)
VALUES (10002004, 10, '2023-05-23', 'Suomi', 'CS-A1150', '2023-06-01');

-- Käyttötapaus 3: Tenttitulosten lisääminen
SELECT MAX(tenttisuoritustunnus) + 1 AS uusi_tenttisuoritustunnus
FROM Tentti_suoritukset;

INSERT INTO Tentti_suoritukset(opiskelijanumero, tenttisuoritustunnus,
arvosana, kurssikoodi, päivämäärä)
VALUES(10002004, 10, 5, 'CS-A1150', '2023-06-01');

-- Käyttötapaus 4: Kurssin tenttitulosten keskiarvo
SELECT ts.opiskelijanumero, o.nimi AS opiskelijan_nimi, ts.arvosana
FROM Tentti_suoritukset AS ts
JOIN Tentti_ilmoittautumiset AS ti ON ts.opiskelijanumero = ti.opiskelijanumero
JOIN Opiskelijat AS o ON ts.opiskelijanumero = o.opiskelijanumero
WHERE ti.kurssikoodi = 'CS-A1150';

SELECT AVG(ts.arvosana) AS keskiarvo
FROM Tentti_suoritukset AS ts
JOIN Tentti_ilmoittautumiset AS ti ON ts.opiskelijanumero = ti.opiskelijanumero
WHERE ti.kurssikoodi = 'CS-A1150';


-- Käyttötapaus 5: Opiskelijoiden arvosanajakauma I
SELECT ts.arvosana, COUNT(*) as lukumäärä
FROM Tentti_suoritukset AS ts
JOIN Tentti_ilmoittautumiset AS ti ON ts.opiskelijanumero = ti.opiskelijanumero
WHERE ti.kurssikoodi = 'MS-A0003'
GROUP BY ts.arvosana
ORDER BY ts.arvosana;

-- Käyttötapaus 6: Opiskelijoiden arvosanajakauma II
SELECT o.tutkinto_ohjelma, AVG(ts.arvosana) AS keskiarvo, COUNT(*) as
opiskelijoiden_lukumäärä
FROM Opiskelijat AS o
JOIN Tentti_suoritukset AS ts ON ts.opiskelijanumero = o.opiskelijanumero
GROUP BY o.tutkinto_ohjelma
ORDER BY keskiarvo DESC

-- Käyttötapaus 7: Opiskelijoiden opintopisteet
SELECT o.opiskelijanumero, o.nimi, SUM(k.opintopistemäärä) as
kokonaisopintopisteet
FROM Opiskelijat AS o
JOIN Tentti_ilmoittautumiset AS ti ON o.opiskelijanumero = ti.opiskelijanumero
JOIN Kurssit AS k ON ti.kurssikoodi = k.kurssikoodi
JOIN Tentti_suoritukset AS ts ON ti.opiskelijanumero = ts.opiskelijanumero
WHERE ts.arvosana > 0
GROUP BY o.opiskelijanumero, o.nimi
ORDER BY kokonaisopintopisteet DESC;

-- Käyttötapaus 8: Yliopiston salit
SELECT Salitunnus, paikkamäärä, nimi AS RakennuksenNimi, katuosoite
FROM Salit, Rakennukset
ORDER BY katuosoite, paikkamäärä DESC;

-- Käyttötapaus 9: Kurssille ilmoittautuneet opiskelijat
SELECT O.opiskelijanumero, O.nimi
FROM Opiskelijat O
JOIN OpiskelijaHarjoitusryhmät OH ON O.opiskelijanumero = OH.opiskelijanumero
WHERE OH.kurssikoodi = 'CS-A1150';

-- Käyttötapaus 10: Eniten varauksia tehnyt työntekijä

SELECT V.varauksen_tekijän_tunnus, COUNT(V.varaustunnus) AS varausten_määrä
FROM Varaus V
JOIN Työntekijät T ON V.varauksen_tekijän_tunnus = T.tunnus
GROUP BY V.varauksen_tekijän_tunnus
ORDER BY varausten_määrä DESC
LIMIT 1;

-- Käyttötapaus 11: Kurssi, jolla eniten kurssikertoja
SELECT k.nimi, k.kurssikoodi, COUNT(k.kurssikoodi) AS kertoja_pidetty
FROM Kurssit AS k
JOIN Kurssikerrat AS kk ON k.kurssikoodi = kk.kurssikoodi
GROUP BY k.kurssikoodi
ORDER BY kertoja_pidetty DESC;

-- Käyttötapaus 12: Tutkinto-ohjelmat järjestykseen
SELECT O.tutkinto_ohjelma, AVG(T.arvosana) AS Keskiarvo
FROM Opiskelijat O
JOIN Tentti_suoritukset T ON O.opiskelijanumero = T.opiskelijanumero
WHERE T.kurssikoodi = 'CS-A1150'
GROUP BY O.tutkinto_ohjelma
ORDER BY Keskiarvo DESC;

-- Käyttötapaus 13: Tutkinto-ohjelmien opiskelijamäärät
SELECT O.tutkinto_ohjelma, COUNT(*) AS Määrä
FROM Opiskelijat O
GROUP BY O.tutkinto_ohjelma
ORDER BY Määrä DESC;

-- Käyttötapaus 14: Yliopiston vaikein kurssi
WITH KurssiKeskiarvot AS (
SELECT T.kurssikoodi, AVG(T.arvosana) AS Keskiarvosana
FROM Tentti_suoritukset T
GROUP BY T.kurssikoodi
)
SELECT kurssikoodi, Keskiarvosana
FROM KurssiKeskiarvot
WHERE Keskiarvosana = (SELECT MIN(Keskiarvosana) FROM KurssiKeskiarvot);

-- Käyttötapaus 15: Tietyt ehdot täyttävät opiskelijat
WITH Keskiarvot AS (
SELECT T.opiskelijanumero, AVG(T.arvosana) AS Keskiarvosana
FROM Tentti_suoritukset T
WHERE T.arvosana > 0
GROUP BY T.opiskelijanumero
), Opintopisteet AS (
SELECT T.opiskelijanumero, SUM(K.opintopistemäärä) AS Opintopistemäärä
FROM Tentti_suoritukset T
JOIN Kurssit K ON T.kurssikoodi = K.kurssikoodi
WHERE T.arvosana > 0
GROUP BY T.opiskelijanumero
)
SELECT O.opiskelijanumero, O.tutkinto_ohjelma,
Opintopisteet.Opintopistemäärä, Keskiarvot.Keskiarvosana
FROM Opiskelijat O
JOIN Keskiarvot ON O.opiskelijanumero = Keskiarvot.opiskelijanumero
JOIN Opintopisteet ON O.opiskelijanumero = Opintopisteet.opiskelijanumero
WHERE Opintopisteet.Opintopistemäärä > 10 AND Keskiarvot.Keskiarvosana >=
3;

