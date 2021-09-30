class Fragmentos extends FBox
{

  Fragmentos (float _w,float _h)
  {
    super(_w,_h);
  }
    void fragmentosV (float _x,float _y)
  {
    fragmentosImage = loadImage ("fragmentos.png");
    fragmentosImage.resize(120,50);
    setName("Fragmentos");
    setPosition(_x,_y);
    attachImage(fragmentosImage);
    setRestitution(1);
    setFriction(1);
    setDensity(1);
  }
}
