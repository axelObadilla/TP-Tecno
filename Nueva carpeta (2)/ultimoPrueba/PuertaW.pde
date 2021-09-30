class PuertaW extends FBox
{
  boolean contacto = false;
  PuertaW (int _w,int _h)
  {
    super(_w,_h);
    puertaImage = loadImage ("puerta.png");
    puertaImage.resize(_w,_h);
  }
      void inicializarPW (float _x,float _y)
  {
    translate(_x,_y);
    attachImage(puertaImage);
    rotate(PI/8);
    setPosition (_x,_y);
    setName("PuertaW");
    setStatic(true);
    setFill(0,255,0);
    setGrabbable(false);
  }
}
