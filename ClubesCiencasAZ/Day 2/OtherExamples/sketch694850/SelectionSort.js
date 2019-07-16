class SelectionSort {
	constructor(n, seed, pos, height) {
		this.data = new DataSet(n, seed, pos, height);
		this.i = 0;
		this.sortedTill = 0;
		this.max = n-1;
		this.min = this.sortedTill;
	}
	
	draw() {
		this.data.draw("Selection Sort");
		this.data.highlight(color(255), this.i);
		this.data.highlight(color(255), this.min);
		this.data.highlight(color(255), 0, this.sortedTill);
	}
	
	sort() {
		if (this.sortedTill == this.max)
			return
		if (this.i > this.max) {
			this.data.swap(this.sortedTill, this.min);
			this.sortedTill++;
			this.i = this.sortedTill+1;
			this.min = this.sortedTill;
			return
		}
		if (this.data.cmp(this.i, this.min) == -1) {
			this.min = this.i;
		}
		this.i++;
	}
}