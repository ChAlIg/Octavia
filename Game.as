package {
	import flash.display.MovieClip;
	import flash.events.Event;

	import flash.display.Stage;
	import flash.display.StageDisplayState;
	import flash.events.MouseEvent;
	import flash.events.FullScreenEvent;

	import flash.geom.Matrix;
	import flash.geom.Point;

	import KeyObject;


	public class Game extends MovieClip {
		public var level: Level;
		public var facet: Facet;
		public var rotator: Matrix;
		var point: Point;

		public var leftPressed: Boolean = false;
		public var rightPressed: Boolean = false;
		public var upPressed: Boolean = false;
		public var downPressed: Boolean = false;
		public var qPressed: Boolean = false;
		public var ePressed: Boolean = false;
		public var leftMousePressed: Boolean = false;

		public var key: KeyObject;
		private var sqrt2: Number = Math.sqrt(2);
		public var roll: int = 0;
		public var jumpAccelerator: int = 3;

		public var i: int;
		public var j: int;
		public var number: Number;
		public var number1: Number;
		public var number2: Number;
		public var number3: Number;
		public var token:Boolean = false;

		public var rotSpeed: Number;
		public var coursor: Coursor;

		public function Game(): void {
			level = new Level(this, 0, 0);
			addChild(level);
			
			facet = new Facet(0, 0);
			addChild(facet);

			addEventListener(MouseEvent.CLICK, toggleFullscreen);
			//stage.addEventListener(MouseEvent.CLICK, shootBullet, false, 0, true);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, leftMousePressing, false, 0, true);
			stage.addEventListener(MouseEvent.MOUSE_UP, leftMouseUnpressing, false, 0, true);

			key = new KeyObject(stage);
			addEventListener(Event.ENTER_FRAME, loopGame, false, 0, true);
			
            stage.addEventListener(MouseEvent.RIGHT_CLICK, onRightClick); //присутствие этой строки отключает стандартное контекстное меню adobe flash, вызываемое в проигрывателе на правую кнопку мыши
        
		}
		
		private function onRightClick(e:MouseEvent):void {
            trace("Hello right click :)");
		}
		
		public function leftMousePressing(e: MouseEvent): void {
			leftMousePressed = true;
		}
		public function leftMouseUnpressing(e: MouseEvent): void {
			leftMousePressed = false;
		}

		public function loopGame(e: Event): void {
			
			checkKeypresses();
			/*token = false;
			number = speed / sqrt2;

			if (qPressed) {
				if ((roll == 0) && (level.player.energy >= 0)) {
					roll = -10;
					level.player.energy -= level.player.jumpCost;
				}
			} else if (ePressed) {
				if ((roll == 0) && (level.player.energy >= 0)) {
					roll = 10;
					level.player.energy -= level.player.jumpCost;
				}
			}

			if (roll > 0) {
				token = true;
				--roll;
				number1 = 0;
				number2 = 0;
				number3 = 0;
				for (i = 1; i <= jumpAccelerator; ++i) {
					point = level.localToGlobal(new Point(level.player.x, level.player.y));
					if (!level.walls.hitTestPoint(point.x + 13+ speed*(i-1), point.y, true)) {
						number1 -= speed;
						number2 += Math.cos(level.player.rotation * (Math.PI / 180))*speed;
						number3 += Math.sin(level.player.rotation * (Math.PI / 180))*speed;
					} else {
						break;
					}
				}
			} else if (roll < 0) {
				token = true;
				++roll;
				number1 = 0;
				number2 = 0;
				number3 = 0;
				for (i = 1; i <= jumpAccelerator; ++i) {
					point = level.localToGlobal(new Point(level.player.x, level.player.y));
					if (!level.walls.hitTestPoint(point.x - 13+ speed*(i-1), point.y, true)) {
						number1 += speed;
						number2 -= Math.cos(level.player.rotation * (Math.PI / 180))*speed;
						number3 -= Math.sin(level.player.rotation * (Math.PI / 180))*speed;
						//level.x += speed;
						//point = level.globalToLocal(playerPoint);
					} else {
						break;
					}
				}
				
			} else {

				point = level.localToGlobal(new Point(level.player.x, level.player.y));

				if (leftPressed) {
					if (upPressed && !level.walls.hitTestPoint(point.x - 13 / sqrt2, point.y - 13 / sqrt2, true)) {
						level.x += number;
						level.y += number;
					} else if (downPressed && !level.walls.hitTestPoint(point.x - speed / sqrt2, point.y + speed / sqrt2, true)) {
						level.x += number;
						level.y -= number/2;
					} else if (!level.walls.hitTestPoint(point.x - 13, point.y, true)) {
						level.x += speed;
					}
				} else if (rightPressed) {
					if (downPressed && !level.walls.hitTestPoint(point.x + 13 / sqrt2, point.y + 13 / sqrt2, true)) {
						level.x -= number;
						level.y -= number/2;
					} else if (upPressed && !level.walls.hitTestPoint(point.x + 13 / sqrt2, point.y - 13 / sqrt2, true)) {
						level.x -= number;
						level.y += number;
					} else if (!level.walls.hitTestPoint(point.x + 13, point.y, true)) {
						level.x -= speed;
					}
				} else if (upPressed && !level.walls.hitTestPoint(point.x, point.y - 13, true)) {
					level.y += speed;
				} else if (downPressed && !level.walls.hitTestPoint(point.x, point.y + 13, true)) {
					level.y -= speed/2;
				}


				point = level.globalToLocal(playerPoint); //конвертация локальных координат в глобальные
				level.player.x = point.x;
				level.player.y = point.y; //помещение игрока в то место в локальной системе координат, которое соответствует месту игрока в глобальных координатах (playerPoint) 

			}
			
			if (token == true) {
				level.x += number1;
				level.player.x += number2;
				level.player.y += number3;
			}
			
			if (leftMousePressed) {
				shootingBullet();
			}*/

			level.loop(); //запуск функции ниже уровнем, отвечающей за запуск соответствующих функций всех юнитов

		}

		public function checkKeypresses(): void {
			if (key.isDown(37) || key.isDown(65)) {
				leftPressed = true;
			} else {
				leftPressed = false;
			}

			if (key.isDown(38) || key.isDown(87)) {
				upPressed = true;
			} else {
				upPressed = false;
			}

			if (key.isDown(39) || key.isDown(68)) {
				rightPressed = true;
			} else {
				rightPressed = false;
			}

			if (key.isDown(40) || key.isDown(83)) {
				downPressed = true;
			} else {
				downPressed = false;
			}

			if (key.isDown(81)) {
				qPressed = true;
			} else {
				qPressed = false;
			}

			if (key.isDown(69)) {
				ePressed = true;
			} else {
				ePressed = false;
			}
		}

		public function toggleFullscreen(e: MouseEvent): void {
			stage.displayState = StageDisplayState.FULL_SCREEN;
			stage.mouseLock = true;
			stage.addEventListener(MouseEvent.MOUSE_MOVE, level.player.rotateAndCoursor);
		}

		/*public function rotateAndCoursor(e: MouseEvent): void {

			point = new Point(level.player.x, level.player.y);
			rotSpeed = -e.movementX / 2;
			if (rotSpeed > 20)
				rotSpeed = 20;
			else if (rotSpeed < -20)
				rotSpeed = -20;
			if (roll != 0)
				rotSpeed / 2;
			var t: Matrix = level.transform.matrix;
			point = t.transformPoint(point);
			t.translate(-point.x, -point.y);
			t.rotate(rotSpeed * (Math.PI / 180));
			t.translate(point.x, point.y);
			level.transform.matrix = t;
			level.player.rotation -= rotSpeed;

			coursor.moving(e.movementY);

		}
		public function shootBullet(e: MouseEvent): void {
			if (level.player.energy >= 0) {
				var bullet_pistol: Bullet_pistol = new Bullet_pistol(stage, level.player.x, level.player.y, level.player.rotation + (Math.random() * 30 - 15) * (coursor.scaleX - 1));
				level.units.push(bullet_pistol); //add this bullet to the bulletList array
				level.addChild(bullet_pistol);
			}
		}
		public function shootingBullet(): void {
			if ((level.player.energy >= 0) && (level.player.shotDelay == 0)) {
				var bullet_pistol: Bullet_pistol = new Bullet_pistol(level, level.player.x, level.player.y, level.player.rotation + (Math.random() * 30 - 15) * (coursor.scaleX - 1), 12 + Math.round((510 - coursor.y)/15));
				level.bulletList.push(bullet_pistol); //add this bullet to the bulletList array
				level.addChild(bullet_pistol);
				level.player.shotDelay = 8;
			}
		}*/
	}
}