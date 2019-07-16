var speed = 1; // amount of steps ran per frame (can go to floating point)
var lerpS = 0.3; // animation speed

var paused = true;
var array = [];
var toRemove = [];

// kinda meh how i've done this \/
var points = {
  i: 0,
  j: -1,
  s: -1
}
function resetPoints(){
  points = {}
  for( let index in sortTypes[sortType].points ){
    points[index] = sortTypes[sortType].points[index];
  }
}
var pointsC = {
  i: "white",
  j: "grey",
  s: "lime"
}
var sortType = "bubble";
var sortTypes = {
  "bubble": { "points": {i: 0} },
  "insert": { "points": {i: 0, j: 0, s: 0} },
}

var swaps = false;

var colour1, colour2;
var colourOps = {
  "Green & Aqua": [[0, 180, 50],[0, 180, 200]],
  "Pink & Purple": [[255, 100, 255],[100, 50, 200]],
  "Yellow & Orange": [[255, 255, 0],[255, 100, 0]],
  "Aqua & Blue": [[0, 180, 200],[0, 50, 220]],
  "Cream & red": [[250, 250, 200], [220, 10, 50]],
  "Tiktok": [[0, 180, 220], [230, 10, 50]]
}

var startX, endX, startH, endH;
var scl, bar, gap;

var amountS, speedS, shuffleB, controlB;

function setup() {
  createCanvas(windowWidth, windowHeight);
  background(51);
  noStroke();

  let startC = Object.keys(colourOps)[floor(random() * Object.keys(colourOps).length)]
  colour1 = colourOps[startC][0];
  colour2 = colourOps[startC][1];

  startX  = width*0.1;
  endX    = width*0.9;
  startH  = height*0.1;
  endH    = height*0.8;

  setArray(50);

  let eGap = 10;

  shuffleB = createButton("Shuffle");
  shuffleB.position( startX, endH+20 );
  shuffleB.mousePressed( () => {array.shuffle(), resetPoints()} );

  stepB = createButton("Step");
	stepB.size( shuffleB.width*0.8 );
  stepB.position( startX + shuffleB.width + eGap, endH+20 );
  stepB.mousePressed( nextStep );

  controlB = createButton("Play");
	controlB.size( shuffleB.width );
  controlB.position( startX + shuffleB.width + stepB.width + eGap*2, endH+20 );
  controlB.mousePressed( toggleProccessing );

  speedI = createSelect();
  speedI.position( startX + shuffleB.width*2 + stepB.width + eGap*3, endH+20 );
  speedI.size( stepB.width, stepB.height );
	for( var opt of ['x0.1','x0.25','x0.5','x1','x2','x3','x5','x10','x25','x50','x100','x1000','x10000'] ){ speedI.option(opt); } 
	speedI.value('x1');
  //speedI.attribute('placeholder', 'Speed');
  speedI.changed( () =>{ speed = float(speedI.value().split('').splice(1,10).join('')); } )

  sortS = createSelect();
  sortS.size( shuffleB.width*1.5, shuffleB.height );
  sortS.position( startX + shuffleB.width*2 + stepB.width*2 + eGap*4, endH+20 );
  for( var op in sortTypes ){ sortS.option(op); }
  sortS.changed( () => {
		sortType=sortS.value(),
		resetPoints()
	})

  colourS = createSelect();
  colourS.size( shuffleB.width*2 );
  colourS.position( endX - colourS.width, endH+20 );
  for( var op in colourOps ){ colourS.option(op); }
  colourS.changed( () => {
    colour1 = colourOps[colourS.value()][0];
    colour2 = colourOps[colourS.value()][1];
  })
  colourS.value(startC);

  amountS = createSlider(5, 600, array.length);
  amountS.position( startX + shuffleB.width*3.5 + stepB.width*2 + eGap*5, endH+20 );
  amountS.size( endX - startX - shuffleB.width*6.5 - speedI.width - eGap*5);
  amountS.input( () => setArray(amountS.value()) )
}

function draw(){
  background(51);
	
	// bottom line
  stroke(getColour( map(mouseX, 0, width, 1, array.length) ));
  strokeWeight(5);
  line( startX, endH+10, endX, endH+10 );
	
	// points along line to show currently selected indexs
  for( var index in sortTypes[sortType].points ){ drawIndex(index); }

  if( !paused && (speed >= 1 || frameCount%floor((1/speed))==0) ){
    var s = (speed>=1) ? speed : 1;
    for(var i=0; i<s; i++){
      nextStep();
      if( paused ){ break; }
    }
  }

  renderBars();
  for( var i=toRemove.length-1; i>0; i-- ){
    let bar = toRemove[i];
    //bar.x = lerp(bar.x, -width*0.2, lerpS );
    bar.h = lerp(bar.h, 0, lerpS*2);
    //bar.y = lerp(bar.y, -height/4, 0.05);
    bar.render();
    if( bar.x < -bar.w || bar.h < 1 ){ toRemove.splice(i, 1); }
  }
}

