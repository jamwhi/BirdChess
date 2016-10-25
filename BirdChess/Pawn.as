package BirdChess
{
	import BirdChess.ChessPiece;
	import BirdChess.Square;
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author James White
	 */
	public class Pawn extends ChessPiece 
	{
		
		public var dirUp:Boolean;
		
		public function Pawn(team:int)
		{
			this.team = team;
			
			dirUp = false;
			if (team == 2)
				dirUp = true;
			
			// depending on team, create and assign the graphic to this piece
			switch (team)
			{
				case 1:
					graphic = new FlipPawn();
					graphic.x = 0;
					graphic.y = 0;
					
					// set width to 100, and resize height accordingly
					graphic.height = 100 * graphic.height / graphic.width;
					graphic.width = 100;
					this.addChild(graphic);
				break;
				
				case 2:
					graphic = new GreenPawn();
					graphic.x = 0;
					graphic.y = 0;
					
					// set width to whataever, and resize height accordingly
					graphic.height = 80 * graphic.height / graphic.width;
					graphic.width = 80;
					this.addChild(graphic);
				break;
				
			}
			
			defaultWidth = graphic.width
			defaultHeight = graphic.height
		}
		
		private function movable(sq:Square):Boolean
		{
			// returns FALSE is there is a piece in this square
			// returns TRUE if there is no piece
			if (sq.myPiece)
			{
				return false;
			}
			return true;
		}
		
		private function movableDiag(sq:Square):Boolean
		{
			// returns true if there is a piece in this square and it is not on the same team
			// returns false if it is the same team
			// also returns FALSE if there is no piece
			
			if (sq.myPiece)
			{
				if (sq.myPiece.team != team)
				{
					return true;
				}
				return false;
			}
			return false;
		}
		
		override public function highlightValidSquares(squareArray:Array, pieceArray:Array):Array
		{
			// create an array to store which squares are valid, and will be highlighted.
			// this is so they can be easily used to determine a valid move, and also to be un-highlighted later.
			var highlightedSquares:Array = new Array();
			
			// make sure this pawn is on a square
			if (currentSquare)
			{
				var xx:int = currentSquare.place.x;
				var yy:int = currentSquare.place.y;
				
				// valid: the pawn can only move one space in one direction. check which direction that is
				// 2 spaces if from its starting place
				// the pawn can only capture pieces diagonally
				
				
				// check this pawn if it is an up moving pawn
				if (dirUp)
				{
					// highlight the square above it if valid
					if (movable(squareArray[xx][yy - 1]))
					{
						highlightedSquares.push(squareArray[xx][yy - 1]);
						
						// if the pawn hasn't moved yet, it can move 2 spaces. highlight 2 above it.
						if (yy == 6)
						{
							if (movable(squareArray[xx][yy - 2]))
							{
								highlightedSquares.push(squareArray[xx][yy - 2]);
							}
						}
					}
					
					// now check diagonals to see if it can capture a piece
					if (squareArray[xx + 1])
					{
						if (movableDiag(squareArray[xx + 1][yy - 1]))
						{
							highlightedSquares.push(squareArray[xx + 1][yy - 1]);
						}
					}
					
					if (squareArray[xx - 1])
					{
						if (movableDiag(squareArray[xx - 1][yy - 1]))
						{
							highlightedSquares.push(squareArray[xx - 1][yy - 1]);
						}
					}
				}
				
				// now check if it is a down moving pawn
				else
				{
					// highlight the square below it if valid
					if (movable(squareArray[xx][yy + 1]))
					{
						highlightedSquares.push(squareArray[xx][yy + 1]);
						
						// if the pawn hasn't moved yet, it can move 2 spaces. highlight 2 below it.
						if (yy == 1)
						{
							if (movable(squareArray[xx][yy + 2]))
							{
								highlightedSquares.push(squareArray[xx][yy + 2]);
							}
						}
					}
					
					// now check diagonals to see if it can capture a piece
					if (squareArray[xx + 1])
					{
						if (movableDiag(squareArray[xx + 1][yy + 1]))
						{
							highlightedSquares.push(squareArray[xx + 1][yy + 1]);
						}
					}
					
					if (squareArray[xx - 1])
					{
						if (movableDiag(squareArray[xx - 1][yy + 1]))
						{
							highlightedSquares.push(squareArray[xx - 1][yy + 1]);
						}
					}
				}
				
				// Check each of the currently valid squares to see if moving here will cause check
				// (our own king)
				
				for(var i:int = 0; i < highlightedSquares.length; i++)
				{
					checkCheck(highlightedSquares[i], pieceArray);
				}
				
				// loop through the newly created square array to highlight them all
				for (i = 0; i < highlightedSquares.length; i++)
				{
					highlightedSquares[i].highlight("Green");
				}
			}
			
			// return the array
			return highlightedSquares;
		}
		
		override public function isValidMove(square:Square):Boolean
		{
			if (square.validMove)
			{
				return true;
			}
			return false;
		}
		
		override public function movePiece(square:Square)
		{
			super.movePiece(square);
			checkPromotion();
		}
		
		// checkPromotion - returns true if this pawn is due to be promoted (is on the top or bottom of the board)
		public function checkPromotion():Boolean
		{
			if (currentSquare.place.y == 0 || currentSquare.place.y == 7)
			{
				return true;
			}
			return false;
		}
		
		
	}	
}