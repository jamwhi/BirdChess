package BirdChess
{
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event
	
	/**
	 * ...
	 * @author James White
	 */
	
	public class Engine extends MovieClip
	{
		public static var theBoard:ChessBoard;
		
		
		// constructor
		public function Engine()
		{
			// create the chess board
			theBoard = new ChessBoard(stage);
			stage.addChild(theBoard);
			theBoard.setUp();
		}
	}
	
}