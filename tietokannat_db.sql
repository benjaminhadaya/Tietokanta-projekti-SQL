--
-- File generated with SQLiteStudio v3.4.3 on Wed May 10 16:57:45 2023
--
-- Text encoding used: UTF-8
--
PRAGMA foreign_keys = off;
BEGIN TRANSACTION;

-- Table: Harjoitusryhmäkerrat
CREATE TABLE Harjoitusryhmäkerrat (
    kurssikoodi CHAR(10),
    ryhmäkoodi CHAR(10),
    aika DATETIME,
    PRIMARY KEY (ryhmäkoodi, aika),
    FOREIGN KEY (kurssikoodi, ryhmäkoodi) REFERENCES Harjoitusryhmät(kurssikoodi, ryhmäkoodi)
);
INSERT INTO Harjoitusryhmäkerrat (kurssikoodi, ryhmäkoodi, aika) VALUES ('CS-A1150', 'HR01', '2023-05-10 10:00:00');
INSERT INTO Harjoitusryhmäkerrat (kurssikoodi, ryhmäkoodi, aika) VALUES ('MS-A0003', 'HR02', '2023-05-11 10:00:00');
INSERT INTO Harjoitusryhmäkerrat (kurssikoodi, ryhmäkoodi, aika) VALUES ('ELEC-A0110', 'HR03', '2023-05-12 10:00:00');

-- Table: Harjoitusryhmät
CREATE TABLE Harjoitusryhmät (
    kurssikoodi CHAR(10),
    ryhmäkoodi CHAR(10),
    osallistujat INT CHECK (osallistujat >= 0),
    maksimiosanottajamäärä INT CHECK (osallistujat < maksimiosanottajamäärä),
    PRIMARY KEY (kurssikoodi, ryhmäkoodi),
    FOREIGN KEY (kurssikoodi) REFERENCES Kurssit(kurssikoodi)
);
INSERT INTO Harjoitusryhmät (kurssikoodi, ryhmäkoodi, osallistujat, maksimiosanottajamäärä) VALUES ('CS-A1150', 'HR01', 10, 20);
INSERT INTO Harjoitusryhmät (kurssikoodi, ryhmäkoodi, osallistujat, maksimiosanottajamäärä) VALUES ('MS-A0003', 'HR02', 15, 25);
INSERT INTO Harjoitusryhmät (kurssikoodi, ryhmäkoodi, osallistujat, maksimiosanottajamäärä) VALUES ('ELEC-A0110', 'HR03', 20, 30);

-- Table: Kurssikerrat
CREATE TABLE Kurssikerrat (
    kurssikoodi CHAR(10),
    lukukausi VARCHAR(255) NOT NULL,
    vuosi INT CHECK (vuosi > 1900),
    PRIMARY KEY (kurssikoodi, lukukausi, vuosi),
    FOREIGN KEY (kurssikoodi) REFERENCES Kurssit(kurssikoodi)
);
INSERT INTO Kurssikerrat (kurssikoodi, lukukausi, vuosi) VALUES ('CS-A1150', 'Kevät', 2023);
INSERT INTO Kurssikerrat (kurssikoodi, lukukausi, vuosi) VALUES ('MS-A0003', 'Kevät', 2023);
INSERT INTO Kurssikerrat (kurssikoodi, lukukausi, vuosi) VALUES ('ELEC-A0110', 'Syksy', 2022);

-- Table: Kurssit
CREATE TABLE Kurssit (
    kurssikoodi CHAR(10) PRIMARY KEY,
    nimi VARCHAR(255) NOT NULL,
    opintopistemäärä INT CHECK (opintopistemäärä >= 0)
);
INSERT INTO Kurssit (kurssikoodi, nimi, opintopistemäärä) VALUES ('CS-A1150', 'Tietokannat', 5);
INSERT INTO Kurssit (kurssikoodi, nimi, opintopistemäärä) VALUES ('MS-A0003', 'Matriisilaskenta', 5);
INSERT INTO Kurssit (kurssikoodi, nimi, opintopistemäärä) VALUES ('ELEC-A0110', 'Johdatus opiskeluun Sähkötekniikan kandidaattiohjelmassa', 2);

