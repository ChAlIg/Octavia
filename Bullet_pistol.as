package {
	import flash.display.Stage;
	import flash.display.MovieClip;
	import flash.display.DisplayObject;
	
	import flash.geom.Point;
	
	public class Bullet_pistol extends MovieClip {
		
		public var pace: Point = new Point(0,0);
		public var level: Level;
		
		public var damage: int;
		private var lifetime: int;
		public var death: Boolean = false;

		public function Bullet_pistol(where:Level, X: int, Y: int, rotationInDegrees: Number, life:int, theDamage:int = 3, theSpeed:Number = 10): void {
			
			rotation = rotationInDegrees;
			var rotationRequired : Number = (rotationInDegrees - 90) * Math.PI / 180;
			pace.x = Math.cos(rotationRequired)*theSpeed;
			pace.y = Math.sin(rotationRequired)*theSpeed;
			x = X + Math.cos(rotationRequired)*20;
			y = Y + Math.sin(rotationRequired)*20;
			lifetime = life;
			level = where;
			damage = theDamage;
		}
		
		
		public function loop(): void {
			x += pace.x;
			y += pace.y;
			if (pace.y < 0) {
				rotation = 450 - (180/Math.PI) * Math.acos (pace.x / Math.sqrt (pace.x * pace.x + pace.y * pace.y));
			} else {
				rotation = 90 + (180/Math.PI) * Math.acos (pace.x / Math.sqrt (pace.x * pace.x + pace.y * pace.y));
			}
			
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