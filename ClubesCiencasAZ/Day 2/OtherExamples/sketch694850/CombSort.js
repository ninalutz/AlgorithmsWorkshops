class CombSort {
	constructor(n, seed, pos, height) {
		this.data = new DataSet(n, seed, pos, height);
		this.i = 0;
		this.maxI = n;
		this.dist = n-1;
		this.shrink = 1.3;
	}
	
	draw() {
		this.data.draw("Comb Sort");
		this.data.highlight(color(255), this.i, this.i+this.dist);
	}
	
	sort() {
		if (this.data.cmp(this.i, this.i+this.dist) == 1)
			this.data.swap(this.i, this.i+this.dist);
		this.i++;
		if (this.i+this.dist == this.maxI) {
			this.i = 0;
			this.dist = floor(this.dist/this.shrink);
			if (this.dist < 1)
				this.dist = 1;
		}
	}
}