-- Table: Luennot
CREATE TABLE Luennot (
    luentotunnus CHAR(10),
    aika DATETIME,
    nimi VARCHAR(255) NOT NULL,
    kurssikoodi CHAR(10),
    lukukausi VARCHAR(255) NOT NULL,
    vuosi INT CHECK (vuosi > 1900),
    PRIMARY KEY (luentotunnus)
    FOREIGN KEY (kurssikoodi, lukukausi, vuosi) REFERENCES Kurssikerrat(kurssikoodi, lukukausi, vuosi)
);
INSERT INTO Luennot (luentotunnus, aika, nimi, kurssikoodi, lukukausi, vuosi) VALUES ('LT01', '2023-05-13 13:00:00', 'Johdatus kurssille', 'CS-A1150', 'Kevät', 2023);
INSERT INTO Luennot (luentotunnus, aika, nimi, kurssikoodi, lukukausi, vuosi) VALUES ('LT02', '2023-05-14 14:00:00', 'Gaussin eliminaatio', 'MS-A0003', 'Kevät', 2023);
INSERT INTO Luennot (luentotunnus, aika, nimi, kurssikoodi, lukukausi, vuosi) VALUES ('LT03', '2023-05-15 15:00:00', 'Vaihto-opinnot', 'ELEC-A0110', 'Syksy', 2022);

-- Table: OpiskelijaHarjoitusryhmät
CREATE TABLE OpiskelijaHarjoitusryhmät (
    opiskelijanumero INT,
    kurssikoodi CHAR(10),
    ryhmäkoodi CHAR(10),
    harjoitustehtäväpisteet INT DEFAULT 0 CHECK (harjoitustehtäväpisteet >= 0),
    PRIMARY KEY (opiskelijanumero, kurssikoodi, ryhmäkoodi),
    FOREIGN KEY (opiskelijanumero) REFERENCES Opiskelijat(opiskelijanumero),
    FOREIGN KEY (kurssikoodi, ryhmäkoodi) REFERENCES Harjoitusryhmät(kurssikoodi, ryhmäkoodi)
);
INSERT INTO OpiskelijaHarjoitusryhmät (opiskelijanumero, kurssikoodi, ryhmäkoodi, harjoitustehtäväpisteet) VALUES (10002001, 'CS-A1150', 'HR01', 0);
INSERT INTO OpiskelijaHarjoitusryhmät (opiskelijanumero, kurssikoodi, ryhmäkoodi, harjoitustehtäväpisteet) VALUES (10002001, 'ELEC-A0110', 'HR03', 0);
INSERT INTO OpiskelijaHarjoitusryhmät (opiskelijanumero, kurssikoodi, ryhmäkoodi, harjoitustehtäväpisteet) VALUES (10002001, 'MS-A0003', 'HR02', 0);
INSERT INTO OpiskelijaHarjoitusryhmät (opiskelijanumero, kurssikoodi, ryhmäkoodi, harjoitustehtäväpisteet) VALUES (10002002, 'CS-A1150', 'HR01', 0);
INSERT INTO OpiskelijaHarjoitusryhmät (opiskelijanumero, kurssikoodi, ryhmäkoodi, harjoitustehtäväpisteet) VALUES (10002002, 'ELEC-A0110', 'HR03', 0);
INSERT INTO OpiskelijaHarjoitusryhmät (opiskelijanumero, kurssikoodi, ryhmäkoodi, harjoitustehtäväpisteet) VALUES (10002002, 'MS-A0003', 'HR02', 0);
INSERT INTO OpiskelijaHarjoitusryhmät (opiskelijanumero, kurssikoodi, ryhmäkoodi, harjoitustehtäväpisteet) VALUES (10002003, 'CS-A1150', 'HR01', 0);
INSERT INTO OpiskelijaHarjoitusryhmät (opiskelijanumero, kurssikoodi, ryhmäkoodi, harjoitustehtäväpisteet) VALUES (10002003, 'ELEC-A0110', 'HR03', 0);
INSERT INTO OpiskelijaHarjoitusryhmät (opiskelijanumero, kurssikoodi, ryhmäkoodi, harjoitustehtäväpisteet) VALUES (10002003, 'MS-A0003', 'HR02', 0);

