CREATE TABLE ksiegowosc.pracownicy(
	id_pracownika SERIAL,
	imie varchar(255) NOT NULL,
	nazwisko varchar(255) NOT NULL,
	adres varchar(255),
	telefon varchar(255),
	PRIMARY KEY(id_pracownika)
);
COMMENT ON TABLE ksiegowosc.pracownicy IS 'Tabela przechowująca dane pracowników';

CREATE TABLE ksiegowosc.godziny(
	id_godziny SERIAL,
	data date NOT NULL,
	liczba_godzin decimal NOT NULL,
	id_pracownika int NOT NULL,
	PRIMARY KEY(id_godziny),
	FOREIGN KEY(id_pracownika) REFERENCES ksiegowosc.pracownicy(id_pracownika)
);
COMMENT ON TABLE ksiegowosc.godziny IS 'Tabela przechowująca dane o ilości przepracowanych godzin przez pracowników';

CREATE TABLE ksiegowosc.pensje(
	id_pensji SERIAL,
	stanowisko varchar(255),
	kwota decimal, /* tu powinno być NOT NULL */
	PRIMARY KEY(id_pensji)
);
COMMENT ON TABLE ksiegowosc.pensje IS 'Tabela przechowująca dane o pensjach';

CREATE TABLE ksiegowosc.premie(
	id_premii SERIAL,
	rodzaj varchar(255),
	kwota decimal NOT NULL,
	PRIMARY KEY(id_premii)
);
COMMENT ON TABLE ksiegowosc.premie IS 'Tabela przechowująca dane o premiach';

	CREATE TABLE ksiegowosc.(
		id_wynagrodzenia SERIAL,
		data date NOT NULl,
		id_pracownika int NOT NULL,
		id_godziny int NOT NULL,
		id_pensji int NOT NULL,
		id_premii int,
		PRIMARY KEY(id_wynagrodzenia),
		FOREIGN KEY(id_pracownika) REFERENCES ksiegowosc.pracownicy(id_pracownika),
		FOREIGN KEY(id_godziny) REFERENCES ksiegowosc.godziny(id_godziny),
		FOREIGN KEY(id_pensji) REFERENCES ksiegowosc.pensje(id_pensji),
		FOREIGN KEY(id_premii) REFERENCES ksiegowosc.premie(id_premii)
	);
COMMENT ON TABLE ksiegowosc.wynagrodzenia IS 'Tabela przechowująca dane o wynagrodzeniach';

INSERT INTO ksiegowosc.pracownicy (imie, nazwisko, adres, telefon)
VALUES
    ('Jan', 'Kowalski', 'ul. Kwiatowa 1, 00-001 Warszawa', '123-456-789'),
    ('Anna', 'Nowak', 'ul. Leśna 5, 02-002 Kraków', '987-654-321'),
    ('Piotr', 'Wiśniewski', 'ul. Słoneczna 10, 03-003 Gdańsk', '111-222-333'),
    ('Magdalena', 'Jankowska', 'ul. Zielona 15, 04-004 Wrocław', '444-555-666'),
    ('Marek', 'Dąbrowski', 'ul. Morska 20, 05-005 Poznań', '777-888-999'),
    ('Karolina', 'Lis', 'ul. Polna 25, 06-006 Łódź', '222-333-444'),
    ('Adam', 'Szymański', 'ul. Górska 30, 07-007 Katowice', '555-666-777'),
    ('Ewa', 'Wojciechowska', 'ul. Wiejska 35, 08-008 Lublin', '999-111-222'),
    ('Marcin', 'Kaczmarek', 'ul. Szkolna 40, 09-009 Szczecin', '333-444-555'),
    ('Natalia', 'Pawlak', 'ul. Parkowa 45, 10-010 Bydgoszcz', '666-777-888');

