import tsps.*;
import ddf.minim.*;
import fisica.*;

Minim minim;
AudioPlayer player, rebote, roto, grito1, grito2, grito3, grito4;
FWorld mundo;
FMouseJoint cadena;
TSPS Gravedad;

PImage charcoImage, mesaImage, msImage, mozoImage, mesaComida, puertaImage, contadorImage,
pisoImage,reboteImage,paredEImage, fragmentosImage, loseImage, winImage, homeImage;
boolean tiempo = false, juego = true, win1 = false, win2 = false, lose = false, puertaCerrada=true; 
int tiempoT = 200, contador = 0, inicioJuego=150;
Mesas[] arregloMesas;
Comida[] arregloComida;
PuertaW pc;

void setup() {

  size(800, 800);
  frameRate(60);
  Fisica.init(this);    
  minim = new Minim(this);
  Gravedad = new TSPS(this, 12000);

  player = minim.loadFile("ambiente.mp3");
  rebote = minim.loadFile("rebote.mp3");
  grito1 = minim.loadFile("señor.mp3");
  grito2 = minim.loadFile("señora.mp3");
  grito3 = minim.loadFile("nena.mp3");
  grito4 = minim.loadFile("chino.mp3");
  roto = minim.loadFile("roto.mp3");
  player.play();
  player.loop();
  grito1.setGain(-20);
  grito2.setGain(-20);
  grito3.setGain(-20);
  //player.setVolume(0);
  player.setGain(-25);
  //rebote.setVolume(0);
  rebote.setGain(-20);
  //roto.setVolume(0);
  roto.setGain(-25);


  homeImage = loadImage ("home.png");  
  homeImage.resize(800, 800);
  contadorImage = loadImage ("contador.png");  
  contadorImage.resize(80, 40);
}

