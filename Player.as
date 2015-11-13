package {
	import flash.display.MovieClip;

	public class Player extends MovieClip {
		public var level: Level;
		
		public var death: Boolean = false;
		
		public var energyMax: int = 190;
		public var healthMax: int = 10;
		public var jumpCost: int = 100;
		
		public var energy: int = 0;
		public var health: int = healthMax;
		public var shotDelay: int = 0;

		public function Player(where:Level, X: int, Y: int): void {
			this.x = X;
			this.y = Y;
			level = where;
		}
		public function loop(): void {
			if (health <= 0)
				death = true;
			
			if (energy < energyMax)
				++energy;
			
			if (shotDelay > 0)
				--shotDelay;
			
		}
		public function onHit(bullet:Bullet_pistol): void {
			health -= bullet.damage;
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