function drawIndex(index){
  let i = points[index];
  if(i<0){return; }
  let x = startX + (i)*(bar+gap);
  stroke(51);
  strokeWeight(7);
  line( x, endH+10, x+bar+gap, endH+10 );
  stroke(pointsC[index]);
  strokeWeight(1);
  line( x, endH+10, x+bar+gap, endH+10 );
}

function nextStep(){
  if( sortType == "bubble" ){
    if( points.i >= array.length-1 ){ points.i=0; if(!swaps){toggleProccessing(); return; }else{swaps=false;}}
    if( array[points.i].value > array[points.i+1].value ){ array.swap(points.i, points.i+1); swaps = true;}
    points.i++
  } else if( sortType == "insert" ){
    if( points.j<0 ){ points.i++; points.j = points.i; points.s = points.i; }
    if( points.i >= array.length ){ resetPoints(); toggleProccessing(); }
    if( array[points.i].value <= array[points.j].value ){ points.s = points.j; }
		else{ points.j = 0; }
    points.j--
    if( points.j<0 ){
      let bar = array.splice( points.i, 1 )[0];
      array.splice(points.s, 0, bar);
    }
  }
}

function toggleProccessing(){
  paused = !paused;
  controlB.elt.innerHTML = (paused) ? "Play" : "Pause";
}

// - [ BARS ] -

function setArray(amount){
  if( amount == array.length ){ return; }
  calcValues(amount);
  if( amount < array.length ){ var amountRemove = array.length - amount; toRemove = toRemove.concat(array.splice(0 , amountRemove)); }
  else{ array = array.concat(createBars(amount-array.length, array.length)); }
  setValues(amount);
  resetPoints();
}

function createBars(amount, start){
  let i = (start) ? start : 0;
  return Array(amount).fill().map( () => new Bar(++i) );
}

function renderBars(){
  noStroke();
  for( let bar of array ){
    bar.render();
    bar.update();
  }
}

function calcValues(length){
  scl    = (endH - startH)/length;
  bar    = ((endX - startX)/length)
  gap    = bar*0.2;
  bar    = bar - gap;
}

function setValues(amount){
  for( let i=0; i<amount; i++){
    array[i].value = i+1;
  }
}

function getColour(v){
  let c = 0;
  let colour = colour1.map( a => map(v, 1, array.length, a, colour2[c++]) );
  return color(colour[0], colour[1], colour[2]);
}

// - [ BAR OBJECT ] -

function Bar(v){
  this.value = v;
  this.colour = getColour(this.value);
  this.w = bar;
  //this.h = this.value*scl;
  //this.x = width*1.5;
  this.h = 0;
  this.x = endX-bar;
  this.y = endH;
}

Bar.prototype.update = function(){
  if( array.indexOf(this) != -1 ){
    var x = startX + (bar+gap)*array.indexOf(this);
    this.x = lerp(this.x, x, lerpS);
    this.w = lerp(this.w, bar, lerpS);
    this.h = lerp(this.h, this.value*scl, lerpS);
    this.colour = lerpColor(this.colour, getColour(this.value), lerpS/2);
  } else{
    this.x = lerp(this.x, width*2, 0.2);
    if( this.x > width ){ toRemove.splice( toRemove.indexOf(this), 1 ); }
  }
}

Bar.prototype.render = function(){
  fill(this.colour);
  //if(toRemove.indexOf(this)>-1){fill(255, 0, 0);}
  rect( this.x + gap/2, this.y, this.w, -this.h );
}

// - [ EXTRA OBJECT FUNCTIONS ] -

Array.prototype.shuffle = function() {
	for (let i = this.length - 1; i > 0; i--) {
		let j = floor(random() * (i + 1));
		let x = this[i];
		this[i] = this[j];
		this[j] = x;
	}
}

Array.prototype.swap = function(i, j){
  let a = this[i];
  this[i] = this[j]
  this[j] = a;
}

// - [ EXTRA FUNCTIONS ] -

function range(amount){
  let i = 0;
  let arr = Array(amount).fill().map( () => ++i );
  return arr;
}

// - [  EVENTS ] -

function keyPressed(e){
	if( e.key == "a" ){array.shuffle();}
	else if( e.key == "s"){nextStep();}
	else if( e.key == " "){toggleProccessing();}
}