package BirdChess
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.ui.Mouse;
	
	/**
	 * ...
	 * @author James White
	 */
	
	public class ChessBoard extends MovieClip
	{
		protected var stageRef:Stage;
		
		public var squareArray:Array;
		public var pieceArray:Array;
		
		public var team1:int;
		public var team2:int;
		public var team1turn:Boolean;
		
		public var team1King:ChessPiece;
		public var team2King:ChessPiece;
		
		public var selectedPiece:ChessPiece;
		
		private var highlightedSquares:Array;
		
		private static var pauseMenu:PauseMenu;
		private static var moveHistory:ChessHistory;
		
		//Constructor
		public function ChessBoard(stageRef:Stage)
		{
			// set a reference to the stage
			this.stageRef = stageRef;
			stageRef.addEventListener(KeyboardEvent.KEY_DOWN, keyHandler);
			
			// create the pause menu
			pauseMenu = new PauseMenu(this);
			this.addChild(pauseMenu);
			pauseMenu.visible = false;
			pauseMenu.x = 550;
			pauseMenu.y = 150;
			
			// create the move history object
			moveHistory = new ChessHistory();
		}
		
		public function keyHandler(e:KeyboardEvent)
		{
			switch (e.keyCode)
			{
				case 66: // b - back a move
					backMove();
				break;
				case 80: // p - show pause menu
					pauseMenu.visible = !pauseMenu.visible;
					setChildIndex(pauseMenu, numChildren - 1);
				break;
			}
		}
		
		/***********************************************************
		 *  SETTING UP THE BOARD
		 **********************************************************/
		
		// Sets up the board. 
		// functionality for setting up different pieces on either side will be added
		// (i.e. which set of pieces starts on which side)
		public function setUp()
		{
			pieceArray = [];
			team1turn = true;
			team1 = 1;
			team2 = 2;
			
			// set up the 2d 8x8 array by nesting arrays
			squareArray = new Array (8);
			for (var i:int = 0; i < 8; i++)
			{
				squareArray[i] = new Array(8);
			}
			 
			// These nested loops correspond to the 8 columns and rows of the chess board.
			// To set up the board, each square is drawn individually, then the correct piece is placed.
			for (var j:int = 0; j < 8; j++) // columns
			{
				for (var k:int = 0; k < 8; k++) // rows
				{
					// create a new instance of Square
					// 0 if even, 1 if odd.
					// 0 means black square, 1 means white square
					var newSquare:Square = new Square((j + k) % 2, j * 100 + 50, k * 100 + 50, j, k); 
					 // add the square to the ChessBoard
					this.addChildAt(newSquare, 0);
					// add a mouse click event listener to the square (for selecting pieces in that square - the piece also gets a listener)
					newSquare.addEventListener(MouseEvent.CLICK, clickSquare);
					// add the square to our 2d array at this position
					squareArray[j][k] = newSquare; 
					
					
					
					// test if this square should start with a piece on it, and if so create the piece
					
					switch (k)
					{
						case 0: // top main row
							setupBigPieces(j, k, 1);
						break;
						
						case 1: // top pawn row
							createPawnAtSquare(squareArray[j][k], 1);
						break;
						
						case 2:
						case 3:
						case 4:
						case 5:
						break;
						
						case 6: // bottom pawn row
							createPawnAtSquare(squareArray[j][k], 2);
						break;
						
						case 7: // bottom main row
							setupBigPieces(j, k, 2);
						break;
						
					}					
				}
			}
			
			// run through the pieces and set their king reference
			for (i = 0; i < pieceArray.length; i++)
			{
				if (pieceArray[i].team == team1)
					pieceArray[i].myKing = team1King;
				else
					pieceArray[i].myKing = team2King;
			}
		}
		
		public function setupBigPieces(column:Number, row:Number, team:Number)
		{
			switch(column)
			{
				case 0: case 7: // rook
					createRookAtSquare(squareArray[column][row], team);
				break;
				
				case 1: case 6: // knight
					createKnightAtSquare(squareArray[column][row], team);
				break;
				
				case 2: case 5: // bishop
					createBishopAtSquare(squareArray[column][row], team);
				break;
				
				case 3: // queen
					createQueenAtSquare(squareArray[column][row], team);
				break;
				
				case 4: // king
					if (team == team1)
						team1King = createKingAtSquare(squareArray[column][row], team);
					else
						team2King = createKingAtSquare(squareArray[column][row], team);
				break;
			}
		}
		
		public function createRookAtSquare(theSquare:Square, team:Number) : ChessPiece
		{
			// create new rook
			var newRook = new Rook(team);
			newRook.movePiece(theSquare);
			this.addChild(newRook)
			newRook.addEventListener(MouseEvent.CLICK, clickPiece);
			pieceArray.push(newRook);
			return newRook;
		}
		
		public function createKnightAtSquare(theSquare:Square, team:Number) : ChessPiece
		{
			// create new knight
			var newKnight = new Knight(team);
			newKnight.movePiece(theSquare);
			this.addChild(newKnight)
			newKnight.addEventListener(MouseEvent.CLICK, clickPiece);
			pieceArray.push(newKnight);
			return newKnight;
		}
		
		public function createBishopAtSquare(theSquare:Square, team:Number) : ChessPiece
		{
			// create new Bishop
			var newBishop = new Bishop(team);
			newBishop.movePiece(theSquare);
			this.addChild(newBishop)
			newBishop.addEventListener(MouseEvent.CLICK, clickPiece);
			pieceArray.push(newBishop);
			return newBishop;
		}
		
		public function createQueenAtSquare(theSquare:Square, team:Number) : ChessPiece
		{
			// create new QUEEEEN
			var newQueen = new Queen(team);
			newQueen.movePiece(theSquare);
			this.addChild(newQueen)
			newQueen.addEventListener(MouseEvent.CLICK, clickPiece);
			pieceArray.push(newQueen);
			return newQueen;
		}
		
		public function createKingAtSquare(theSquare:Square, team:Number) : ChessPiece
		{
			// create new King
			var newKing = new King(team);
			newKing.movePiece(theSquare);
			this.addChild(newKing)
			newKing.addEventListener(MouseEvent.CLICK, clickPiece);
			pieceArray.push(newKing);
			return newKing;
		}
		public function createPawnAtSquare(theSquare:Square, team:Number)
		{
			// create new pawn
			var newPawn = new Pawn(team);
			newPawn.movePiece(theSquare);;
			this.addChild(newPawn)
			newPawn.addEventListener(MouseEvent.CLICK, clickPiece);
			pieceArray.push(newPawn);
		}
		
		/************************************************************
		 * CLICK HANDLING
		 ************************************************************/
		
		// clickSquare //
		// Function for event listener attached to chess squares.
		// If there is a piece in this square, select that piece (or move selected piece to this square)
		 
		public function clickSquare(e:MouseEvent):void
		{
			var clickedSquare:Square = Square(e.currentTarget);
			
			if (selectedPiece)
			{
				// a piece is currently selected - try to move it to where was clicked
				movePieceToSquare(selectedPiece, clickedSquare);
			}
			else
			{
				// no piece is selected
				// start dragging whatever piece is in this square
				if (clickedSquare.myPiece)
				{
					// check if this piece is on the team of the player who's turn it currently is
					if (team1turn)
					{
						if (clickedSquare.myPiece.team == team1)
						{
							selectPiece(clickedSquare.myPiece)
						}
					}
					else
					{
						if (clickedSquare.myPiece.team == team2)
						{
							selectPiece(clickedSquare.myPiece)
						}
					}
				}
			}
		}
		
		// clickPiece //
		// Function for event listener attached to chess pieces.
		// Select this piece.
		// If there is a piece already selected, move it to the closest square to here
		
		public function clickPiece(e:MouseEvent):void
		{
			var clickedPiece:ChessPiece = ChessPiece(e.currentTarget);
			
			if (selectedPiece)
			{
				// a piece is currently selected
				// find the closest square to this point, and try to move the piece there
				var point:Point = new Point(e.stageX, e.stageY);
				var closestSquare:Square = findClosestSquareToPoint(point);
				
				// the -1 type is a dummy square created temporarily in findClosestSquareToPoint which indicates no square is close by
				if (closestSquare.type == -1)
				{
					// probably an accident, don't do anything
					//var temp:ChessPiece = selectedPiece;
					//unselectPiece();
					//temp.currentSquare = null;
				}
				else
				{
					movePieceToSquare(selectedPiece, closestSquare);
				}
			}
			else
			{
				// no piece selected
				// start dragging this piece if it's that player's turn
				if (team1turn)
				{
					if (clickedPiece.team == team1)
					{
						selectPiece(clickedPiece)
					}
				}
				else
				{
					if (clickedPiece.team == team2)
					{
						selectPiece(clickedPiece)
					}
				}
				
			}
		}
		
		public function selectPiece(whichPiece:ChessPiece)
		{
			selectedPiece = whichPiece;
			setChildIndex(selectedPiece, numChildren - 2);
			selectedPiece.select();
			
			if (selectedPiece.currentSquare)
			{
				// highlight the square this piece is on
				selectedPiece.currentSquare.highlight();
				
				// highlight the squares of possible moves for this piece
				highlightedSquares = selectedPiece.highlightValidSquares(squareArray, pieceArray);
			}
		}
		
		public function unselectPiece()
		{
			if (selectedPiece)
			{
				selectedPiece.unselect();
			
				if (selectedPiece.currentSquare)
				{
					// un-highlight/un-select this piece's square
					selectedPiece.currentSquare.unHighlight();
					
					// un-highlight this piece's possible moves
					unHighlightPossibleMoves();
				}
			}
			
			selectedPiece = null;
		}
		private function unHighlightPossibleMoves()
		{
			for (var i:int = 0; i < highlightedSquares.length; i++)
			{
				highlightedSquares[i].unHighlight();
			}
		}
		
		public function movePieceToSquare(thePiece:ChessPiece, theSquare:Square, specialMove:int = 0)
		{
			// check if this is a valid move
			// if succeess, unselect the piece and record the move to the move history
			
			if (thePiece != theSquare.myPiece)
			{
				if (thePiece.isValidMove(theSquare))
				{
					var newMove:ChessMove = new ChessMove(thePiece, thePiece.currentSquare, theSquare, null, specialMove)
					
					if (theSquare.myPiece)
					{
						newMove.pieceTaken = theSquare.myPiece;
						theSquare.myPiece.take();
					}
					
					thePiece.movePiece(theSquare);
					
					// if it's a pawn, check if it should be promoted
					if (thePiece.toString() == "[object Pawn]")
					{
						if (Pawn(thePiece).checkPromotion())
						{
							//promote
							var promote:PawnPromote = new PawnPromote(this, thePiece)
							promote.x = thePiece.x;
							if (promote.x > 600)
								promote.x = 600;
							if (promote.x < 200)
								promote.x = 200;
							// check which side
							if (thePiece.y < 400)
								promote.y = 100;
							else
								promote.y = 700;
							this.addChild(promote);
						}
					}
					
					unselectPiece();
					
					moveHistory.unHighlightLastMove();
					moveHistory.recordMove(newMove);
					moveHistory.highlightLastMove();
					
					if (specialMove == 0)
					{
						// some more post-move stuff
						
						team1turn = !team1turn;
					}
					
				}
			}
			else
			{
				// clicked the same square it came from - just put it back and unselect
				selectedPiece.movePiece(theSquare);
				unselectPiece();
			}
		}
		
		public function findClosestSquareToPoint(point:Point):Square
		{
			var winSquare:Square
			winSquare = new Square(-1, point.x+50, point.y+50, 10, 10);
			
			// cycle through the square array to find the closest square to the point
			// (must be better way of doing this... hitTest ??)
			
			for (var j:int = 0; j < squareArray.length; j++)
			{
				for (var k:int = 0; k < squareArray[j].length; k++)
				{
					if (Math.abs(squareArray[j][k].x - point.x) + Math.abs(squareArray[j][k].y - point.y) < Math.abs(winSquare.x - point.x) + Math.abs(winSquare.y - point.y))
					{
						winSquare = squareArray[j][k]
					}
					
				}
			}
			
			return winSquare;
		}
		
		/************************************************************
		 * OTHER STUFF
		 ************************************************************/
		
		public function backMove()
		{
			moveHistory.unHighlightLastMove();
			moveHistory.backMove(this);
			moveHistory.highlightLastMove();
		}
	}
	
}