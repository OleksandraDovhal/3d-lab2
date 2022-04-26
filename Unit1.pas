unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Math, DateUtils;

type
  Point=record
  x: Integer;
  y: Integer;
  end;

  TForm1 = class(TForm)
    Image1: TImage;
    EditX: TEdit;
    EditY: TEdit;
    EditR: TEdit;
    Button1: TButton;
    Button2: TButton;
    ColorCombo: TComboBox;
    Label1: TLabel;
    Button3: TButton;
    Button4: TButton;
    cbb1: TComboBox;
    ButtonNet: TButton;
    ButtonClear: TButton;
    Label2: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure ButtonNetClick(Sender: TObject);
    procedure ButtonClearClick(Sender: TObject);

    procedure Net;
    procedure Init;
    procedure Clear;
    procedure Swap(var a,b: Integer);

    procedure Brezenhem;
    procedure MyAlhorithm;
    procedure MyAlhorithmInt;
    procedure MyAlhorithmBrezenhem;

    procedure mh;
    procedure md;
    procedure mv;

    procedure RecurseFilling(x,y,BackgroundColor: Integer);
    procedure MyLineFilling(x,y,BackgroundColor: Integer);
    procedure PointInTriangle(a,b,c: Point; x,y: Integer);
    procedure TriangleBuild(x,y:Integer);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  x,y,xi,yi,r,di,delta: Integer;
  a: array [1..3] of Point;
  t: Byte;
  ColorLine : String;
  Time: TDateTime;//Timer


implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  t:=0;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Init;
  Time:=Now;
  Brezenhem;
  Label1.Caption:=FloatToStr(MilliSecondSpan(Now,Time));
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Init;
  Time:=Now;
  MyAlhorithm;
  Label1.Caption:=FloatToStr(MilliSecondSpan(Now,Time));
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  Init;
  Time:=Now;
  MyAlhorithmInt;
  Label1.Caption:=FloatToStr(MilliSecondSpan(Now,Time));
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  Init;
  Time:=Now;
  MyAlhorithmBrezenhem;
  Label1.Caption:=FloatToStr(MilliSecondSpan(Now,Time));
end;

procedure TForm1.ButtonNetClick(Sender: TObject);
begin
  Net;
end;

procedure TForm1.ButtonClearClick(Sender: TObject);
begin
  Clear;
end;

procedure TForm1.Net;
var i,j : Integer;
begin
  with Image1.Canvas do
  begin
    Clear;
    Pen.Color:=clGray;
    Pen.Style:=psDot;
    for i:=0 to 30 do
      begin
        MoveTo(i*20,0);
        LineTo(i*20,600);
        Moveto(0,i*20);
        LineTo(600,i*20);
      end;
    Pen.Style:=psSolid;
  end;
end;

procedure TForm1.Init;
begin
  x:=StrToInt(EditX.Text);
  y:=StrToInt(EditY.Text);
  r:=StrToInt(EditR.Text);
end;

procedure TForm1.Clear;
var Rect: TRect;
begin
    Rect.Left:=0;
    Rect.Right:=600;
    Rect.Top:=0;
    Rect.Bottom:=600;
    Image1.Canvas.FillRect(Rect);   //(0,0,320,320,clWhite);
    Image1.Canvas.FloodFill(1,1,clWhite,fsborder);
end;

////////////////////////////////////////////////////////////////////////////
//////////////////////////////CircleBuildAlgorithms/////////////////////////
////////////////////////////////////////////////////////////////////////////

procedure TForm1.Brezenhem;
begin
  with Image1.Canvas do
  begin
    xi:=0;
    yi:=r;
    di:=2*(1-r);
    while(yi>=0) do //якщо ще не дійшли до межі
    begin
      Pixels[xi+x,yi+y]:=stringtocolor('cl'+ColorCombo.Text);
      Pixels[xi*-1+x,yi+y]:=stringtocolor('cl'+ColorCombo.Text);
      Pixels[xi+x,yi*-1+y]:=stringtocolor('cl'+ColorCombo.Text);
      Pixels[xi*-1+x,yi*-1+y]:=stringtocolor('cl'+ColorCombo.Text);
      sleep(5);
      Application.Processmessages;
      //di
      if(di<0) then//випадки 1,2
        begin
          delta:=2*(di+yi)-1;
          if delta<=0 then
            mh
          else
            md;
        end
      else
        if(di>0) then//випадки 3,4
          begin
            delta:=2*(di-xi)-1;
            if delta<=0 then
              md
            else
              mv;//не використовуэться при побудови в октанты
          end
        else
          md;
    end;
  end;
end;