INSERT INTO ksiegowosc.godziny (data, liczba_godzin, id_pracownika)
VALUES
    ('2023-01-01', 163, 1),
    ('2023-01-02', 120, 2),
    ('2023-01-03', 190, 3),
    ('2023-01-04', 180, 4),
    ('2023-01-05', 167, 5),
    ('2023-01-06', 161, 6),
    ('2023-01-07', 160, 7),
    ('2023-01-08', 180, 8),
    ('2023-01-09', 200, 9),
    ('2023-01-10', 150, 10);

INSERT INTO ksiegowosc.pensje (stanowisko, kwota)
VALUES
    ('Księgowy', 1000),
    ('Specjalista ds. Finansów', 6000),
    ('Asystent Księgowego', 4000),
    ('Dyrektor Finansowy', 8000),
    ('Analityk Finansowy', 1500),
    ('Pracownik Działu Finansowego', 4500),
    ('Starszy Księgowy', 7000),
    ('Specjalista ds. Rachunkowości', 1200),
    ('Kierownik Finansowy', 2300),
    ('Asystent Finansowy', 4200);

INSERT INTO ksiegowosc.premie (rodzaj, kwota)
VALUES
    ('Nagroda za wyniki', 1000),
    ('Premia roczna', 2000),
    ('Bonus za efektywność', 1500),
    ('Podwyżka za staż pracy', 1200),
    ('Premia za dodatkowe projekty', 1800),
    ('Nagroda za wyjątkowy wkład', 2500),
    ('Bonus za osiągnięcia zespołu', 1600),
    ('Premia za szkolenie', 800),
    ('Wyróżnienie miesiąca', 900),
    ('Podwyżka za dodatkowe obowiązki', 1300);

INSERT INTO ksiegowosc.wynagrodzenia (data, id_pracownika, id_godziny, id_pensji, id_premii)
VALUES
    ('2023-01-01', 1, 1, 1, 1),
    ('2023-01-02', 2, 2, 2, 2),
    ('2023-01-03', 3, 3, 3, 3),
    ('2023-01-04', 4, 4, 4, NULL),
    ('2023-01-05', 5, 5, 5, 4),
    ('2023-01-06', 6, 6, 6, 5),
    ('2023-01-07', 7, 7, 7, 6),
    ('2023-01-08', 8, 8, 8, 7),
    ('2023-01-09', 9, 9, 9, NULL),
    ('2023-01-10', 10, 10, 10, 8);

SELECT id_pracownika, nazwisko FROM ksiegowosc.pracownicy;

SELECT pracownicy.id_pracownika FROM ksiegowosc.pracownicy
  INNER JOIN ksiegowosc.wynagrodzenia
  ON pracownicy.id_pracownika = wynagrodzenia.id_pracownika
  INNER JOIN ksiegowosc.pensje
  ON wynagrodzenia.id_pensji = pensje.id_pensji
  WHERE pensje.kwota > 1000;

SELECT pracownicy.id_pracownika, wynagrodzenia.id_premii FROM ksiegowosc.pracownicy
  INNER JOIN ksiegowosc.wynagrodzenia
  ON pracownicy.id_pracownika = wynagrodzenia.id_pracownika
  INNER JOIN ksiegowosc.pensje
  ON wynagrodzenia.id_pensji = pensje.id_pensji
  WHERE pensje.kwota > 2000 AND wynagrodzenia.id_premii IS NULL;

SELECT * FROM ksiegowosc.pracownicy WHERE imie LIKE 'J%';

SELECT * FROM ksiegowosc.pracownicy WHERE nazwisko LIKE '%n%' AND imie LIKE '%a';


SELECT pracownicy.imie, pracownicy.nazwisko, godziny.liczba_godzin-160 AS "nadgodziny" FROM ksiegowosc.pracownicy
  INNER JOIN ksiegowosc.godziny
  ON pracownicy.id_pracownika = godziny.id_pracownika WHERE godziny.liczba_godzin>160;