-- Table: Opiskelijat
CREATE TABLE Opiskelijat (
    opiskelijanumero INT,
    nimi VARCHAR(255) NOT NULL,
    syntymäaika DATE,
    tutkinto_ohjelma VARCHAR(255),
    otettuKirjoille DATE,
    opiskeluOikeudenLoppu DATE,
    PRIMARY KEY (opiskelijanumero)
);
INSERT INTO Opiskelijat (opiskelijanumero, nimi, syntymäaika, tutkinto_ohjelma, otettuKirjoille, opiskeluOikeudenLoppu) VALUES (10002001, 'Aamos Rex', '2000-01-06', 'Informaatioverkostot', '2020-09-01', '2024-08-31');
INSERT INTO Opiskelijat (opiskelijanumero, nimi, syntymäaika, tutkinto_ohjelma, otettuKirjoille, opiskeluOikeudenLoppu) VALUES (10002002, 'Gabriella Tolvanen', '2001-01-08', 'Bioinformaatioteknologia', '2021-09-01', '2025-08-31');
INSERT INTO Opiskelijat (opiskelijanumero, nimi, syntymäaika, tutkinto_ohjelma, otettuKirjoille, opiskeluOikeudenLoppu) VALUES (10002003, 'Kalle Berg', '2002-01-10', 'Tietotekniikka', '2022-09-01', '2026-08-31');
INSERT INTO Opiskelijat (opiskelijanumero, nimi, syntymäaika, tutkinto_ohjelma, otettuKirjoille, opiskeluOikeudenLoppu) VALUES (10002004, 'Maija Meikäläinen', '1990-01-01', 'Tietotekniikka', '2023-05-10', '2030-06-01');

-- Table: Rakennukset
CREATE TABLE Rakennukset (
    nimi VARCHAR(255) NOT NULL,
    katuosoite VARCHAR(255) NOT NULL,
    PRIMARY KEY (nimi, katuosoite)
);
INSERT INTO Rakennukset (nimi, katuosoite) VALUES ('TUAS-talo', 'Yliopistonkatu 1');
INSERT INTO Rakennukset (nimi, katuosoite) VALUES ('Väre', 'Tiedontie 2');
INSERT INTO Rakennukset (nimi, katuosoite) VALUES ('Kandikeskus', 'Matematiikankatu 3');

-- Table: Salit
CREATE TABLE Salit (
    salitunnus CHAR(10),
    paikkamäärä INT CHECK (paikkamäärä > 0),
    tenttaavienMäärä INT CHECK (tenttaavienMäärä >= 0),
    rakennus_nimi VARCHAR(255) NOT NULL,
    rakennus_katuosoite VARCHAR(255) NOT NULL, 
    PRIMARY KEY (salitunnus),
    FOREIGN KEY (rakennus_nimi, rakennus_katuosoite) REFERENCES Rakennukset(nimi, katuosoite)
);
INSERT INTO Salit (salitunnus, paikkamäärä, tenttaavienMäärä, rakennus_nimi, rakennus_katuosoite) VALUES ('S01', 100, 50, 'TUAS-talo', 'Yliopistonkatu 1');
INSERT INTO Salit (salitunnus, paikkamäärä, tenttaavienMäärä, rakennus_nimi, rakennus_katuosoite) VALUES ('S02', 200, 100, 'Väre', 'Tiedontie 2');
INSERT INTO Salit (salitunnus, paikkamäärä, tenttaavienMäärä, rakennus_nimi, rakennus_katuosoite) VALUES ('S03', 300, 150, 'Kandikeskus', 'Matematiikankatu 3');

-- Table: Tentit
CREATE TABLE Tentit (
    tenttitunnus CHAR(10),
    kurssikoodi CHAR(10),
    päivämäärä DATE,
    PRIMARY KEY (kurssikoodi, päivämäärä),
    FOREIGN KEY (kurssikoodi) REFERENCES Kurssit(kurssikoodi)
);
INSERT INTO Tentit (tenttitunnus, kurssikoodi, päivämäärä) VALUES ('T01', 'CS-A1150', '2023-06-01');
INSERT INTO Tentit (tenttitunnus, kurssikoodi, päivämäärä) VALUES ('T02', 'MS-A0003', '2023-06-02');
INSERT INTO Tentit (tenttitunnus, kurssikoodi, päivämäärä) VALUES ('T03', 'ELEC-A0110', '2023-06-03');

