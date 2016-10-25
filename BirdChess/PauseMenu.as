package BirdChess
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	
	/**
	 * ...
	 * @author James White
	 */
	public class PauseMenu extends MovieClip
	{
		private var theGame:ChessBoard
		
		public function PauseMenu(theGame:ChessBoard)
		{
			this.theGame = theGame;
			
			this.addEventListener(MouseEvent.MOUSE_DOWN, clickMenu)
			this.addEventListener(MouseEvent.MOUSE_UP, unclickMenu)
			close.addEventListener(MouseEvent.MOUSE_DOWN, clickClose)
			back.addEventListener(MouseEvent.MOUSE_DOWN, clickBack)
		}
		
		public function clickMenu(e:MouseEvent):void
		{
			// dragable menu yay
			this.startDrag();
		}
		
		public function unclickMenu(e:MouseEvent):void
		{
			this.stopDrag();
		}
		
		public function clickClose(e:MouseEvent):void
		{
			// stop this event from bubbling (so it wont trigger the clickmenu listener)
			e.stopPropagation();
			
			// close the menu
			this.visible = false
		}
		
		public function clickBack(e:MouseEvent):void
		{
			// stop this event from bubbling (so it wont trigger the clickmenu listener)
			e.stopPropagation();
			
			// take back the last move
			theGame.backMove();
		}
	}
	
}