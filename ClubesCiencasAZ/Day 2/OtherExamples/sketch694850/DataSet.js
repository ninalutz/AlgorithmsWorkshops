var DataSet_DrawType = 0
function DataSet_ChangeDrawType() {
	DataSet_DrawType = (DataSet_DrawType + 1) % 3
}

class DataSet {
	constructor(n, seed, pos, height) {
		randomSeed(seed);
		this.border = 5;
		this.pos = pos;
		this.height = height;
		this.len = n;
		this.data = [];
		for (var i = 0; i < this.len; i++) {
			this.data.push(ceil(random(this.len))); // random
//			this.data.push(i+1); // pre-sorted
//			this.data.push(this.len-i); // reversed pre-sorted
		}
		this.heightRatio = (this.height-3*this.border) / this.len;
		this.width = (width - 2*this.border) / this.len
	}
	
	draw(name = "") {
		colorMode(HSB, this.len, 100, 100);
		if (DataSet_DrawType == 2) {
			noFill();
			strokeWeight(1);
			beginShape();
		} else {
			noStroke();
		}
		for (var i = 0; i < this.len; i++) {
			switch(DataSet_DrawType) {
				case 0:
					fill(this.data[i], 100, 100);
					rect(this.border + i*this.width, this.pos, this.width, -this.data[i]*this.heightRatio);
					break;
				case 1:
					fill(this.data[i], 100, 100);
					circle(this.border + (i+0.5)*this.width, this.pos-this.data[i]*this.heightRatio, this.width/2);
					break;
				case 2:
					stroke(255);
					vertex(this.border + (i+0.5)*this.width, this.pos-this.data[i]*this.heightRatio);
					break;
			}
		}
		if (DataSet_DrawType == 2) {
			endShape();
		}		
		textSize(20);
		textAlign(LEFT, TOP);
		noFill();
		stroke(255);
		strokeWeight(0.75)
		text(name, this.border, this.pos-this.height+this.border)
	}
	
	cmp(i, j) {
		if (this.data[i] < this.data[j])
			return -1;
		if (this.data[i] > this.data[j])
			return 1;
		return 0
	}
	
	swap(i, j) {
		var k = this.data[i];
		this.data[i] = this.data[j];
		this.data[j] = k;
	}
	
	highlight(col, i, j = -1) {
		if (j == -1) {
			noStroke();
			fill(col);
			rect(this.border + i*this.width, this.pos+this.border/2, this.width, this.width);
		} else {
			stroke(col);
			strokeWeight(this.width/4);
			noFill();
			line(this.border + i*this.width, this.pos+this.border, this.border + (j+1)*this.width, this.pos+this.border);			
		}
	}
}