class Bullet {
	float w = 90;
	float h = 30;
	float x;
	float y;
	PImage carrot;
	//------------------------------------------------------------------------------------------------------------------------------------------------------
	//constructor
	Bullet(float x, float y, int type) {

		carrot = loadImage("carrot.png");
		this.y = y;
		this.x = x;
	}
	//------------------------------------------------------------------------------------------------------------------------------------------------------
	// show the birf
	void show() {
		image(carrot, x, y, w, h);
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
		x += Speed;
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