void draw() {

  if (contador>=inicioJuego) {
    if (contador == inicioJuego) {
      IniciarMundo();
    }
    image(pisoImage, 0, 0);
    int mesasTocadas = 0;

    for (int i = 0; i< arregloMesas.length; i++) {
      if (arregloMesas[i].contacto) {
        mesasTocadas ++;
      }
    }
    int comidaTocadas = 0;
    for (int i = 0; i< arregloComida.length; i++) {
      if (arregloComida[i].contacto) {
        comidaTocadas ++;
      }
    } 
    if ((comidaTocadas == 5) || (100 - millis()/1000 <= 1)) {
      juego = !juego;
      lose = true;
    } 
    if (mesasTocadas == 8) {
      win1 = true;
      puertaCerrada= false;
    } 
    if (lose == true) {
      mundo.clear();
      image(loseImage, 0, 0);
    } 
    if (win2 == true) {
      mundo.clear();
      image(winImage, 0, 0);
    }

    mundo.step();
    mundo.draw();
        
      TSPSPerson[] ArrayG= Gravedad.getPeopleArray();
      for (int i=0; i<ArrayG.length; i++) {
        float Centroidx=ArrayG[i].centroid.x*width;
        float Centroidy=ArrayG[i].centroid.y*height;
        float x = map(Centroidx, 0, width, -400, 400);
        float y = map(Centroidy, 0, height, -400, 400);
        mundo.setGravity(x, y);
      }
    if (juego==true&&lose==false && win2==false) {
      image(contadorImage,7,20);
      fill(0);
      textSize(32);
      text(nf ((tiempoT) - millis()/1000), 17, 50);
    }
  }  
  if ( contador<inicioJuego) {
    image(homeImage, 0, 0);
  }
  contador ++;
}
void contactStarted(FContact contact) {
  FBody c1 = contact.getBody1(); 
  FBody c2 = contact.getBody2();
  int efectoC=5;

  if (c1.getName() == "Mozo" || c2.getName() == "Mesa") {
  }
  if (c1.getName() == "Mozo" && c2.getName() == "Mesa")
  {
    Mesas m = (Mesas) c2;
    m.contacto = true;
    c2.attachImage(mesaComida);
    m.mesaComida();
    c2.setName("mesaServida");
  }
  if (c2.getName() == "Mozo" && c1.getName() == "Mesa")
  {
    Mesas m = (Mesas) c1;
    m.contacto = true;
    c1.attachImage(mesaComida);
    m.mesaComida();
    c1.setName("mesaServida");
  }
  //-----------------------------------------------------//
  if (c1.getName() == "Mozo" || c2.getName() == "Comida") {
  }
  if (c1.getName() == "Mozo" && c2.getName() == "Comida")
  {
    Comida c = (Comida) c2;
    c.contacto = true;
    c2.setName("enojado");
    c.setEnojado();
  }
  if (c2.getName() == "Mozo" && c1.getName() == "Comida")
  {
    Comida c = (Comida) c1;
    c.contacto = true;
    c.setEnojado();
    c1.setName("enojado");
  }

  //-----------------------------------------------------//
  if (c1.getName() == "Mozo" || c2.getName() == "PuertaW") {
  }
  if (c1.getName() == "Mozo" && c2.getName() == "PuertaW")
  {
    PuertaW p = (PuertaW) c2;
    p.contacto = !p.contacto;
    if (win1 == true) {
      win2 = true;
    }
  }
  if (c2.getName() == "Mozo" && c1.getName() == "PuertaW")
  {
    PuertaW p = (PuertaW) c1;
    p.contacto = !p.contacto;
    if (win1 == true) {
      win2 = true;
    }
  }
  //-----------------------------------------------------//
  if (c1.getName() == "Mozo" || c2.getName() == "Vidrio") {
  }
  if (c1.getName() == "Mozo" && c2.getName() == "Vidrio")
  {
    c2.attachImage(fragmentosImage);
    c2.setSensor(true);
    roto.play();
    c2.setName("vidrioRoto");
    if (roto.isPlaying()) {
      roto.rewind();
    }
  }
  if (c2.getName() == "Mozo" && c1.getName() == "Vidrio")
  {
    c1.attachImage(fragmentosImage);
    c1.setSensor(true);
    roto.play();
    c1.setName("vidrioRoto");
    if (roto.isPlaying()) {
      roto.rewind();
    }
  }
  //-----------------------------------------------------//
  if (c1.getName() == "Mozo" || c2.getName() == "Rebote") {
  }
  if (c1.getName() == "Mozo" && c2.getName() == "Rebote")
  {
    c2.setRestitution(3);
    c2.setFill(100, 255, 100);
  }
  if (c2.getName() == "Mozo" && c1.getName() == "Rebote")
  {
    c1.setRestitution(3);
    c1.setFill(100, 255, 100);
  }
  //-----------------------------------------------------//
  if (c1.getName() == "Mozo" && c2.getName() == "Charco" && ((efectoC) - millis()/1000 <= 1))
  {
    c1.setDamping(-10);
    c1.attachImage(mozoImage);
  } else {
    c1.setDamping(1);
    efectoC=5;
  }
  if (c2.getName() == "Mozo" && c1.getName() == "Charco" && ((efectoC) - millis()/1000 <= 1))
  {
    c2.setDamping(-10);
    c2.attachImage(mozoImage);
  } else {
    c2.setDamping(1);
    efectoC=5;
  }
  //-----------------------------------------------------//
  if (c1.getName() == "Mozo" && c2.getName() == "vidrioRoto" && ((efectoC) - millis()/1000 <= 1))
  {
    c1.setDamping(10);
  } else {
    c1.setDamping(1);
    efectoC=5;
  }
  if (c2.getName() == "Mozo" && c1.getName() == "vidrioRoto" && ((efectoC) - millis()/1000 <= 1))
  {
    c2.setDamping(10);
  } else {
    c2.setDamping(1);
    efectoC=5;
  }
}

