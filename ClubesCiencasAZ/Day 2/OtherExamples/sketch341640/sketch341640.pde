public static final int STEP = 2;
private final int BLUEISH = color(51, 102, 153);
private final int GREENISH = color(102, 153, 51);
private final int REDDISH = color(204, 51, 0);

private int[] array;

public void setup() {
  size (800, 600);
  array = initArray(STEP);
}

int[] initArray(int step) {
  int[] out = new int[width / step];
  for (int i = 0; i < out.length; i++) {
    out[i] = round(random(height));
  }
  return out;
}

void display(int index, int which) {
  final int STEP = round((float) width / array.length);
  pushStyle();
  strokeWeight(STEP * 2);
  stroke(BLUEISH);
  line(index * STEP, 0, index * STEP, height);
  line(which * STEP, 0, which * STEP, height);
  for (int x = 0; x < array.length; x += STEP) {
    int myColour = lerpColor(REDDISH, GREENISH, array[x] / (float) height);
    stroke(myColour);
    strokeWeight(STEP);
    line(x * STEP, 0, x * STEP, array[x]);
    strokeWeight(STEP * 3);
    point(x * STEP, array[x]);
  }
  popStyle();
}

int bubbleSortFrom(int index) {
  index %= array.length;

  while (index>0 && array[index]<array[index-1]) {
    int temp = array[index];
    array[index] = array[index-1];
    array[index-1] = temp;
    index--;
  }
  return index;
}

public void draw() {
  background(32);
  int which = bubbleSortFrom(frameCount - 1);
  display(frameCount - 1, which);
  if (frameCount % (array.length * 2) == 0) {
    array = initArray(STEP);
  }
}
