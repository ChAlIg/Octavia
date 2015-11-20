package {
	import flash.display.MovieClip;
	import flash.geom.Transform; 
	import flash.geom.ColorTransform; 

	public class Trash extends MovieClip {
		
		public var level: Level;
		public var usualColour: ColorTransform = new ColorTransform ();
		public var hitTimer: int = 0;
		public var redOnHit: ColorTransform = new ColorTransform (2.5);
		
		public var death: Boolean = false;
		public var health: int = 10;
		
		public function Trash(where:Level, X: int, Y: int): void {
			this.x = X;
			this.y = Y;
			level = where;
		}
		public function loop(): void {
			if (hitTimer == 1) {
				--hitTimer;
				this.transform.colorTransform = usualColour;
			} else if (hitTimer) {
				--hitTimer
				this.transform.colorTransform = redOnHit;
			}
			if (health <= 0) {
				death = true;
			}
		}
		public function onHit(bullet:Bullet_pistol): void {
			
			health -= bullet.damage;
			var bullet_pistol: Bullet_pistol;
			var j:int = (Math.random()*60);
			for (var i:int = 0; i < 6; ++i) {
				bullet_pistol = new Bullet_pistol(level, x, y, j + i*60, 20);
				level.bulletList.push(bullet_pistol);
				level.addChild(bullet_pistol);
			}
			hitTimer = 5;
		}
		public function destroy(): void {
			var explosion_basic:Explosion_basic = new Explosion_basic(x, y, 5);
			level.addChild(explosion_basic);
			level.removeChild(this);
		}
	}
}