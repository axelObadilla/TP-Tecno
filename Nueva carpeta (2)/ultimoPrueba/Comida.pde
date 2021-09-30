class Comida extends FCircle

{
  boolean contacto = false;
  PImage [] enojado = new PImage[4];
  int RC;
  Comida (float _d)
  {
    super(_d);
  }
  void inicializarCO (float _x, float _y)
  {
    enojado [0] = loadImage ("SeñorNormal.png");
    enojado [0] .resize(50, 50);
    enojado [1] = loadImage ("ViejaNormal.png");
    enojado [1] .resize(50, 50);
    enojado [2] = loadImage ("NenaAlegre.png");
    enojado [2] .resize(50, 50);
    enojado [3] = loadImage ("ChinoPaz.png");
    enojado [3] .resize(50, 50);

    attachImage(enojado[RC=int(random(0,4))]);
    setName("Comida");
    setPosition(_x, _y);
    setStatic(false);
    setGrabbable(false);
  }
  void setEnojado() {
    if (RC==0){
    enojado [0] = loadImage ("SeñorEnojado.png");
    enojado [0] .resize(50, 50);
    attachImage(enojado[0]);
    grito1.play();
    if (grito1.isPlaying()) {
      grito1.rewind();
    }
    }
    if (RC== 1){
    enojado [1] = loadImage ("ViejaEnfurecida.png");
    enojado [1] .resize(50, 50);
    attachImage(enojado[1]);
    grito2.play();
        if (grito2.isPlaying()) {
      grito2.rewind();
    }
    }
    if (RC== 2){
    enojado [2] = loadImage ("NenaLlorando.png");
    enojado [2] .resize(50, 50); 
    attachImage(enojado[2]);
    grito3.play();
    if (grito3.isPlaying()) {
    grito3.rewind();
    }
    }
    if (RC== 3){
    enojado [3] = loadImage ("ChinoVolado.png");
    enojado [3] .resize(50, 50);
    attachImage(enojado[3]);
    grito4.play();
    if (grito4.isPlaying()) {
     grito4.rewind();
    }
  }
}}
