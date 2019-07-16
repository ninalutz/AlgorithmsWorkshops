float[] arr, L, R, another;
boolean start, check;
int l, m, r, i, j, k, n1, n2, index, mx, from, mid, to;

void setup() {
  size(1526, 696);
  // fullScreen();

  // pixelDensity(1);
  noiseSeed(54545);
  noiseDetail(4, 0.5);

  arr = new float[1920];
  another = new float[arr.length];

  for (int y = 0; y < arr.length; y++) {
    arr[y] = map(noise(0.005 * y), 0, 0.8, 0, height);
  }

  start = false;
  check = false;

  mx = 1;
  from = 0;
  to = from + 2 * mx - 1;
  mid = from + mx - 1;
  if (mid > to) {
    mid = (from + to) / 2;
  }

  l = from;
  m = mid;
  r = to;

  n1 = m - l + 1;
  n2 = r - m;
  index = from;

  /* create temp arrays */
  L = new float[n1];
  R = new float[n2];

  /* Copy data to temp arrays L[] and R[] */
  for (int y = 0; y < n1; y++) {
    L[y] = arr[l + y];
  }
  for (int y = 0; y < n2; y++) {
    R[y] = arr[m + 1+ y];
  }

  i = 0; 
  j = 0;
  k = l;

  //println();
  //printArr();
  background(51);
  noStroke();
  displayArr();
}

void draw() {
  for (int f = 0; f < 40; f++) {
    if (start) {
      /* Merge the temp arrays back into arr[l..r]*/
      if (i < n1 && j < n2 && !check) {
        if (L[i] <= R[j]) {
          another[k++] = L[i++];
        } else {
          another[k++] = R[j++];
        }
      } else {
        check = true;
      }

      /* Copy the remaining elements of L[], if there are any */
      if (i < n1 && check) {
        another[k++] = L[i++];
      }

      /* Copy the remaining elements of R[], if there are any */
      if (j < n2 && check) {
        another[k++] = R[j++];
      }

      if (k > r && check) {
        arr[index] = another[index];
        index++;
        if (index > to) {
          //start = false;
          check = false;

          from += 2 * mx;
          if (from >= arr.length - 1) {
            from = arr.length - 1;
          }
          to = from + 2 * mx - 1;
          if (to > arr.length - 1) {
            to = arr.length - 1;
          }
          mid = from + mx - 1;
          if (mid > to) {
            mid = (from + to) / 2;
          }

          l = from;
          m = mid;
          r = to;

          n1 = m - l + 1;
          n2 = r - m;
          index = from;

          /* create temp arrays */
          L = new float[n1];
          R = new float[n2];

          /* Copy data to temp arrays L[] and R[] */
          for (int y = 0; y < n1; y++) {
            L[y] = arr[l + y];
          }
          for (int y = 0; y < n2; y++) {
            R[y] = arr[m + 1+ y];
          }

          i = 0;
          j = 0;
          k = l;

          another = new float[arr.length];

          if (from >= arr.length - 1) {
            //start = false;
            mx = 2 * mx;
            check = false;
            if (mx >= arr.length) {
              start = false;
              check = true;
            }

            from = 0;
            to = from + 2 * mx - 1;
            if (to > arr.length - 1) {
              to = arr.length - 1;
            }
            mid = from + mx - 1;
            if (mid > to) {
              mid = (from + to) / 2;
            }

            l = from;
            m = mid;
            r = to;

            n1 = m - l + 1;
            n2 = r - m;
            index = from;

            /* create temp arrays */
            L = new float[n1];
            R = new float[n2];

            /* Copy data to temp arrays L[] and R[] */
            for (int y = 0; y < n1; y++) {
              L[y] = arr[l + y];
            }
            for (int y = 0; y < n2; y++) {
              R[y] = arr[m + 1+ y];
            }

            i = 0;
            j = 0;
            k = l;

            another = new float[arr.length];
          }
        }
      }
    } else {
      noLoop();
      //println();
      //printArr();
      //background(51);
      //displayArr();
    }
  }
  background(51);
  for (int y = 0; y < arr.length; y++) {
    fill(200, 150);
    if ((y == l + i || y == m + j + 1) && !check) {
      fill(255, 0, 0);
    } else if (y == l || y == r) {
      fill(0, 255, 0);
    } else if (y == m + 1 && !check) {
      fill(0, 255, 200);
    } else  if (y == index - 1 && check) {
      fill(255, 0, 255);
    }
    rect(y, height - arr[y], 1, arr[y]);
  }
}

void mousePressed() {
  start = true;
  loop();
}

void keyPressed() {
  if (key == ENTER) {
    start = true;
    loop();
  }
  if (key == BACKSPACE) {
    start = false;
  }
}

void printArr() {
  for (int y = 0; y < arr.length; y++) {
    print(arr[y] + " ");
  }
}

void displayArr() {
  for (int y = 0; y < arr.length; y++) {
    rect(y, height - arr[y], 1, arr[y]);
  }
}
