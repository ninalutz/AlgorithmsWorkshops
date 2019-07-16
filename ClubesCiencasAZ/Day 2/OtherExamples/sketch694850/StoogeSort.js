class StoogeSort {
	constructor(n, seed, pos, height) {
		this.data = new DataSet(n, seed, pos, height);
		this.intervals = [ [0, n-1] ];
		this.nextInterval();
		this.intColor = color(255);
		this.stillSorting = true;
	}
	
	draw() {
		this.data.draw("Stooge Sort");
		this.data.highlight(this.intColor, this.currInterval[0], this.currInterval[1]);
	}
	
	nextInterval() {
		if (this.intervals.length == 0) {
			this.stillSorting = false;
			return
		}
		this.currInterval = this.intervals.pop();	
	}
	
	sort() {
		if (!this.stillSorting) {
			return;
		}
		var l = this.currInterval[0];
		var r = this.currInterval[1];
		if (this.data.cmp(l, r) == 1) {
			this.data.swap(l, r);
		}
		if (r-l+1 > 2) {
			var m = ceil((r - l + 1) / 3)
			this.intervals.push( [l, r-m] );
			this.intervals.push( [l+m, r] );
			this.intervals.push( [l, r-m] );
		}
		this.nextInterval()
	}
}