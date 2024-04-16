function ff=stuve()
  % Constants
  Lv = 2.501e6;
  Cpa = 1005.7;
  kappa = 0.2854;
  temperaturesCentigrades = [-30:10:150];
  kelvinCentrigradeDifference = 273.16;
  temperaturesKelvin = temperaturesCentigrades + kelvinCentrigradeDifference;

  % Temperature (x) and pressure (y) ranges for contours
   x = [-95:5:45];
   y = [95:10:1020];

  % Set pressure to pressure^kappa for Stuve diagram
  y = y.^kappa;
  [X,Y] = meshgrid(x,y);

  % DRY ADIABATS
  Z = (X+kelvinCentrigradeDifference).*((1000^kappa)./Y);

  [c1,dryHandler] = contour(x,y,Z,temperaturesKelvin);

  hold on

 % SATURATED ADIABATS
  term1 = 17.67*X;
  term2 = X  + 243.5;
  Esat = 6.112.*exp(term1./term2);
  Rsat = 0.622*Esat./(Y.^(1/kappa) - Esat);
  Qsat = Rsat./(Rsat + 1);
  term4 = Lv.*Qsat./Cpa;
  ZZ = Z.*exp(term4./(X+kelvinCentrigradeDifference));

  [c2,saturateHandler] = contour(x,y,ZZ,temperaturesKelvin);
  hold on

  % Saturated mixing ratio contours
  Rsat = Rsat.*1000;
  v3 = [0.01 0.1 0.2 0.3 1 2 4 6 8 10 12 16 20 30 40 50 60 70 80 90];
  [c3,h3] = contour(x,y,Rsat,v3);
  hx3 = clabel(c3);


  set(gca,'YDir','reverse')
  xlim([min(x) max(x)])
  ylim([min(y) max(y)])
  set(gca,'Visible','off')
  pbaspect([1 1 1])