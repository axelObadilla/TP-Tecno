class Mesas extends FCircle
{
  int id;
  boolean contacto = false;
  Mesas (float _d, int x)
  {
    super(_d);
    id = x;
  }
    void inicializarM (float _x,float _y)
  {
    mesaImage = loadImage ("mesa.png");
    mesaImage.resize(130,130);
    setName("Mesa");
    attachImage(mesaImage);
    setPosition(_x,_y);
    setStatic(true);
    setGrabbable(false);
  }
      void mesaComida ()  {
    String [] words = {"MesaComida.png","MesaComida1.png","MesaComida2.png"};
    int index = int (random(words.length));
    mesaComida = loadImage (words[index]);
    mesaComida.resize(130,130);
    attachImage(mesaComida);
  }
}
