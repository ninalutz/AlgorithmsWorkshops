class CocktailShakerSort {
	constructor(n, seed, pos, height) {
		this.data = new DataSet(n, seed, pos, height);
		this.i = 0;
		this.maxI = n;
		this.minI = 0;
		this.status = 1; //1 = shake up, -1 = shake down
	}
	
	draw() {
		this.data.draw("Cocktail Shaker Sort");
		this.data.highlight(color(255), this.minI, this.maxI);
	}
	
	sort() {
		if (this.status == 1) {
			if (this.data.cmp(this.i, this.i+1) == 1)
				this.data.swap(this.i, this.i+1);
			this.i++;
			if (this.i == this.maxI) {
				this.status *= -1;
				this.maxI--;
			}
		} else {
			if (this.data.cmp(this.i, this.i-1) == -1)
				this.data.swap(this.i, this.i-1);
			this.i--;
			if (this.i == this.minI) {
				this.status *= -1;
				this.minI++;
			}
		}
	}
}