/* void contactPersisted(FContact contact) {
 FBody c1 = contact.getBody1(); 
 FBody c2 = contact.getBody2();
 if(c1.getName() == "Mozo" || c2.getName() == "Rebote"){
 }
 if (c1.getName() == "Mozo" && c2.getName() == "Rebote")
 {
 c2.setRestitution(3);
 c2.setFill(100,255,100);
 }
 if (c2.getName() == "Mozo" && c1.getName() == "Rebote")
 {
 c1.setRestitution(3);
 c1.setFill(100,255,100);
 }
 
 }*/
void contactEnded(FContact contact) {
  FBody c1 = contact.getBody1(); 
  FBody c2 = contact.getBody2();
  if (c1.getName() == "Mozo" || c2.getName() == "Rebote") {
  }
  if (c1.getName() == "Mozo" && c2.getName() == "Rebote")
  {
    c2.setRestitution(3);
    c2.setFill(139, 21, 152);
    rebote.play();
    if (rebote.isPlaying()) {
      rebote.rewind();
    }
  }
  if (c2.getName() == "Mozo" && c1.getName() == "Rebote")
  {
    c1.setRestitution(3);
    c1.setFill(139, 21, 152);
    rebote.play();
    if (rebote.isPlaying()) {
      rebote.rewind();
    }
  }
}