procedure TForm1.MyAlhorithmBrezenhem;
begin
  with Image1.Canvas do
  begin
    xi:=0;
    yi:=r;
    di:=2*(1-r);
    while(yi>=xi) do //якщо ще не дійшли до межі
    begin
      Pixels[xi+x,yi+y]:=stringtocolor('cl'+ColorCombo.Text);
      Pixels[xi*-1+x,yi+y]:=stringtocolor('cl'+ColorCombo.Text);
      Pixels[xi+x,yi*-1+y]:=stringtocolor('cl'+ColorCombo.Text);
      Pixels[xi*-1+x,yi*-1+y]:=stringtocolor('cl'+ColorCombo.Text);

      Pixels[yi+x,xi+y]:=stringtocolor('cl'+ColorCombo.Text);
      Pixels[yi*-1+x,xi+y]:=stringtocolor('cl'+ColorCombo.Text);
      Pixels[yi+x,xi*-1+y]:=stringtocolor('cl'+ColorCombo.Text);
      Pixels[yi*-1+x,xi*-1+y]:=stringtocolor('cl'+ColorCombo.Text);
      sleep(5);
      Application.Processmessages;
      //di
      if(di<0) then//випадки 1,2
        begin
          delta:=2*(di+yi)-1;
          if delta<=0 then
            mh
          else
            md;
        end
      else
        md;
    end;
  end;
end;

procedure TForm1.md;
begin
  Inc(xi);
  Dec(yi);
  di:=di+2*xi-2*yi+2;
end;

procedure TForm1.mh;
begin
  Inc(xi);
  di:=di+2*xi+1;
end;

procedure TForm1.mv;
begin
  Dec(yi);
  di:=di-2*yi-1;
end;

procedure TForm1.MyAlhorithm;
var sqr_r: Integer;
begin
  xi:=0;
  sqr_r:=r*r;
  while(xi<=yi) do
    begin
      yi:=Round(Sqrt(sqr_r-xi*xi));
      with Image1.Canvas do
        begin
          Pixels[xi+x,yi+y]:=stringtocolor('cl'+ColorCombo.Text);
          Pixels[yi+x,xi+y]:=stringtocolor('cl'+ColorCombo.Text);

          Pixels[xi*-1+x,yi+y]:=stringtocolor('cl'+ColorCombo.Text);
          Pixels[yi*-1+x,xi+y]:=stringtocolor('cl'+ColorCombo.Text);

          Pixels[xi+x,yi*-1+y]:=stringtocolor('cl'+ColorCombo.Text);
          Pixels[yi+x,xi*-1+y]:=stringtocolor('cl'+ColorCombo.Text);

          Pixels[xi*-1+x,yi*-1+y]:=stringtocolor('cl'+ColorCombo.Text);
          Pixels[yi*-1+x,xi*-1+y]:=stringtocolor('cl'+ColorCombo.Text);
          Sleep(5);
          Application.ProcessMessages;
        end;
      Inc(xi);
    end;
end;

procedure TForm1.MyAlhorithmInt;
var error: Integer;
begin
  xi:=r;
  yi:=0;
  error:=1-xi;
  while(xi>=yi) do
    begin
      with Image1.Canvas do
        begin
          Pixels[xi+x,yi+y]:=stringtocolor('cl'+ColorCombo.Text);
          Pixels[yi+x,xi+y]:=stringtocolor('cl'+ColorCombo.Text);

          Pixels[xi*-1+x,yi+y]:=stringtocolor('cl'+ColorCombo.Text);
          Pixels[yi*-1+x,xi+y]:=stringtocolor('cl'+ColorCombo.Text);

          Pixels[xi+x,yi*-1+y]:=stringtocolor('cl'+ColorCombo.Text);
          Pixels[yi+x,xi*-1+y]:=stringtocolor('cl'+ColorCombo.Text);

          Pixels[xi*-1+x,yi*-1+y]:=stringtocolor('cl'+ColorCombo.Text);
          Pixels[yi*-1+x,xi*-1+y]:=stringtocolor('cl'+ColorCombo.Text);
          Sleep(5);
          Application.ProcessMessages;
        end;
      Inc(yi);
      if(error<0)then Inc(error,2*yi+1)
      else
        begin
          Dec(xi);
          Inc(error,2*(yi-xi+1));
        end;
    end;
end;

////////////////////////////////////////////////////////////////////////////
//////////////////////////////FillingAlgorithm//////////////////////////////
////////////////////////////////////////////////////////////////////////////

procedure TForm1.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Time:=Now;
  case cbb1.ItemIndex of
    0: RecurseFilling(x,y,Image1.Canvas.Pixels[x,y]);
    1: MyLineFilling(x,y,Image1.Canvas.Pixels[x,y]);
    2: TriangleBuild(x,y);
    3: PointInTriangle(a[1],a[2],a[3],x,y);
  end;
  Label1.Caption:=FloatToStr(MilliSecondSpan(Now,Time));
end;

