class GnomeSort {
	constructor(n, seed, pos, height) {
		this.data = new DataSet(n, seed, pos, height);
		this.i = 0;
		this.maxI = n-1;
	}
	
	draw() {
		this.data.draw("Gnome Sort");
		this.data.highlight(color(255), this.i);
	}
	
	sort() {
		if(this.i == this.maxI)
			return;
		if(this.data.cmp(this.i, this.i+1) == 1) {
			this.data.swap(this.i, this.i+1);
			if (this.i != 0)
				this.i--;
			else
				this.i++;
			return;
		} else {
			this.i++;
		}
	}
}