void IniciarMundo() {

  if (juego == true) {
  
    mundo = new FWorld();    
    mundo.setEdges();
    loseImage = loadImage ("lose.jpeg");  
    loseImage.resize(width, height); 
    winImage = loadImage ("win.jpeg");  
    winImage.resize(width, height);
    fragmentosImage = loadImage ("fragmentos.png");
    fragmentosImage.resize(100, 50);
    pisoImage = loadImage ("piso.png");  
    pisoImage.resize(800, 800);

    //-----------------------------------------------------//
    Muros rebote1 = new Muros(100, 250);
    rebote1.inicializarR(35, 35 );
    //rebote1.resize(100,100);
    mundo.add(rebote1);
    //-----------------------------------------------------//
    Muros rebote2 = new Muros(100, 100);
    rebote2.inicializarR(width/2+width/2, height/2-height/2);
    mundo.add(rebote2);
    //-----------------------------------------------------//
    Muros rebote3 = new Muros(50, 50);
    rebote3.inicializarR(width/1.7, height/8);
    mundo.add(rebote3);
    //-----------------------------------------------------//    
    Muros rebote4 = new Muros(80, 50);
    rebote4.inicializarR(width/1.3, height/2.2);
    mundo.add(rebote4);
    //-----------------------------------------------------//
    Muros estatico1 = new Muros(150, 20);
    estatico1.inicializarE(width/2, height/2+height/4);
    mundo.add(estatico1);
    //-----------------------------------------------------//
    Muros estatico2 = new Muros(90, 20);
    estatico2.inicializarE(width-45, height/2+height/3);
    mundo.add(estatico2);
    //-----------------------------------------------------//
    Muros estatico3 = new Muros(120, 20);
    estatico3.inicializarE(width-60, height/2-height/4);
    mundo.add(estatico3);
    //-----------------------------------------------------//
    Muros estatico4 = new Muros(80, 20);
    estatico4.inicializarE(width/2-width/5, height/2-height/4+70);
    mundo.add(estatico4);
    //-----------------------------------------------------//
    Muros estatico5 = new Muros(120, 20);
    estatico5.inicializarE(60, height/2+75);
    mundo.add(estatico5);
    //-----------------------------------------------------//
    Muros vidrio1 = new Muros(10, 90);
    vidrio1.inicializarV(width/2-width/7, height/2-height/4+35);
    mundo.add(vidrio1);
    //-----------------------------------------------------//
    Muros vidrio2 = new Muros(10, 90);
    vidrio2.inicializarV(width/2-width/4, height/2+height/4+150);
    mundo.add(vidrio2);
    //-----------------------------------------------------//
    Muros vidrio3 = new Muros(10, 103);
    vidrio3.inicializarV(width/2- width/9-10+5, height/2-90+5);
    vidrio3.setRotation(47.9);
    mundo.add(vidrio3);
    //-----------------------------------------------------//
    Muros vidrio4 = new Muros(10, 90);
    vidrio4.inicializarV(width/2-120, height/2-height/65);
    vidrio4.setRotation(94);
    mundo.add(vidrio4);
    //-----------------------------------------------------//
    Muros vidrio5 = new Muros(10, 110);
    vidrio5.inicializarV(width/2-15, height/2-height/8.8-5);
    vidrio5.setRotation(5.2);
    mundo.add(vidrio5);
    //-----------------------------------------------------//
    Muros vidrio6 = new Muros(120, 10);
    vidrio6.inicializarV(width/2-55, height/2+35);
    mundo.add(vidrio6);
    //-----------------------------------------------------//
    PuertaW puertaW = new PuertaW (150, 50);
    puertaW.inicializarPW(width/2, height/2+height/4+190);
    mundo.add(puertaW);
    /*/-----------------------------------------------------//
    Muros puertaL = new Muros(150, 15);
    puertaL.inicializarPL(width/2, height/2-height/4-190);
    mundo.add(puertaL);
    //-----------------------------------------------------/*/
    Mesas mesa1 = new Mesas(60, 1);
    mesa1.inicializarM(width/2-52, height/2-33);
    mundo.add(mesa1);
    //-----------------------------------------------------//
    Mesas mesa2 = new Mesas(60, 2);
    mesa2.inicializarM(width/2-width/2.5+20, height/2+height/4+100);
    mundo.add(mesa2);
    //-----------------------------------------------------//
    Mesas mesa3 = new Mesas(60, 3);
    mesa3.inicializarM(width/2, height/2+120);
    mundo.add(mesa3);
    //-----------------------------------------------------//
    Mesas mesa4 = new Mesas(60, 4);
    mesa4.inicializarM(width/2 + width/2.5, height/2+180);
    mundo.add(mesa4);    
    //-----------------------------------------------------//
    Mesas mesa5 = new Mesas(60, 5);
    mesa5.inicializarM(width/2 + width/2.5, height/2-130);
    mundo.add(mesa5);
    //-----------------------------------------------------//
    Mesas mesa6 = new Mesas(60, 6);
    mesa6.inicializarM(width/2 - width/2.3+20, height/2);
    mundo.add(mesa6);
    //-----------------------------------------------------//
    Mesas mesa7 = new Mesas(60, 7);
    mesa7.inicializarM(width/2 - width/4.5-15, height/2-220);
    mundo.add(mesa7);
    //-----------------------------------------------------//
    Mesas mesa8 = new Mesas(60, 8);
    mesa8.inicializarM(width/2 + width/6, height/2-235);
    mundo.add(mesa8);
    //-----------------------------------------------------//
    Comida comida1 = new Comida (30);
    comida1.inicializarCO(width/2 + width/3, height/15);
    mundo.add(comida1);

    cadena = new FMouseJoint(comida1, width/2 + width/3, height/15);
    cadena.setNoStroke();
    cadena.setFrequency(0.08);
    mundo.add(cadena);
    //-----------------------------------------------------//
    Comida comida2 = new Comida (30);
    comida2.inicializarCO(width/2 - width/2.5, height/1.3);
    mundo.add(comida2);

    cadena = new FMouseJoint(comida2, width/2 - width/2.5, height/1.3);
    cadena.setNoStroke();
    cadena.setFrequency(0.08);
    mundo.add(cadena);
    //-----------------------------------------------------//
    Comida comida3 = new Comida (30);
    comida3.inicializarCO(width/2 + width/3, height/1.2);
    mundo.add(comida3);

    cadena = new FMouseJoint(comida3, width/2 + width/3, height/1.2);
    cadena.setNoStroke();
    cadena.setFrequency(0.08);
    mundo.add(cadena);
    //-----------------------------------------------------//
    Comida comida4 = new Comida (30);
    comida4.inicializarCO(width/2 -125, height/1.35);
    mundo.add(comida4);

    cadena = new FMouseJoint(comida4, width/2 -125, height/1.35);
    cadena.setNoStroke();
    cadena.setFrequency(0.08);
    mundo.add(cadena);
    //-----------------------------------------------------//
    Comida comida5 = new Comida (30);
    comida5.inicializarCO(width/2 -25, height/2-135);
    mundo.add(comida5);

    cadena = new FMouseJoint(comida5, width/2 -25, height/2-135);
    cadena.setNoStroke();
    cadena.setFrequency(0.08);
    mundo.add(cadena);
    //-----------------------------------------------------//
    Comida comida6 = new Comida (30);
    comida6.inicializarCO(width/2 +325, height/2-35);
    mundo.add(comida6);

    cadena = new FMouseJoint(comida6, width/2 +325, height/2-35);
    cadena.setNoStroke();
    cadena.setFrequency(0.08);
    mundo.add(cadena);
    //-----------------------------------------------------//
    Comida comida7 = new Comida (30);
    comida7.inicializarCO(width/2 -355, height/5);
    mundo.add(comida7);

    cadena = new FMouseJoint(comida7, width/2 -355, height/5);
    cadena.setNoStroke();
    cadena.setFrequency(0.08);
    mundo.add(cadena);
    //-----------------------------------------------------//
    Comida comida8 = new Comida (30);
    comida8.inicializarCO(width/2 -155, height/15);
    mundo.add(comida8);

    cadena = new FMouseJoint(comida8, width/2 -155, height/15);
    cadena.setNoStroke();
    cadena.setFrequency(0.08);
    mundo.add(cadena);
    //-----------------------------------------------------//
    Comida comida9 = new Comida (30);
    comida9.inicializarCO(width/2, height/1.25);
    mundo.add(comida9);

    cadena = new FMouseJoint(comida9, width/2, height/1.25);
    cadena.setNoStroke();
    cadena.setFrequency(0.08);
    mundo.add(cadena);
    //-----------------------------------------------------//
    Charco charco1 = new Charco(30);
    charco1.inicializarC(width/2+125, height/1.05);
    mundo.add(charco1);
    //-----------------------------------------------------//
    Charco charco2 = new Charco(30);
    charco2.inicializarC(width/2+225, height/1.8);
    mundo.add(charco2);
    //-----------------------------------------------------//
    Charco charco3 = new Charco(30);
    charco3.inicializarC(width/2-325, height/1.5);
    mundo.add(charco3);
    //-----------------------------------------------------//
    Charco charco4 = new Charco(30);
    charco4.inicializarC(width/2-355, height/2.5);
    mundo.add(charco4);
    //-----------------------------------------------------//
    Mozo mozo = new Mozo(50);
    mozo.inicializarMO(width/2, 100);
    mundo.add(mozo);

    arregloMesas = new Mesas[8];
    arregloMesas[0] = mesa1;
    arregloMesas[1] = mesa2;
    arregloMesas[2] = mesa3;
    arregloMesas[3] = mesa4;
    arregloMesas[4] = mesa5;
    arregloMesas[5] = mesa6;
    arregloMesas[6] = mesa7;
    arregloMesas[7] = mesa8;

    arregloComida = new Comida[9];
    arregloComida[0] = comida1;
    arregloComida[1] = comida2;
    arregloComida[2] = comida3;
    arregloComida[3] = comida4;
    arregloComida[4] = comida5;
    arregloComida[5] = comida6;
    arregloComida[6] = comida7;
    arregloComida[7] = comida8;
    arregloComida[8] = comida9;
  }
}
