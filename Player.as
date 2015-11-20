package {
	import flash.display.MovieClip;
	import flash.events.Event;

	import flash.display.Stage;
	import flash.events.MouseEvent;

	import flash.geom.Matrix;
	import flash.geom.Point;
	
	import flash.geom.Transform; 
	import flash.geom.ColorTransform; 

	public class Player extends MovieClip {
		public var level: Level;
		public var game: Game;
		public var facet: Facet;
		
		public var death: Boolean = false;
		
		public var energyMax: int = 190;
		public var healthMax: int = 100;
		public var jumpCost: int = 100;
		public var speed: Number = 5;
		public var playerPoint: Point = new Point(400, 300);
		
		public var energy: int = 0;
		public var health: int = healthMax;
		public var shotDelay: int = 0;
		
		public var i: int;
		public var j: int;
		public var number: Number;
		public var number1: Number;
		public var number2: Number;
		public var number3: Number;
		public var token:Boolean = false;
		public var point: Point;
		
		private var sqrt2: Number = Math.sqrt(2);
		public var roll: int = 0;
		public var jumpAccelerator: int = 3;
		
		public var rotSpeed: Number;
		public var coursor: Coursor;
		
		public var usualColour: ColorTransform = new ColorTransform ();
		public var hitTimer: int = 0;
		public var redOnHit: ColorTransform = new ColorTransform (2.5);

		public function Player(main:Game, where:Level, X: int = 400, Y: int = 300): void {
			this.x = X;
			this.y = Y;
			level = where;
			game = main;
			coursor = new Coursor(400, 300, this);
			facet = new Facet(0, 0);
			
			//stage.addEventListener(MouseEvent.MOUSE_MOVE, rotateAndCoursor);
		}
		public function loop(): void {
			if (hitTimer == 1) {
				--hitTimer;
				this.transform.colorTransform = usualColour;
			} else if (hitTimer) {
				--hitTimer
				this.transform.colorTransform = redOnHit;
			}
			
			if (health <= 0)
				death = true;
			
			if (energy < energyMax)
				++energy;
			
			if (shotDelay > 0)
				--shotDelay;
			
			number = speed / sqrt2;
			point = level.localToGlobal(new Point(x, y));

				if (game.leftPressed) {
					if (game.upPressed && !level.walls.hitTestPoint(point.x - 13 / sqrt2, point.y - 13 / sqrt2, true)) {
						level.x += number;
						level.y += number;
					} else if (game.downPressed && !level.walls.hitTestPoint(point.x - speed / sqrt2, point.y + speed / sqrt2, true)) {
						level.x += number;
						level.y -= number;
					} else if (!level.walls.hitTestPoint(point.x - 13, point.y, true)) {
						level.x += speed;
					}
				} else if (game.rightPressed) {
					if (game.downPressed && !level.walls.hitTestPoint(point.x + 13 / sqrt2, point.y + 13 / sqrt2, true)) {
						level.x -= number;
						level.y -= number;
					} else if (game.upPressed && !level.walls.hitTestPoint(point.x + 13 / sqrt2, point.y - 13 / sqrt2, true)) {
						level.x -= number;
						level.y += number;
					} else if (!level.walls.hitTestPoint(point.x + 13, point.y, true)) {
						level.x -= speed;
					}
				} else if (game.upPressed && !level.walls.hitTestPoint(point.x, point.y - 13, true)) {
					level.y += speed;
				} else if (game.downPressed && !level.walls.hitTestPoint(point.x, point.y + 13, true)) {
					level.y -= speed;
				}
				
				point = level.globalToLocal(playerPoint);
				x = point.x;
				y = point.y; //помещение игрока в то место в локальной системе координат, которое соответствует месту игрока в глобальных координатах (playerPoint) 
			
			/*if (game.leftMousePressed) {
				shootingBullet();
			}*/

		}
		
		public function rotateAndCoursor(e: MouseEvent): void {
			
			rotation = Math.atan2(coursor.x - 400, -(coursor.y - 300)) * 180 / Math.PI;
			coursor.moving(e.movementX, e.movementY);

		}
		
		/*public function shootingBullet(): void {
			if ((energy >= 0) && (shotDelay == 0)) {
				var bullet_pistol: Bullet_pistol = new Bullet_pistol(level, x, y, rotation + (Math.random() * 30 - 15) * (coursor.scaleX - 1), 12 + Math.round((510 - coursor.y)/15));
				level.bulletList.push(bullet_pistol); //add this bullet to the bulletList array
				level.addChild(bullet_pistol);
				shotDelay = 8;
			}
		}*/
		
		public function shootingBullet(e: MouseEvent): void {
			if ((energy >= 0) && (shotDelay == 0)) {
				var bullet_pistol: Bullet_pistol = new Bullet_pistol(level, x, y, rotation + (Math.random() * 14 - 7)*Math.sqrt((coursor.x-400)*(coursor.x-400) + (coursor.y-300)*(coursor.y-300))/400 , 12 + Math.sqrt((coursor.x-400)*(coursor.x-400) + (coursor.y-300)*(coursor.y-300))/10);
				level.bulletList.push(bullet_pistol); //add this bullet to the bulletList array
				level.addChild(bullet_pistol);
				shotDelay = 8;
			}
		}
		
		public function onHit(bullet:Bullet_pistol): void {
			health -= bullet.damage;
			hitTimer = 5;
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