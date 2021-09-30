class Mozo extends FCircle
{

  Mozo (float _d)
  {
    super(_d);
  }
    void inicializarMO (float _x,float _y)
  {
    mozoImage = loadImage ("mozo.png");
    mozoImage.resize(70,70);
    setName("Mozo");
    setPosition(_x,_y);
    attachImage(mozoImage);
    setRestitution(1);
    setFriction(1);
    setDensity(1);
  }
}