procedure TForm1.RecurseFilling(x,y,BackgroundColor: Integer);
var c: Integer;
begin
  c:=Image1.Canvas.Pixels[x,y];
  if(c=BackgroundColor)then
    begin
      Image1.Canvas.Pixels[x,y]:=StringToColor('cl'+ColorCombo.Text);
      RecurseFilling(x-1,y,BackgroundColor);
      RecurseFilling(x+1,y,BackgroundColor);
      RecurseFilling(x,y-1,BackgroundColor);
      RecurseFilling(x,y+1,BackgroundColor);
    end;
  Application.ProcessMessages;
end;

procedure TForm1.MyLineFilling(x,y,BackgroundColor: Integer);
var i,c,x1,x2: Integer;
b1,b2: Boolean;
begin
  with Image1.Canvas do
    begin
      Pen.Color:=StringToColor('cl'+ColorCombo.Text);
      x1:=x;
      x2:=x;
      repeat
        Dec(x1);
        c:=Pixels[x1,y];
      until (c<>BackgroundColor);
      Inc(x1);
      repeat
        Inc(x2);
        c:=Pixels[x2,y];
      until (c<>BackgroundColor);
      Dec(x2);
      MoveTo(x1,y);
      LineTo(x2+1,y);
      Application.ProcessMessages;
      b1:=False;
      b2:=False;
      for i:=x1 to x2 do
      begin
        if (Pixels[i,y+1]=BackgroundColor)and(b1=False) then
          begin
            b1:=True;
            MyLineFilling(i,y+1,BackgroundColor);
          end
        else if (Pixels[i,y+1]<>BackgroundColor)and(b1=True) then b1:=False;
        if (Pixels[i,y-1]=BackgroundColor)and(b2=False) then
          begin
            b2:=True;
            MyLineFilling(i,y-1,BackgroundColor);
          end
        else if (Pixels[i,y-1]<>BackgroundColor)and(b2=True) then b2:=False;
      end;
    end;
end;

////////////////////////////////////////////////////////////////////////////
//////////////////////////////////Triangle//////////////////////////////////
////////////////////////////////////////////////////////////////////////////

procedure TForm1.TriangleBuild(x,y: Integer);
var x1,x2,i: Integer;
begin
  case t of
    0:begin
        Inc(t);
        a[t].x:=x;
        a[t].y:=y;
        Image1.Canvas.Pixels[x,y]:=clRed;
      end;
    1:begin
        Inc(t);
        a[t].x:=x;
        a[t].y:=y;
        Image1.Canvas.Pixels[x,y]:=clRed;
      end;
    2:begin
        Inc(t);
        a[t].x:=x;
        a[t].y:=y;
        Image1.Canvas.Pixels[x,y]:=clRed;
        t:=0;
        Image1.Canvas.Pen.Color:=StringToColor('cl'+ColorCombo.Text);
        Image1.Canvas.MoveTo(a[1].x,a[1].y);
        Image1.Canvas.LineTo(a[2].x,a[2].y);
        Image1.Canvas.LineTo(a[3].x,a[3].y);
        Image1.Canvas.LineTo(a[1].x,a[1].y);
        //сортування вершин
        if a[1].y>a[2].y then
          begin
            Swap(a[1].x,a[2].x);
            Swap(a[1].y,a[2].y);
          end;
        if a[2].y>a[3].y then
          begin
            Swap(a[2].x,a[3].x);
            Swap(a[2].y,a[3].y);
          end;
        if a[1].y>a[2].y then
          begin
            Swap(a[1].x,a[2].x);
            Swap(a[1].y,a[2].y);
          end;
        //алгоритм заповнення
        for i:=a[1].y to a[3].y-1 do
        begin
          x1:=Round(a[1].x+(i-a[1].y)*(a[3].x-a[1].x)/(a[3].y-a[1].y));
          if(i<a[2].y)then
            x2:=Round(a[1].x+(i-a[1].y)*(a[2].x-a[1].x)/(a[2].y-a[1].y))
          else
            if a[3].y=a[2].y then
              x2:=a[2].y
            else
              x2:=Round(a[2].x+(i-a[2].y)*(a[3].x-a[2].x)/(a[3].y-a[2].y));
          if x1>x2 then Swap(x1,x2);
          Image1.Canvas.MoveTo(x1,i);
          Image1.Canvas.LineTo(x2,i);
          Application.ProcessMessages;
          //Sleep(50);
        end;
      end;
  end;
end;

procedure TForm1.PointInTriangle(a,b,c: Point; x, y: Integer);
var p: Point;
begin
  p.x:=x;
  p.y:=y;
  if((p.x-a.x)*(a.y-b.y)-(p.y-a.y)*(a.x-b.x)>=0) and
    ((p.x-b.x)*(b.y-c.y)-(p.y-b.y)*(b.x-c.x)>=0) and
    ((p.x-c.x)*(c.y-a.y)-(p.y-c.y)*(c.x-a.x)>=0)then Label2.Caption:='True'
  else Label2.Caption:='False';
end;

procedure TForm1.Swap(var a, b: Integer);
begin
  a:=a+b;
  b:=a-b;
  a:=a-b;
end;

end.