-- Table: Tentti_ilmoittautumiset
CREATE TABLE Tentti_ilmoittautumiset (
    opiskelijanumero INT,
    tenttiilmoitustunnus CHAR(10),
    ilmoittautumispäivä DATE,
    tenttikysymystenKieli VARCHAR(255) NOT NULL,
    kurssikoodi CHAR(10),
    päivämäärä DATE,
    PRIMARY KEY (opiskelijanumero, tenttiilmoitustunnus, ilmoittautumispäivä),
    FOREIGN KEY (opiskelijanumero) REFERENCES Opiskelijat(opiskelijanumero)
    FOREIGN KEY (kurssikoodi, päivämäärä) REFERENCES Tentit(kurssikoodi, päivämäärä)
);
INSERT INTO Tentti_ilmoittautumiset (opiskelijanumero, tenttiilmoitustunnus, ilmoittautumispäivä, tenttikysymystenKieli, kurssikoodi, päivämäärä) VALUES (10002001, '1', '2023-05-20', 'Englanti', 'CS-A1150', '2023-06-01');
INSERT INTO Tentti_ilmoittautumiset (opiskelijanumero, tenttiilmoitustunnus, ilmoittautumispäivä, tenttikysymystenKieli, kurssikoodi, päivämäärä) VALUES (10002001, '2', '2023-05-20', 'Englanti', 'MS-A0003', '2023-06-02');
INSERT INTO Tentti_ilmoittautumiset (opiskelijanumero, tenttiilmoitustunnus, ilmoittautumispäivä, tenttikysymystenKieli, kurssikoodi, päivämäärä) VALUES (10002001, '3', '2023-05-20', 'Englanti', 'ELEC-A0110', '2023-06-03');
INSERT INTO Tentti_ilmoittautumiset (opiskelijanumero, tenttiilmoitustunnus, ilmoittautumispäivä, tenttikysymystenKieli, kurssikoodi, päivämäärä) VALUES (10002002, '4', '2023-05-21', 'Suomi', 'CS-A1150', '2023-06-01');
INSERT INTO Tentti_ilmoittautumiset (opiskelijanumero, tenttiilmoitustunnus, ilmoittautumispäivä, tenttikysymystenKieli, kurssikoodi, päivämäärä) VALUES (10002002, '5', '2023-05-21', 'Suomi', 'MS-A0003', '2023-06-02');
INSERT INTO Tentti_ilmoittautumiset (opiskelijanumero, tenttiilmoitustunnus, ilmoittautumispäivä, tenttikysymystenKieli, kurssikoodi, päivämäärä) VALUES (10002002, '6', '2023-05-21', 'Suomi', 'ELEC-A0110', '2023-06-03');
INSERT INTO Tentti_ilmoittautumiset (opiskelijanumero, tenttiilmoitustunnus, ilmoittautumispäivä, tenttikysymystenKieli, kurssikoodi, päivämäärä) VALUES (10002003, '7', '2023-05-22', 'Ruotsi', 'CS-A1150', '2023-06-01');
INSERT INTO Tentti_ilmoittautumiset (opiskelijanumero, tenttiilmoitustunnus, ilmoittautumispäivä, tenttikysymystenKieli, kurssikoodi, päivämäärä) VALUES (10002003, '8', '2023-05-22', 'Ruotsi', 'MS-A0003', '2023-06-02');
INSERT INTO Tentti_ilmoittautumiset (opiskelijanumero, tenttiilmoitustunnus, ilmoittautumispäivä, tenttikysymystenKieli, kurssikoodi, päivämäärä) VALUES (10002003, '9', '2023-05-22', 'Ruotsi', 'ELEC-A0110', '2023-06-03');
INSERT INTO Tentti_ilmoittautumiset (opiskelijanumero, tenttiilmoitustunnus, ilmoittautumispäivä, tenttikysymystenKieli, kurssikoodi, päivämäärä) VALUES (10002004, '10', '2023-05-23', 'Suomi', 'CS-A1150', '2023-06-01');

