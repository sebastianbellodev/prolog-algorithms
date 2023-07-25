prime(Number):-mod(Number, 1)=:=0,mod(Number, Number)=:=0,not(mod(Number, 2)=:=0),
not(mod(Number, 3)=:=0).
prime(2).
prime(3).
