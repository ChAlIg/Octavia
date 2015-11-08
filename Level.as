﻿package {
	import flash.display.Stage;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;

	import flash.geom.Matrix;
	import flash.geom.Point;

	public class Level extends MovieClip {
		public var trash: Trash;
		public var player: Player;
		public var ambient: Ambient;
		public var walls: Walls;
		public var little_explosion: Little_explosion;
		public var bulletList: Array = [];
		public var unitList: Array = [];
		public var point: Point;
		public var info: Info;
		
		private var i: int;
		private var j: int;

		public function Level(X: int, Y: int): void {
			this.x = X;
			this.y = Y;
			ambient = new Ambient(0, 0);
			addChild(ambient);
			walls = new Walls(0, 0);
			addChild(walls);
			trash = new Trash(320, 240);
			addChild(trash);
			unitList.push(trash);
			trash = new Trash(234, 556);
			addChild(trash);
			unitList.push(trash);
			trash = new Trash(34, 766);
			addChild(trash);
			unitList.push(trash);
			trash = new Trash(457, 23);
			addChild(trash);
			unitList.push(trash);
			trash = new Trash(345, 423);
			addChild(trash);
			unitList.push(trash);
			trash = new Trash(264, 567);
			addChild(trash);
			unitList.push(trash);
			trash = new Trash(32, 43);
			addChild(trash);
			unitList.push(trash);
			trash = new Trash(123, 123);
			addChild(trash);
			unitList.push(trash);
			trash = new Trash(400, 550);
			addChild(trash);
			unitList.push(trash);
			player = new Player(400, 550);
			addChild(player);
			unitList.push(player);
			info = new Info(0, 0);
			addChild(info);
			
		}
		public function loop(): void {

			if (bulletList.length > 0) //if there are any bullets in the bullet list
			{
				for (i = bulletList.length - 1; i >= 0; --i) //for each one
				{
					bulletList[i].loop(); //call its loop() function
					
					point = localToGlobal(new Point(bulletList[i].x, bulletList[i].y));
					if (walls.hitTestPoint(point.x, point.y, true)) {
						bulletList[i].death = true;
					} else {
						for (j = unitList.length - 1; j >= 0; --j) {
							if (unitList[j].hitTestPoint(point.x, point.y, true)) {
								bulletList[i].death = true;
								unitList[j].onHit(bulletList[i]);
							}
						}
					}
					
					if (bulletList[i].death) {
						little_explosion = new Little_explosion();
						little_explosion.x = bulletList[i].x;
						little_explosion.y = bulletList[i].y;
						addChild(little_explosion);
						removeChild(bulletList[i]);
						bulletList.splice(i, 1);
					}
				}
			}
			
			if (unitList.length > 0) //if there are any units in the unit list
			{
				for (i = unitList.length - 1; i >= 0; --i) //for each one
				{
					if (unitList[i].death) {
						var normal_explosion:Normal_explosion = new Normal_explosion();
						normal_explosion.x = unitList[i].x;
						normal_explosion.y = unitList[i].y;
						addChild(normal_explosion);
						removeChild(unitList[i]);
						unitList.splice(i, 1);
					} else {
						unitList[i].loop();
					}
				}
			}
			
			info.abc.text = new String("units = " + unitList.length + ", bullets = " + bulletList.length);
		}

	}
}