class Charco extends FCircle

{

  Charco (float _d)
  {
    super(_d);
  }
    void inicializarC (float _x,float _y)
  {
    charcoImage = loadImage ("charco.png");
    charcoImage.resize(80,60);
    setName("Charco");
    attachImage(charcoImage);
    setPosition(_x,_y);
    setRotation(random(0));
    setStatic(true);
    setGrabbable(false);
    setSensor(true);
  }
}
