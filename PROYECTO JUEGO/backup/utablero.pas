unit uTablero;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils,Graphics,Dialogs;
type

  { tablero }

  tablero=class
    private
      Canvas:Tcanvas;
      public
        coord:array[1..8,1..8]of integer;
        constructor cear();
        procedure Inicializar();
        function MovimientoValido(X,Y,Ax,Ay:integer):boolean;

  end;

implementation

{ tablero }

constructor tablero.cear;
begin
  Inicializar();
end;

procedure tablero.Inicializar;
var
  i, j: Integer;
begin
  // Inicializa el tablero
   for i := 1 to 8 do
  begin
    for j := 1 to 8 do
    begin
      if((i+j)mod 2<>0)then
      begin
        if i < 4 then
          coord[i, j] := 1
        else if i > 5 then
          coord[i, j] := 2;
      end;
      if((i+j)mod 2=0)then
      coord[i,j]:=0;
    end;
  end;

end;


function tablero.MovimientoValido(X, Y, Ax, Ay: integer): boolean;
 var
  PiezaJu, PiezaOp: Integer;
  DX, DY: Integer;
begin
  Result := False;
  ShowMessage(IntToStr(X)+IntToStr(Y)+IntToStr(Ay)+IntToStr(Ay));
  // Comprobar si las coordenadas de origen y destino están dentro del tablero
  if (X < 1) or (X > 8) or (Y < 1) or (Y > 8) or
     (Ax < 1) or (Ax > 8) or (Ay < 1) or (Ay > 8) then
    Exit;

  // Comprobar si en la casilla de origen hay una pieza del jugador actual
  PiezaJu := coord[X, Y];
  if (PiezaJu <> 1) and (PiezaJu <> 2) then
    Exit;

  // Comprobar si la casilla de destino está vacía
  if (coord[Ax, Ay] <> 0) then
    Exit;

  // Calcular el desplazamiento en x e y
  DX := Abs(Ax - X);
  DY := Abs(Ay - Y);

  // Verificar que el movimiento es en diagonal y solo una o dos casillas
  if (DX = 1) and (DY = 1) then
  begin
    Result := True;
    Exit;
  end
  else if (DX = 2) and (DY = 2) then
  begin
    // Verificar que hay una pieza en la casilla intermedia
    if (coord[(X + Ax) div 2, (Y + Ay) div 2] <> 0) then
    begin
      Result := True;
      Exit;
    end;
  end;
end;


end.

