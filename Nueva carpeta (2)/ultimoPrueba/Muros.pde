class Muros extends FBox
{

  Muros (int _w,int _h)
  {
    super(_w,_h);
    reboteImage = loadImage ("paredR.jpg");
    paredEImage = loadImage ("paredE.png");
    paredEImage.resize(_w,_h);
    reboteImage.resize(_w,_h);
  }
  
  void inicializarR (float _x,float _y)
  {
    setPosition (_x,_y);
    setName("Rebote");    
    attachImage(reboteImage);
    setRotation(48);
    setStatic(true);
    setFill(139,21,152);
    setRestitution(0);
    setGrabbable(false);
  }
    void inicializarE (float _x,float _y)
  {
    setPosition (_x,_y);
    setName("Estatico");
    setStatic(true);
    setFill(0);
    setGrabbable(false);
    attachImage(paredEImage);
  }
    void inicializarV (float _x,float _y)
  {
    setPosition (_x,_y);
    setName("Vidrio");
    setStatic(true);
    setFill(162,223,255);
    setGrabbable(false);
    setSensor(true);
  } 
    void inicializarPL (float _x,float _y)
  {
    setPosition (_x,_y);
    setName("PuertaL");
    setStatic(true);
    setFill(255,0,0);
    setGrabbable(false);
  }
}
