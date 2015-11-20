﻿package {
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
		public var rotator: Matrix;
		var point: Point;

		public var leftPressed: Boolean = false;
		public var rightPressed: Boolean = false;
		public var upPressed: Boolean = false;
		public var downPressed: Boolean = false;
		public var qPressed: Boolean = false;
		public var ePressed: Boolean = false;
		public var zPressed: Boolean = false;
		public var xPressed: Boolean = false;
		public var leftMousePressed: Boolean = false;

		public var key: KeyObject;

		public var i: int;
		public var j: int;
		public var number: Number;
		public var number1: Number;
		public var number2: Number;
		public var number3: Number;
		public var token:Boolean = false;
		
		public var activePlayer:int = -1;
		public var playerList: Array = [];

		public function Game(): void {
			level = new Level(this, 0, 0);
			addChild(level);
			
			addEventListener(MouseEvent.CLICK, toggleFullscreen);
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
			if ((zPressed) && (activePlayer != 0)) {
				if (activePlayer != -1)
					playerList[activePlayer].toggleActivityDown();
				playerList[0].toggleActivityUp();
				activePlayer = 0;
			}
			if ((xPressed) && (activePlayer != 1)) {
				if (activePlayer != -1)
					playerList[activePlayer].toggleActivityDown();
				playerList[1].toggleActivityUp();
				activePlayer = 1;
			}
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
			if (key.isDown(90)) {
				zPressed = true;
			} else {
				zPressed = false;
			}
			if (key.isDown(88)) {
				xPressed = true;
			} else {
				xPressed = false;
			}
		}

		public function toggleFullscreen(e: MouseEvent): void {
			stage.displayState = StageDisplayState.FULL_SCREEN;
			stage.mouseLock = true;
		}
	}
}