-- Table: Tentti_suoritukset
CREATE TABLE Tentti_suoritukset (
    opiskelijanumero INT,
    tenttisuoritustunnus CHAR(10),
    arvosana INT CHECK (arvosana BETWEEN 0 AND 5),
    kurssikoodi CHAR(10),
    päivämäärä DATE,
    PRIMARY KEY (opiskelijanumero, tenttisuoritustunnus),
    FOREIGN KEY (opiskelijanumero) REFERENCES Opiskelijat(opiskelijanumero)
    FOREIGN KEY (kurssikoodi, päivämäärä) REFERENCES Tentit(kurssikoodi, päivämäärä)
);
INSERT INTO Tentti_suoritukset (opiskelijanumero, tenttisuoritustunnus, arvosana, kurssikoodi, päivämäärä) VALUES (10002001, '1', 3, 'CS-A1150', '2023-06-01');
INSERT INTO Tentti_suoritukset (opiskelijanumero, tenttisuoritustunnus, arvosana, kurssikoodi, päivämäärä) VALUES (10002001, '2', 5, 'MS-A0003', '2023-06-02');
INSERT INTO Tentti_suoritukset (opiskelijanumero, tenttisuoritustunnus, arvosana, kurssikoodi, päivämäärä) VALUES (10002001, '3', 5, 'ELEC-A0110', '2023-06-03');
INSERT INTO Tentti_suoritukset (opiskelijanumero, tenttisuoritustunnus, arvosana, kurssikoodi, päivämäärä) VALUES (10002002, '4', 3, 'CS-A1150', '2023-06-01');
INSERT INTO Tentti_suoritukset (opiskelijanumero, tenttisuoritustunnus, arvosana, kurssikoodi, päivämäärä) VALUES (10002002, '5', 2, 'MS-A0003', '2023-06-02');
INSERT INTO Tentti_suoritukset (opiskelijanumero, tenttisuoritustunnus, arvosana, kurssikoodi, päivämäärä) VALUES (10002002, '6', 1, 'ELEC-A0110', '2023-06-03');
INSERT INTO Tentti_suoritukset (opiskelijanumero, tenttisuoritustunnus, arvosana, kurssikoodi, päivämäärä) VALUES (10002003, '7', 5, 'CS-A1150', '2023-06-01');
INSERT INTO Tentti_suoritukset (opiskelijanumero, tenttisuoritustunnus, arvosana, kurssikoodi, päivämäärä) VALUES (10002003, '8', 4, 'MS-A0003', '2023-06-02');
INSERT INTO Tentti_suoritukset (opiskelijanumero, tenttisuoritustunnus, arvosana, kurssikoodi, päivämäärä) VALUES (10002003, '9', 4, 'ELEC-A0110', '2023-06-03');
INSERT INTO Tentti_suoritukset (opiskelijanumero, tenttisuoritustunnus, arvosana, kurssikoodi, päivämäärä) VALUES (10002004, '10', 5, 'CS-A1150', '2023-06-01');

-- Table: Työntekijät
CREATE TABLE Työntekijät (
    tunnus INT,
    tehtävänimike VARCHAR(255) NOT NULL,
    nimi VARCHAR(255) NOT NULL,
    osoite VARCHAR(255) NOT NULL,
    puhelinnumero VARCHAR(255) NOT NULL,
    työsuhteenAlkamispäivä DATE,
    työsuhteenPäättymispäivä DATE CHECK (työsuhteenAlkamispäivä < työsuhteenPäättymispäivä),
    PRIMARY KEY (tunnus)
);
INSERT INTO Työntekijät (tunnus, tehtävänimike, nimi, osoite, puhelinnumero, työsuhteenAlkamispäivä, työsuhteenPäättymispäivä) VALUES (1001, 'Professori', 'Prof. A', 'Yliopistonkatu 1', '0123456789', 2018, 2023);
INSERT INTO Työntekijät (tunnus, tehtävänimike, nimi, osoite, puhelinnumero, työsuhteenAlkamispäivä, työsuhteenPäättymispäivä) VALUES (1002, 'Assistantti', 'Tauno Palo', 'Töölönkatu 2', '9876543210', 2019, 2024);
INSERT INTO Työntekijät (tunnus, tehtävänimike, nimi, osoite, puhelinnumero, työsuhteenAlkamispäivä, työsuhteenPäättymispäivä) VALUES (1003, 'Siivooja', 'Silvia Laine', 'Puistokatu 3', '1234567890', 2020, 2021);

