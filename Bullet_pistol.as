package {
	import flash.display.Stage;
	import flash.display.MovieClip;
	import flash.display.DisplayObject;
	
	public class Bullet_pistol extends MovieClip {
		private var speed: Number = 15; //speed that the bullet will travel at
		public var xSpeed: Number; //current x velocity
		public var ySpeed: Number; //current y velocity
		private var rotationInRadiansMinus; //convenient to store our rotation in radians instead of degrees
		public var where: Level; //current x velocity
		
		public var damage: int; //current x velocity
		private var lifetime: int;
		public var death: Boolean = false;

		//our constructor requires: the stage, the position of the bullet, and the direction the bullet should be facing
		public function Bullet_pistol(level:Level, X: int, Y: int, rotationInDegrees: Number, life:int, fdamage:int = 3): void {
			
			this.rotation = rotationInDegrees;
			this.rotationInRadiansMinus = (rotationInDegrees - 90) * Math.PI / 180; //convert degrees to radians, for trigonometry
			this.x = X + Math.cos(rotationInRadiansMinus)*25;
			this.y = Y + Math.sin(rotationInRadiansMinus)*25;
			lifetime = life;
			where = level;
			damage = fdamage;
		}
		public function loop(): void {
			xSpeed = Math.cos(rotationInRadiansMinus) * speed; //uses the cosine to get the xVel from the speed and rotation
			ySpeed = Math.sin(rotationInRadiansMinus) * speed; //uses the sine to get the yVel
			
			x += xSpeed; //updates the position
			y += ySpeed;
			
			
			--lifetime;
			if (lifetime <= 0) {
				death = true;
			}
		}
	}
}