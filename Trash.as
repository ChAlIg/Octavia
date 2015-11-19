package {
	import flash.display.MovieClip;

	public class Trash extends MovieClip {
		
		public var level: Level;
		
		public var death: Boolean = false;
		public var health: int = 10;
		
		public function Trash(where:Level, X: int, Y: int): void {
			this.x = X;
			this.y = Y;
			level = where;
		}
		public function loop(): void {
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
		}
		public function destroy(): void {
			/*var normal_explosion:Normal_explosion = new Normal_explosion();
			normal_explosion.x = x;
			normal_explosion.y = y;
			level.addChild(normal_explosion);*/
			level.removeChild(this);
		}
	}
}