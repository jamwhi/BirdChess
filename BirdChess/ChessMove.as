package BirdChess
{
	
	/**
	 * ...
	 * @author James White
	 */
	public class ChessMove 
	{
		public var pieceMoved:ChessPiece
		public var squareFrom:Square
		public var squareTo:Square
		public var pieceTaken:ChessPiece
		public var specialMove:Number
		
		public function ChessMove(pieceMoved:ChessPiece, squareFrom:Square, squareTo:Square,
									pieceTaken:ChessPiece = null, specialMove:Number = 0)
		{
			this.pieceMoved = pieceMoved;
			this.squareFrom = squareFrom
			this.squareTo = squareTo;
			this.pieceTaken = pieceTaken;
			this.specialMove = specialMove;
		}
	}
	
}