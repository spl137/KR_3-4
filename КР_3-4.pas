Uses GraphABC;

var
  gx,gy,i,n,k,t:integer;
  sn,s,a,b,h,m,x,ij,jj,ab,mn:real;
  drw,main:boolean;

function f(var x:real):real;
begin
  f:=2*x**3+(-2)*x*x+(-4)*x+15;
end;


function f2(var x:real):real;
begin
  f2:=x*(3*x**3-4*x**2-12*x+90)/6;
end;

procedure KeyDown(Key:integer);
begin
 
 case Key of 
   VK_Up: begin
   clearwindow;
   k+=1;
   drw:=True;
   if k >20 then
     k:=20;
   end;
   VK_Down: begin
   clearwindow;
   k-=1;
   drw:=True;
   if k <0 then
     k:=0;
   end;
end;
end;

begin
  k:=0;
  gy:=700;// размер экрана по y
  gx:=700;// размер экрана по x
  SetWindowSize(gx,gy);// установка размера экрана
  
  textout((gx div 2)-100,30,'Введите пределы интегрирования от 1 до 10');
  readln(a,b);
  clearwindow;
  textout((gx div 2)-100,30,'Введите кол-во прямоугольников ');
  readln(n);
  
  h:=(b-a)/n;
  
  
  
  m:=a+h;
  while m<= b do begin
  sn:=sn+h*(f(m));
  m+=h;
  end;
  s:=abs((f2(b)-f2(a)-sn));
  
  drw:=True;
  main:=True;
  while main do begin
  while drw do begin //рисование
  clearwindow;
  
  Line(gx div 2,gy div 2,gx div 2,0);// y вверх
  Line(gx div 2,gy div 2,0,gy div 2);// x влево
  Line(gx div 2,gy div 2,gx div 2,gy);// y вниз
  Line(gx div 2,gy div 2,gx,gy div 2);// x вправо
  textout((gx div 2)-3,(gy div 2)-8,'0');// вывод нуля
  
  setfontsize(5);
  
  Line(gx,gy div 2,gx-6,(gy div 2)-2);// часть стрелки x вверх
  Line(gx,gy div 2,gx-6,(gy div 2)+2);// часть стрелки x вниз
  textout(gx-6,(gy div 2)+3,'x');
  Line(gx div 2,0,(gx div 2)-2,7);//часть стрелки y влево
  Line(gx div 2,0,(gx div 2)+2,7);//часть стрелки y вправо
  textout((gx div 2)+7,0,'y');
  
  for i:=1 to 39 do begin// рисование 'шпал' по x вправо
    line((gx div 2)+i*(10+(k)),(gy div 2)-4,(gx div 2)+i*(10+(k)),(gy div 2)+4);
  // рисование 'шпал' по x вправо
    line((gx div 2)-i*(10+(k)),(gy div 2)-4,(gx div 2)-i*(10+(k)),(gy div 2)+4);
  // рисование 'шпал' по y вниз
    line((gx div 2)-4,(gy div 2)+i*(10+(k)),(gx div 2)+4,gy div 2+i*(10+(k)));
  // рисование 'шпал' по y вверх
    line((gx div 2)-4,(gy div 2)-i*(10+(k)),(gx div 2)+4,gy div 2-i*(10+(k)));
  end;
    
  
  for i:=1 to 39 do begin// рисование цифр по y вверх
    textout((gx div 2)-15,(gy div 2)-5-i*(10+(k)),i);// i умножено на 10 в качестве шага; - 15 у первой координаты, чтобы цифрры выводилис за координатной прямой
  // рисование цифр по y вниз
    textout((gx div 2)+8,(gy div 2)+5+i*(10+(k)),i*(-1)); // i и 15 обратные предыдущему действию, чтобы рисовать в отрицательных четвертях
  // рисование цифр по x влево
    textout((gx div 2)-2-i*(10+(k)),(gy div 2)+7,i*(-1));
  // рисование цифр по x вправо
    textout((gx div 2)-4+i*(10+(k)),(gy div 2)-15,i);// аналогично с y
    end;
    

    
    x:=-4;
    
    while x <= 4 do begin //вывод кривой на экран
      setpixel(((gx div 2)+round(x*(10+k/2))),((gy div 2)-round(f(x)*11+k*16))+15, clred);
      x += 0.0001;
    end;
    
    textout(70,70,h);
    
    h:=(b*(10)-a*(10))/n;// умножение на 10 т.к цена деления
    
    t:=0;
    x:=1;
    ab:=a;
    mn:=0;
    
    ij:=round(((gx div 2)+a*10));//x1 - самый первый, в цикле заменяется на следующий
    while x <= n do begin //вывод прямоугольников
      setPenColor(clBlue);
      jj:=(ab+(b-a)/n);
      rectangle(round(ij),gy div 2,round(ij+h),round((gy div 2)-(f(jj))*10));
      
      textout(5+t,90,round((gy div 2)-f(jj)*9.5));
      textout(5+t,110,round(gy div 2));
      textout(5+t,150,round(f(jj)));
      t+=50;
      
      ab+=1;
      ij+=h;
      x+=1;

    end;
    setPenColor(clblack);
    
    
    setfontsize(10);
    textout(5,10,':(');
    textout(5,30,'Площадь = ');textout(78,30,round(sn*100)/100);
    textout(5,50,'Погрешность = ');textout(100,50,round(s*100)/100);
    drw:=False;
  end;
  OnKeyDown:=KeyDown;
  end;

end.