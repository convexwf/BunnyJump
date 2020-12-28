class Mirror {
	float w = 80;
	float h = 160;
	float x;
	float y;
	float baseLine;
	boolean is_broken;

	PImage mirror, mirrot_broken;
	//------------------------------------------------------------------------------------------------------------------------------------------------------
	//constructor
	Mirror(float x, int type) {

		mirror = loadImage("mirror.png");
		mirrot_broken = loadImage("mirror_broken.png");

		this.x = x;
		this.is_broken = false;
		baseLine = ground - h / 2;
		// typeOfBird = type;
		switch(type) {
		case 0 ://flying low
			y = 10 + h / 2;
			y = baseLine;
			break;
		case 1 ://flying middle
			y = 100;
			y = baseLine - 120;
			break;
		case 2 ://flying high
			y = 180;
			y = baseLine - 200;
			break;
		}
	}
	//------------------------------------------------------------------------------------------------------------------------------------------------------
	// show the birf
	void show() {
		if (is_broken) image(mirrot_broken, x, y, w, h);
		else image(mirror, x, y, w, h);
	}
	// void show() {
	// 	flapCount++;
		
	// 	if (flapCount < 0) {//flap the berd
	// 		image(bird,posX - bird.width / 2,height - groundHeight - (posY + bird.height - 20));
	// 	} else {
	// 		image(bird1,posX - bird1.width / 2,height - groundHeight - (posY + bird1.height - 20));
	// 	}
	// 	if (flapCount > 15) {
	// 		flapCount = -15; 
			
	// 	}
	// }
	// //------------------------------------------------------------------------------------------------------------------------------------------------------
	//move the bard
	void move(float Speed) {
		x -= Speed;
	}
	// //------------------------------------------------------------------------------------------------------------------------------------------------------
	// //returns whether or not the bird collides with the player
	// boolean collided(float playerX, float playerY, float playerWidth, float playerHeight) {
		
	// 	float playerLeft = playerX - playerWidth / 2;
	// 	float playerRight = playerX + playerWidth / 2;
	// 	float thisLeft = posX - w / 2;
	// 	float thisRight = posX + w / 2;
		
	// 	if ((playerLeft <= thisRight && playerRight >= thisLeft) || (thisLeft <= playerRight && thisRight >= playerLeft)) {
	// 		float playerUp = playerY + playerHeight / 2;
	// 		float playerDown = playerY - playerHeight / 2;
	// 		float thisUp = posY + h / 2;
	// 		float thisDown = posY - h / 2;
	// 		if (playerDown <= thisUp && playerUp >= thisDown) {
	// 			return true;
	// 		}
	// 	}
	// 	return false;
	// }
}