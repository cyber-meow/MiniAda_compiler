with Ada.Text_IO; use Ada.Text_IO;

procedure Test is
   function F(X: Integer) return integer is begin X:= 1; return 0; end;
begin
   if F(42) = 0 then new_line; end if;
end;
