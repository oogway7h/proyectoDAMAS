unit uForm;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,uTablero;

type

  { TForm1 }

  TForm1 = class(TForm)
    jugar: TButton;

    procedure FormCreate(Sender: TObject);
    procedure jugarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormPaint(Sender: TObject);

  private
  public
   procedure DibujarTablero();
   procedure DibujarPiezas();
  end;

var
  Form1: TForm1;
  t:tablero ;

implementation

{$R *.lfm}

{ TForm1 }




procedure TForm1.jugarClick(Sender: TObject);
begin
  DibujarTablero();
  jugar.Hide;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  t:=tablero.cear();


end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
  );
begin
  if (key=27)then
    close();
end;

procedure TForm1.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
 var
    Dx, Dy, Ax, Ay: Integer;
  begin
    Dx := (X div 50) + 1;
    Dy := (Y div 50) + 1;
    if(t.coord[Dx,Dy]=1)then
     begin
      Ax:=Dx;
      Ay:=Dy;
      Dx:=0;
      Dy:=0;
     end;
    if(t.coord[Dx,Dy]=2)then
     begin
      Ax:=Dx;
      Ay:=Dy;
      Dx:=0;
      Dy:=0;
     end;
    if(t.coord[Ax,Ay]<>0)then
     begin
       t.coord[Dx,Dy]:=t.coord[Ax,Ay];
       t.coord[Ax,Ay]:=0;
     end;
    end;
     DibujarTablero();
     DibujarPiezas();
     invalidate;
    end;





procedure TForm1.FormPaint(Sender: TObject);
begin
DibujarTablero();
DibujarPiezas();
end;

procedure TForm1.DibujarTablero;
  var
  i, j: Integer;
begin
  for i := 1 to 8 do
  begin
   for j:=1 to 8 do
    begin
      // Dibuja el fondo del cuadro en blanco o negro
      if ((i + j) mod 2 = 0) then
        Canvas.Brush.Color:=clWhite
      else
        Canvas.Brush.Color := clBlack;

      Canvas.FillRect(Rect((i - 1) * 50, (j - 1) * 50, i * 50, j * 50));

      // Dibuja las fichas en los cuadros correspondientes
    end;
end;
  DibujarPiezas();
end;

procedure TForm1.DibujarPiezas();
  var
    x, y: Integer;
  begin
    for x := 1 to 8 do
    begin
      for y := 1 to 8 do
      begin
        if (t.coord[x, y]) = 1 then
        begin
          Canvas.Brush.Color := clRed;
          Canvas.Ellipse((x - 1) * 50 + 10, (y - 1) * 50 + 10, x * 50 - 10, y * 50 - 10);
        end
        else if t.coord[x, y] = 2 then
        begin
          Canvas.Brush.Color := clBlue;
          Canvas.Ellipse((x - 1) * 50 + 10, (y - 1) * 50 + 10, x * 50 - 10, y * 50 - 10);
        end;
      end;
    end;
  end;




end.
