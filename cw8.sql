CREATE FUNCTION fib(n INT)
RETURNS BIGINT AS $$
BEGIN
	IF n <= 0 THEN
		RETURN 0;
	ELSIF n = 1 THEN
		RETURN 1;
	ELSE 
		return fib(n-1) + fib(n-2);
	END IF;
END;
$$ language plpsql;

CREATE PROCEDURE print_fib(n INT)
LANGUAGE plpsql
AS $$
DECLARE
	counter INT := 1;
	number BIGINT;
BEGIN
	WHILE counter <= n LOOP	
		number := fib(counter)
		RAISE NOTICE 'Liczba fibonaciego %: %' counter, number;
		counter := counter + 1;
	END LOOP;
END;
$$;

------


CREATE FUNCTION duzelitery()
RETURNS TRIGGER AS $$
BEGIN 
	NEW.surname := UPPER(NEW.lastname);
	RETURN NEW;
END;
$$ LANGUAGE plpsql;

CREATE TRIGGER przedwpisaniem
BEFORE INSERT ON person.person
FOR EACH ROWEXECUTE FUNCTION duzelitery();



--------

CREATE FUNCTION sprawdz() RETURNS TRIGGER AS $$
DECLARE
	stare DECIMAL(18,2);
	nowe DECIMAL(18,2);
	zmiana DECIMAL(5,2);
BEGIN
	stare := OLD.TaxRate;
	nowe := NEW.TaxRate;
	zmiana := ABS((nowe-stare)/stare);
	IF zmiana > 0.3 THEN
		RAISE EXPECTION 'za duza zmiana'
	END IF;
	
	RETURN NEW;
END;
$$ LANGUAGE plpsql;

CREATE TRIGGER monitorowanie
BEFORE UPDATE ON sales.salestaxrate
FOR EACH ROW
EXECUTE FUNCTION sprawdz();