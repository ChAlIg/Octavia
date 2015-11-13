package {
	import flash.display.Stage;
	import flash.display.MovieClip;
	import flash.display.DisplayObject;
	
	import flash.geom.Point;
	
	public class Bullet_pistol extends MovieClip {
		private var speed: Number = 10; //speed that the bullet will travel at
		public var xSpeed: Number; //current x velocity
		public var ySpeed: Number; //current y velocity
		private var rotationInRadiansMinus; //convenient to store our rotation in radians instead of degrees
		public var level: Level; //current x velocity
		
		public var damage: int; //current x velocity
		private var lifetime: int;
		public var death: Boolean = false;

		//our constructor requires: the stage, the position of the bullet, and the direction the bullet should be facing
		public function Bullet_pistol(where:Level, X: int, Y: int, rotationInDegrees: Number, life:int, fdamage:int = 3): void {
			
			this.rotation = rotationInDegrees;
			this.rotationInRadiansMinus = (rotationInDegrees - 90) * Math.PI / 180; //convert degrees to radians, for trigonometry
			this.x = X + Math.cos(rotationInRadiansMinus)*20;
			this.y = Y + Math.sin(rotationInRadiansMinus)*20;
			lifetime = life;
			level = where;
			damage = fdamage;
		}
		public function loop(): void {
			xSpeed = Math.cos(rotationInRadiansMinus) * speed; //uses the cosine to get the xVel from the speed and rotation
			ySpeed = Math.sin(rotationInRadiansMinus) * speed; //uses the sine to get the yVel
			
			x += xSpeed; //updates the position
			y += ySpeed;
			
			var point:Point = level.localToGlobal(new Point(x, y));
			if (level.walls.hitTestPoint(point.x, point.y, true))
				death = true;
			
			for (var j:int = level.unitList.length - 1; j >= 0; --j)
				if (level.unitList[j].hitTestPoint(point.x, point.y, true)) {
					level.unitList[j].onHit(this);
					death = true;
				}
				
			--lifetime;
			if (lifetime <= 0)
				death = true;
			
		}
		public function destroy(): void {
			/*var little_explosion:Little_explosion = new Little_explosion();
			little_explosion.x = x;
			little_explosion.y = y;
			level.addChild(little_explosion);*/
			level.removeChild(this);
		}
	}
}