class Player {
	float x , y , w , h;
	float gravity , velocity , jumpUnit , baseLine;
	PImage bunny , bunnyRun1 , bunnyRun2 , bunnyJump1 , bunnyJump2, bunnyDead , currentImage;
	boolean jumped , dead;
	Player() {
		w = scale * 0.4;
		h = scale * 0.25;
		baseLine = ground - h / 2;
		x = 70;
		y = baseLine;
		gravity = scale * 0.00833333333;
		velocity = 0;
		jumpUnit = scale * 0.12;
		bunny = loadImage("dino0000.png");
		bunnyRun1 = loadImage("bunny1.png");
		bunnyRun2 = loadImage("bunny4.png"); 
		bunnyJump1 = loadImage("bunny2.png");
		bunnyJump2 = loadImage("bunny3.png");
		bunnyDead = loadImage("dinoDead0000.png");
	}
	
	void render() {
		if (!jumped && !dead && started) {
			if (millis() % 400 < 100) {
				currentImage = bunnyRun1;
			} else if (100 <= millis() % 400 && millis() % 400 < 200) {
				currentImage = bunnyJump1;
			} else if (200 <= millis() % 400 && millis() % 400 < 300) {
				currentImage = bunnyJump2;
			} else {
				currentImage = bunnyRun2;
			}
		} else if (jumped) {
			if (velocity < 0) currentImage = bunnyJump1;
			else currentImage = bunnyJump2;
		} else if (dead) {
			currentImage = bunnyDead;
		} else {
			currentImage = bunny;
		}
		// print(x,y,w,h);
		imageMode(CENTER);
		image(currentImage,x,y,w,h);
	}
	
	void update() {
		y += velocity;
		if (y < baseLine) {
			jumped = true;
			velocity += gravity;
		} else {
			y = baseLine;
			velocity = 0;
			jumped = false;
		}
		if (dead) {
			velocity = 0;
			jumped = false;
		}
	}
	
	void jump() {
		if (y == baseLine) {
			velocity -= jumpUnit;
		}
	}

	boolean collide(float x1, float y1, float x2, float y2) {
		float dist = sqrt(pow(w / 2, 2) + pow(h / 2, 2));
		if (sqrt(pow( (x1+x2)/2 - (x+w/2), 2) + pow( (y1+y2)/2 - (y+h/2), 2) ) <= dist) return true;
		return false;
	}
	
}