-- Table: Varaus
CREATE TABLE Varaus (
    varaustunnus CHAR(10),
    päivämäärä DATE,
    kellonaika TIME,
    varauksenPituus INT CHECK (varauksenPituus > 0),
    varauksenTilaisuus VARCHAR(255) CHECK (varauksenTilaisuus IN ('Tentti', 'Luento', 'Harjoitusryhmäkerta')) NOT NULL,
    tilaisuuden_tunnus CHAR(10),
    varauksen_tekijän_tunnus INT,
    salitunnus CHAR(10),
    PRIMARY KEY (varaustunnus),
    FOREIGN KEY (varauksen_tekijän_tunnus) REFERENCES Työntekijät(tunnus),
    FOREIGN KEY (salitunnus) REFERENCES Salit(salitunnus)
);
INSERT INTO Varaus (varaustunnus, päivämäärä, kellonaika, varauksenPituus, varauksenTilaisuus, tilaisuuden_tunnus, varauksen_tekijän_tunnus, salitunnus) VALUES ('VR01', '2023-05-30', '10:00:00', 180, 'Tentti', 'T01', 1002, 'S01');
INSERT INTO Varaus (varaustunnus, päivämäärä, kellonaika, varauksenPituus, varauksenTilaisuus, tilaisuuden_tunnus, varauksen_tekijän_tunnus, salitunnus) VALUES ('VR02', '2023-05-30', '10:00:00', 180, 'Tentti', 'T01', 1002, 'S02');
INSERT INTO Varaus (varaustunnus, päivämäärä, kellonaika, varauksenPituus, varauksenTilaisuus, tilaisuuden_tunnus, varauksen_tekijän_tunnus, salitunnus) VALUES ('VR03', '2023-05-30', '10:00:00', 180, 'Tentti', 'T01', 1002, 'S03');
INSERT INTO Varaus (varaustunnus, päivämäärä, kellonaika, varauksenPituus, varauksenTilaisuus, tilaisuuden_tunnus, varauksen_tekijän_tunnus, salitunnus) VALUES ('VR04', '2023-05-28', '11:15:00', 105, 'Luento', 'LT01', 1001, 'S02');
INSERT INTO Varaus (varaustunnus, päivämäärä, kellonaika, varauksenPituus, varauksenTilaisuus, tilaisuuden_tunnus, varauksen_tekijän_tunnus, salitunnus) VALUES ('VR05', '2023-05-31', '11:15:00', 105, 'Luento', 'LT02', 1001, 'S02');
INSERT INTO Varaus (varaustunnus, päivämäärä, kellonaika, varauksenPituus, varauksenTilaisuus, tilaisuuden_tunnus, varauksen_tekijän_tunnus, salitunnus) VALUES ('VR06', '2023-06-01', '12:00:00', 90, 'Harjoitusryhmäkerta', 'HR01', 1003, 'S03');

-- Table: Varusteet
CREATE TABLE Varusteet (
    varustetunnus CHAR(10),
    tyyppi VARCHAR(255) NOT NULL,
    PRIMARY KEY (varustetunnus)
);
INSERT INTO Varusteet (varustetunnus, tyyppi) VALUES ('V01', 'Projektori');
INSERT INTO Varusteet (varustetunnus, tyyppi) VALUES ('V02', 'Liitutaulu');
INSERT INTO Varusteet (varustetunnus, tyyppi) VALUES ('V03', 'Tietokone');

-- View: Tulevat_Luennot
CREATE VIEW Tulevat_Luennot AS
SELECT
    K.nimi AS Kurssin_Nimi,
    L.aika AS Luennon_Aika,
    L.nimi AS Luennon_Nimi,
    S.salitunnus AS Sali,
    R.nimi AS Rakennuksen_Nimi,
    R.katuosoite AS Rakennuksen_Osoite
FROM
    Luennot L
    JOIN Kurssikerrat KK ON L.kurssikoodi = KK.kurssikoodi AND L.lukukausi = KK.lukukausi AND L.vuosi = KK.vuosi
    JOIN Kurssit K ON KK.kurssikoodi = K.kurssikoodi
    JOIN Varaus V ON L.luentotunnus = V.tilaisuuden_tunnus AND DATE(L.aika) = V.päivämäärä AND V.varauksenTilaisuus = 'Luento'
    JOIN Salit S ON V.salitunnus = S.salitunnus
    JOIN Rakennukset R ON S.rakennus_nimi = R.nimi AND S.rakennus_katuosoite = R.katuosoite
WHERE
    L.aika >= CURRENT_TIMESTAMP
ORDER BY
    L.aika;

-- View: Tulevat_Tentit
CREATE VIEW Tulevat_Tentit AS
SELECT
    K.nimi AS Kurssin_Nimi,
    T.päivämäärä AS Tentin_Päivämäärä,
    S.salitunnus AS Sali,
    R.nimi AS Rakennuksen_Nimi,
    R.katuosoite AS Rakennuksen_Osoite
FROM
    Tentit T
    JOIN Kurssit K ON T.kurssikoodi = K.kurssikoodi
    JOIN Varaus V ON T.tenttitunnus = V.tilaisuuden_tunnus AND T.päivämäärä = V.päivämäärä AND V.varauksenTilaisuus = 'Tentti'
    JOIN Salit S ON V.salitunnus = S.salitunnus
    JOIN Rakennukset R ON S.rakennus_nimi = R.nimi AND S.rakennus_katuosoite = R.katuosoite
WHERE
    T.päivämäärä >= CURRENT_DATE
ORDER BY
    T.päivämäärä;

COMMIT TRANSACTION;
PRAGMA foreign_keys = on;
