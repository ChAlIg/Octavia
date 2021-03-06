﻿package {
	import flash.display.Stage;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;

	import flash.geom.Matrix;
	import flash.geom.Point;

	public class Level extends MovieClip {
		public var game: Game;
		public var trash: Trash;
		public var player1: Player1;
		public var player2: Player2;
		public var ambient: Ambient;
		public var walls: Walls;
		public var bulletList: Array = [];
		public var unitList: Array = [];
		public var point: Point;
		public var info: Info;
		
		private var i: int;
		private var j: int;

		public function Level(main:Game, X: int, Y: int): void {
			game = main;
			this.x = X;
			this.y = Y;
			ambient = new Ambient(0, 0);
			addChild(ambient);
			walls = new Walls(0, 0);
			addChild(walls);
			trash = new Trash(this, 320, 240);
			addChild(trash);
			unitList.push(trash);
			trash = new Trash(this, 234, 556);
			addChild(trash);
			unitList.push(trash);
			trash = new Trash(this, 34, 766);
			addChild(trash);
			unitList.push(trash);
			trash = new Trash(this, 457, 23);
			addChild(trash);
			unitList.push(trash);
			trash = new Trash(this, 345, 423);
			addChild(trash);
			unitList.push(trash);
			trash = new Trash(this, 264, 567);
			addChild(trash);
			unitList.push(trash);
			trash = new Trash(this, 32, 43);
			addChild(trash);
			unitList.push(trash);
			trash = new Trash(this, 123, 123);
			addChild(trash);
			unitList.push(trash);
			trash = new Trash(this, 400, 550);
			addChild(trash);
			unitList.push(trash);
			for (i = 0; i <=800; i += 200) {
				for (j = 0; j <= 600; j += 200) {
					trash = new Trash(this, i, j);
					addChild(trash);
					unitList.push(trash);
				}
			}
			player1 = new Player1(game, this);
			addChild(player1);
			unitList.push(player1);
			player2 = new Player2(game, this);
			addChild(player2);
			unitList.push(player2);
			info = new Info(0, 0);
			addChild(info);
			
			game.playerList.push(player1, player2);
			
		}
		public function loop(): void {
			
			for (i = unitList.length - 1; i >= 0; --i) //for each one
			{
				unitList[i].loop();
				if (unitList[i].death) {
					unitList[i].destroy();
					unitList.splice(i, 1);
				}
			}
			
			for (i = bulletList.length - 1; i >= 0; --i) //for each one
			{
				bulletList[i].loop();
				if (bulletList[i].death) {
					bulletList[i].destroy();
					bulletList.splice(i, 1);
				}
			}
			
			info.abc.text = new String("units = " + unitList.length + ", bullets = " + bulletList.length);
		}

	}
}