SELECT pracownicy.imie, pracownicy.nazwisko FROM ksiegowosc.pracownicy
  INNER JOIN ksiegowosc.wynagrodzenia
  ON pracownicy.id_pracownika = wynagrodzenia.id_pracownika
  INNER JOIN ksiegowosc.pensje
  ON wynagrodzenia.id_pensji = pensje.id_pensji
  WHERE pensje.kwota >= 1500 AND pensje.kwota <=3000;

SELECT pracownicy.imie, pracownicy.nazwisko FROM ksiegowosc.pracownicy
  INNER JOIN ksiegowosc.godziny
  ON pracownicy.id_pracownika = godziny.id_pracownika
  INNER JOIN ksiegowosc.wynagrodzenia
  ON pracownicy.id_pracownika = wynagrodzenia.id_pracownika
  WHERE godziny.liczba_godzin>160 AND wynagrodzenia.id_premii IS NULL;

SELECT imie, nazwisko, kwota FROM ksiegowosc.pracownicy
  INNER JOIN ksiegowosc.wynagrodzenia
  ON pracownicy.id_pracownika = wynagrodzenia.id_pracownika
  INNER JOIN ksiegowosc.pensje
  ON wynagrodzenia.id_pensji = pensje.id_pensji
  ORDER BY kwota;

SELECT imie, nazwisko, pensje.kwota+premie.kwota AS "pensja i premia" FROM ksiegowosc.pracownicy
  INNER JOIN ksiegowosc.wynagrodzenia
  ON pracownicy.id_pracownika = wynagrodzenia.id_pracownika
  INNER JOIN ksiegowosc.pensje
  ON wynagrodzenia.id_pensji = pensje.id_pensji
  LEFT JOIN ksiegowosc.premie
  ON wynagrodzenia.id_premii = premie.id_premii
  ORDER BY pensje.kwota+premie.kwota;

SELECT stanowisko, COUNT(*) AS liczba_pracownikow
FROM ksiegowosc.pracownicy
INNER JOIN ksiegowosc.wynagrodzenia  ON pracownicy.id_pracownika = wynagrodzenia.id_pracownika
INNER JOIN ksiegowosc.pensje ON wynagrodzenia.id_pensji = pensje.id_pensji
GROUP BY pensje.stanowisko;

SELECT 
    AVG(kwota) AS srednia_placa,
    MIN(kwota) AS minimalna_placa,
    MAX(kwota) AS maksymalna_placa
FROM ksiegowosc.pensje
WHERE stanowisko = 'Dyrektor Finansowy';

SELECT SUM(kwota) AS suma_wynagrodzen
FROM ksiegowosc.pensje


SELECT stanowisko, SUM(kwota) AS suma_wynagrodzen
FROM ksiegowosc.wynagrodzenia
INNER JOIN ksiegowosc.pensje ON wynagrodzenia.id_pensji = pensje.id_pensji
GROUP BY stanowisko;


  SELECT stanowisko, COUNT(wynagrodzenia.id_premii) AS liczba_premii
FROM ksiegowosc.wynagrodzenia
INNER JOIN ksiegowosc.pracownicy ON wynagrodzenia.id_pracownika = pracownicy.id_pracownika
INNER JOIN ksiegowosc.premie ON wynagrodzenia.id_premii = premie.id_premii
INNER JOIN ksiegowosc.pensje ON wynagrodzenia.id_pensji = pensje.id_pensji
GROUP BY stanowisko;

DELETE FROM ksiegowosc.pracownicy
WHERE id_pracownika IN (
    SELECT pracownicy.id_pracownika
    FROM ksiegowosc.pracownicy
    INNER JOIN ksiegowosc.wynagrodzenia ON pracownicy.id_pracownika = wynagrodzenia.id_pracownika
    INNER JOIN ksiegowosc.pensje ON wynagrodzenia.id_pensji = pensje.id_pensji
    WHERE kwota < 1200
);