package {

	import flash.display.MovieClip;

	public class Coursor extends MovieClip {

		var number: Number;
		var player: Player;

		public function Coursor(X: int, Y: int, thePlayer:Player) {
			this.x = X;
			this.y = Y;
			c2.alpha = 0;
			c3.alpha = 0;
			player = thePlayer;
		}
		/*public function moving(dy: Number) {
			y += dy;
			if (y > 510)
				y = 510;
			else if (y < 30)
				y = 30;

			scaleX = scaleY = 2 - (y - 30) / 480;

			number = y - 410;
			if (number < 0)
				number = 0;
			else if (number > 100)
				number = 100;
			c1.alpha = number / 100;
			number = 100 - Math.abs(y - 350);
			if (number < 0)
				number = 0;
			c2.alpha = number / 100;
			number = 100 - Math.abs(y - 190);
			if (number < 0)
				number = 0;
			c3.alpha = number / 100;
		}*/
		public function moving(dx:Number, dy: Number) {
			if (x+dx > 800)
				x = 800;
			else if (x+dx < 0)
				x = 0;
			else
				x += dx;
			
			if (y+dy > 600)
				y = 600;
			else if (y+dy < 0)
				y = 0;
			else
				y += dy;
			rotation = player.rotation;
		}

	}

}