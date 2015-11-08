package {
	import flash.display.Stage;
	import flash.display.MovieClip;

	public class Trash extends MovieClip {
		public var death: Boolean = false;
		public var where: Level;
		public var health: int = 10;
		
		public function Trash(level:Level, X: int, Y: int): void {
			this.x = X;
			this.y = Y;
			where = level;
		}
		public function loop(): void {
			if (health <= 0) {
				death = true;
			}
		}
		public function onHit(bullet:Bullet_pistol): void {
			
			health -= bullet.damage;
			var bullet_pistol: Bullet_pistol;
			for (var i:int = 0; i <= 360; i += 60) {
				bullet_pistol = new Bullet_pistol(where, x, y, rotation + i, 20);
				where.bulletList.push(bullet_pistol);
				where.addChild(bullet_pistol);
			}
		}
	}
}