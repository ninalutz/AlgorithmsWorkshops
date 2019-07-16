var data = []

function setup() {
	createCanvas(windowWidth, windowHeight);
	createSorts();
}

function mouseClicked() {
	createSorts();
}

function mouseWheel() {
	DataSet_ChangeDrawType()
}

function createSorts() {
	seed = random(500);
	h = height / 9;
	n = 150;
	data = [];
	data.push(new StoogeSort(n, seed, 1*h, h));
	data.push(new BubbleSort(n, seed, 2*h, h));
	data.push(new CocktailShakerSort(n, seed, 3*h, h));
	data.push(new GnomeSort(n, seed, 4*h, 75));
	data.push(new SelectionSort(n, seed, 5*h, h));
	data.push(new InsertionSort(n, seed, 6*h, h));
	data.push(new CombSort(n, seed, 7*h, h));
	data.push(new QuickSort(n, seed, 8*h, h));
}

function draw() {
	background(0);
	for (d of data) {
		d.draw();
		d.sort();
	}
}