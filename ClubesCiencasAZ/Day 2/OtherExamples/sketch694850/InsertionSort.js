class InsertionSort {
	constructor(n, seed, pos, height) {
		this.data = new DataSet(n, seed, pos, height);
		this.max = n-1;
		this.nextPos = n-2;
		this.curr = n-2;
		this.hlColor = color(255);
	}
	
	draw() {
		this.data.draw("Insertion Sort");
		this.data.highlight(this.hlColor, this.curr);
		this.data.highlight(this.hlColor, this.nextPos, this.max);
	}
	
	takeNext() {
		this.nextPos--;
		this.curr = this.nextPos;
		if (this.nextPos < 0) {
			this.nextPos = 0;
			this.curr = 0;
		}
	}
	
	sort() {
		if (this.data.cmp(this.curr, this.curr+1) == 1) {
			this.data.swap(this.curr, this.curr+1);
			this.curr++;
			if (this.curr == this.max)
				this.takeNext()
		} else {
			this.takeNext()			
		}
	}
}