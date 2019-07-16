
int[] array = {9, 34, 17, 21, 2, 90};
int i = 0;
boolean sorted = false;

void setup(){
  println("Unsorted: ");
  println(array);
  
  while(!sorted){
    for (int j=0; j<array.length; j++) {
        println("Left: " + array[i] + " Right: " + array[j]);
        if (array[i] > array[j]) { //looks at the pair
          int temp = array[j];
          array[j] = array[i];
          array[i] = temp;
        } 
    }
    i++;
    if (i>array.length-1) sorted = true;
  }
   
  println("Sorted: ");
  println(array);
  
}
