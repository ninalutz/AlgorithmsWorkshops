class QuickSort {
	constructor(n, seed, pos, height) {
		this.data = new DataSet(n, seed, pos, height);
		this.intervals = [ [0, n-1] ];
		this.nextInterval();
		this.pivColor = color(255);
		this.intColor = color(255);
		this.stillSorting = true;
	}
	
	draw() {
		this.data.draw("Quick Sort");
		this.data.highlight(this.pivColor, this.pivot);
		this.data.highlight(this.pivColor, this.right);
		this.data.highlight(this.intColor, this.currInterval[0], this.currInterval[1]);
	}
	
	nextInterval() {
		if (this.intervals.length == 0) {
			this.pivot = 0;
			this.right = 0;
			this.stillSorting = false;
			return
		}
		var n = random(this.intervals.length);
		this.currInterval = this.intervals.splice(n, 1)[0];	
		this.pivot = this.currInterval[0];
		this.right = this.currInterval[1];
	}
	
	sort() {
		if (!this.stillSorting) {
			return;
		}
		if (this.pivot >= this.right) {
			if (this.currInterval[0] < this.pivot-1)
				this.intervals.push( [this.currInterval[0], this.pivot-1] )
			if (this.pivot+1 < this.currInterval[1])
				this.intervals.push( [this.pivot+1, this.currInterval[1]] )
			this.nextInterval();
			return;
		}
		if (this.currInterval[0]+1 >= this.currInterval[1]) {
			if (this.data.cmp(this.currInterval[0], this.currInterval[0]+1) == 1) {
				this.data.swap(this.currInterval[0], this.currInterval[0]+1);
			}
			this.nextInterval();
			return;
		}
		if (this.data.cmp(this.pivot, this.pivot+1) > 0) {
			this.data.swap(this.pivot, this.pivot+1);
			this.pivot++;
		} else {
			this.data.swap(this.pivot+1, this.right);
			this.right--;
		}
	}
}