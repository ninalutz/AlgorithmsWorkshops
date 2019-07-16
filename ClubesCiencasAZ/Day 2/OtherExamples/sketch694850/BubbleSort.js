class BubbleSort {
	constructor(n, seed, pos, height) {
		this.data = new DataSet(n, seed, pos, height);
		this.i = 0;
		this.maxI = n;
	}
	
	draw() {
		this.data.draw("Bubble Sort");
		this.data.highlight(color(255), this.i, this.maxI);
	}
	
	sort() {
		if (this.data.cmp(this.i, this.i+1) == 1)
			this.data.swap(this.i, this.i+1);
		this.i++;
		if (this.i == this.maxI) {
			this.i = 0;
			this.maxI--;
		}
	}
}