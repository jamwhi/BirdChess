package BirdChess
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author James White
	 */
	
	public class ChessPiece extends MovieClip
	{
		public var active:Boolean;
		public var team:int;
		public var currentSquare:Square;
		
		public var myKing:ChessPiece;
		
		protected var defaultWidth:Number;
		protected var defaultHeight:Number;
		
		protected var graphic:MovieClip;
		
		public function ChessPiece() 
		{
			active = true;
		}
		
		public function select()
		{
			graphic.height *= 0.8;
			graphic.width *= 0.8;
			this.startDrag(true);
		}
		
		public function unselect()
		{
			graphic.height = defaultHeight;
			graphic.width = defaultWidth;
			this.stopDrag();
		}
		
		public function take()
		{
			x = 900;
			y = Math.random() * 800;
			currentSquare = null;
			active = false;
		}
		
		public function highlightValidSquares(squareArray:Array, pieceArray:Array):Array
		{
			// virtual function
			return null;
		}
		
		public function isValidMove(square:Square):Boolean
		{
			// first test if the square is empty
			if (square.myPiece)
			{
				var targetPiece:ChessPiece = square.myPiece;
				
				// if not empty, test if destination piece is on the same team
				if (team == square.myPiece.team)
				{
					// check if its the same piece (i.e. clicked to move, then clicked the same place to put it down)
					// this shouldn't happen (as the check is done before this function is called) but this check happens just in case
					if (targetPiece == this)
					{
						return true;
					}
					
					// the piece here is on the same team - reject
					trace("can't move here - friendly piece here");
					return false;
				}
				// if the piece is not the same team, take the piece and its square
				else
				{
					trace("taking enemy piece");
					return true;
				}
			}
			
			// no piece, move the piece here
			trace("no piece in this square");
			return true;
			
		}
		
		public function movePiece(square:Square)
		{
			if (currentSquare)
			{
				currentSquare.losePiece();
			}
			square.placePiece(this);
			currentSquare = square;
			active = true;
		}
		
		public function checkCheck(square:Square, pieceArray:Array) : Boolean
		{
			// If this piece was to move to this square, will it cause our king to go into check?
			// Temporarily move this piece to that square and check against each of the enemy bishops, rooks and queens.
			// Pawns, knights and kings dont need to be checked as their attack paths dont get blocked.
			
			var realSquare:Square = this.currentSquare;
			var targetEmpty:Boolean = true;
			
			// if there's a piece in the square, we can effectively just remove this piece temporarily
			// otherwise, move this piece to the square
			if (square.myPiece)
			{
				realSquare.myPiece = null;
				targetEmpty = false;
			}
			else
			{
				square.myPiece = this;
			}
			
			// need to check pieces that are: Enemy team, In play, A bishop/rook/queen.
			for(var i:int = 0; i < pieceArray.length; i++)
			{
				if (pieceArray[i].active == true && pieceArray[i].team != this.team)
				{
					var piece:ChessPiece = pieceArray[i]
					var pieceType:String = piece.toString()
					switch (pieceType)
					{
						case "[object Rook]":
							if (piece.currentSquare.place.x == myKing.currentSquare.place.x || piece.currentSquare.place.y == myKing.currentSquare.place.y)
							{
								
							}
						break;
						case "[object Bishop]":
						
						break;
						case "[object Queen]":
						
						break;
					}
				}
			}
			
			
			
			// return piece to the right square
			if (targetEmpty)
				square.myPiece = null;
			else
				realSquare.myPiece = this;
			
			return true;
		}
	}
	
}