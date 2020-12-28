//Globals
int frameSpeed = 60;
int stopFrame = 0;

float ground , scale , distanceInBetween , gameSpeed;
float score, max_score;
Player bunny; 
float last_x;
boolean started;

ArrayList<Obstacle> obstacles;
ArrayList<Mirror> mirrors;
Bullet bullet;

//images
// PImage bunnyRun1;
// PImage bunnyRun2;
// PImage bunnyJump;
// PImage smallCactus;
// PImage manySmallCactus;
// PImage bigCactus;
// PImage mirror;
// PImage broken_mirror;


// int groundHeight = 50;
// int playerXpos = 150;

void setup() {
	
	// frameRate(60);
	size(1280, 720);
	
	
	started = true;
	ground = height - 75;
	scale = width / 4;
	
	
	distanceInBetween = random(width / 2 + 100,width / 2 + 200);
	
	bunny = new Player();
	
	obstacles = new ArrayList<Obstacle>();
	mirrors = new ArrayList<Mirror>();
    reset();

	
}

void reset() {
	gameSpeed = scale * 0.05;
	score = 0.;
	stopFrame = -1;
	bunny.dead = false;
	bunny.jumped = false;
	obstacles.clear();
	mirrors.clear();
	Obstacle firstObstacle = new Obstacle(width + distanceInBetween,floor(random(3)));
	Mirror firstMirror = new Mirror(width + 2 * distanceInBetween,floor(random(3)));
	bullet = new Bullet(width + 100, height  + 100, 0);
	obstacles.add(firstObstacle);
	mirrors.add(firstMirror);
	last_x = firstMirror.x;

	// JSONObject js = loadJSONObject('score.json')；
	String lines[] = loadStrings("score.txt");
	max_score = Float.parseFloat(lines[0]);
	// print(lines[0]);

}

//--------------------------------------------------------------------------------------------------------------------------------------------------------
void draw() {
	drawToScreen();
}

void drawToScreen() {
	background(255);
	stroke(0);
	line(0,ground,width,ground);
	// started = startButton.clicked;

	fill(120);
  	textAlign(LEFT);
	textSize(40);
	text("Max Score: " + floor(max_score), width-400, 50);
	textAlign(LEFT);
	textSize(40);
	text("Cur Score: " + floor(score), width-400, 100);
	
	distanceInBetween = random(width / 2 + 100,width / 2 + 200);
	
	animateObstacles();
	bunny.update();
	bunny.render();

	if (stopFrame < 0) {
		score += 1. / 6;
		generateObstacles();
		if (checkCollision()) {
			stopFrame = 60;
			saves_score();
		}
	}
	else if (stopFrame == 0) {
		stopFrame--;
		reset();
	}
	else {
		stopFrame--;
	}

	// checkCollision--;
	
	// checkObstacles();
}

void keyPressed() {
	switch(key) {
	case 'a' ://speed up frame rate
		if (bullet.x > width) {
			// print("what happened");
			bullet.x = bunny.x;
			bullet.y = bunny.y;
		}

		break;
	case ' ' ://slow down frame rate
		bunny.jump();
		break;

	}
	
}

void animateObstacles() {
	// print(obstacles.size());
	// print(mirrors.size());
	for (int i = 0; i  < obstacles.size(); i++) {
		obstacles.get(i).show();
		obstacles.get(i).move(gameSpeed);
	}
	for (int i = 0; i < mirrors.size(); i++) {
		mirrors.get(i).show();
		mirrors.get(i).move(gameSpeed);
	}
	bullet.show();
	bullet.move(gameSpeed);
	// for (int i = 0; i < bullets.size(); i++) {
	// 	bullets.get(i).show();
	// 	bullets.get(i).move(gameSpeed);
	// 	if (bullets.get(i).x >= width) {
	// 		bullets.remove(i);
	// 		i--;
	// 	}
	// }
	if (!bunny.dead) {
		gameSpeed += scale * 0.000015;
	}
}

void generateObstacles() {	
	int type = floor(random(6));
	last_x -= gameSpeed;
	distanceInBetween = random(width / 2 + 100 * (1 + gameSpeed * 0.1 + type * 0.4),width / 2 + 200 * (1 + gameSpeed * 0.1 + type * 0.4));
	if (last_x + distanceInBetween >= width) return;
	last_x += distanceInBetween;
	if (type >= 3) {
		type -= 3;
		
		Obstacle newObstacles = new Obstacle(last_x, type);
		obstacles.add(newObstacles);
		for (int i = 0; i < obstacles.size(); i++) {
			if (obstacles.get(i).x + (obstacles.get(i).w) / 2 < 0) {
				obstacles.remove(i);
				i--;
				score += 50;
			}
		}
	}
	else {
		Mirror newMirrors = new Mirror(last_x, type);
		mirrors.add(newMirrors);
		for (int i = 0; i < mirrors.size(); i++) {
			if (mirrors.get(i).x + (mirrors.get(i).w) / 2 < 0) {
				mirrors.remove(i);
				i--;
				score += 50;
			}
		}
	}
	
}

void saves_score() {
	
	String[] lines = new String[1];
	lines[0] = String.valueOf(max(score, max_score));
	saveStrings("data/score.txt", lines);
}

// void checkObstacles() {
// 	if (obstacles.get(0).x + obstacles.get(0).w / 2 < bunny.x - bunny.w / 2) {
// 		currentObstacle = obstacles.get(1);
// 	} else {
// 		currentObstacle = obstacles.get(0);
// 	}
// 	checkCollision(currentObstacle);
// }

boolean checkCollision() {
	// ArrayList<int> to_remove = new ArrayList<int>();
	float x = bullet.x + bullet.w / 2;
	float y = bullet.y + bullet.h / 2;
	for (int i = 0; i < mirrors.size(); i++) {
		if (mirrors.get(i).x <= x && x <= mirrors.get(i).x + mirrors.get(i).w && 
				mirrors.get(i).y <= y+10 && y-10 <= mirrors.get(i).y + mirrors.get(i).h) {
			mirrors.get(i).is_broken = true;
			bullet.x = width + 1;
			score += 100;
				// to_remove.add(j);
		}
		if  (!mirrors.get(i).is_broken) {
			if (bunny.collide(mirrors.get(i).x, mirrors.get(i).y, mirrors.get(i).x + mirrors.get(i).w, mirrors.get(i).y + mirrors.get(i).h)) {
				bunny.dead = true;
				gameSpeed = 0;
				return true;
			}
		}
	}
	// for (int j = 0; j < bullets.size(); j++) {

	// }
	for (int i = 0; i < obstacles.size(); i++) {
		Obstacle obstacle = obstacles.get(i);
		if (bunny.collide(obstacle.x, obstacle.y, obstacle.x + obstacle.w, obstacle.y + obstacle.h)) {
			bunny.dead = true;
			gameSpeed = 0;
			return true;
		}
	}

	return false;
}
