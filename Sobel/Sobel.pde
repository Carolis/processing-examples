//declara a imagem e o tamanho do canvas do resultado

PImage img; 

void setup() { 
  size(1800, 500);
  img = loadImage("stonehenge_imagem1.png");
}

//declaracao do kernel usado para gerar a imagem com as bordas

float[][] kernel = {{1, 1, 1}, {1, -9, 1}, {1, 1, 1}};

//funcao para percorrer a imagem e multiplicar os pixels pelos parametros do kernel
void draw() {
  
  image(img, 0, 0);
  
  img.loadPixels();
  
  PImage edgeImg = createImage(img.width, img.height, RGB);
  
  for (int y = 1; y < img.height-1; y++) {
    for (int x = 1; x < img.width-1; x++) { 
      float sum = 0; 
      for (int ky = -1; ky <= 1; ky++) {
        for (int kx = -1; kx <= 1; kx++) {
          
          int pos = (y + ky)*img.width + (x + kx);

          float val = red(img.pixels[pos]);
          
          sum += kernel[ky+1][kx+1] * val;
        }
      }
      edgeImg.pixels[y*img.width + x] = color(sum, sum, sum);
    }
  }
  //desenha nova imagem com a representacao das bordas
  edgeImg.updatePixels();
  image(edgeImg, width/2, 0);
}
