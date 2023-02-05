# University of Washington, Programming Languages, Homework 6, hw6runner.rb

# This is the only file you turn in, so do not modify the other files as
# part of your solution. We recommend you not use irb to load uw6runner.rb
# and start a game. You can use the REPL for testing individual methods
# and exploring the program, though.

# Xingjian Xuanyuan

class MyPiece < Piece
  # the constant All_My_Pieces should be declared here
  All_My_Pieces = All_Pieces + [rotations([[0,0], [1,0], [-1,0], [0,-1], [-1,-1]]),
                                rotations([[0,0], [1,0], [0,1]]),
                                [[[0,-2], [0,-1], [0,0], [0,1], [0,2]],
                                 [[-2,0], [-1,0], [0,0], [1,0], [2,0]]]]

  # for cheat function
  Cheat_Piece = [[[0,0]]]

  # your enhancements here
  def initialize (point_array, board)
    super
  end

  # choose the next piece, called by MyBoard's next_piece
  def self.next_piece (board)
    MyPiece.new(All_My_Pieces.sample, board)
  end

  def self.next_piece_for_cheat (board)
    MyPiece.new(Cheat_Piece, board)
  end
end

class MyBoard < Board
  # your enhancements here
  attr_accessor :will_cheat

  def initialize (game)
    self.will_cheat = false
    @grid = Array.new(num_rows) {Array.new(num_columns)}
    @current_block = MyPiece.next_piece(self)
    @score = 0
    @game = game
    @delay = 500
  end

  def store_current
    locations = @current_block.current_rotation
    displacement = @current_block.position
    (0..(locations.size - 1)).each{|index| 
      current = locations[index];
      @grid[current[1]+displacement[1]][current[0]+displacement[0]] = 
      @current_pos[index]
    }
    remove_filled
    @delay = [@delay - 2, 80].max
  end

  def next_piece
    if !self.will_cheat
      @current_block = MyPiece.next_piece(self)
    else
      self.will_cheat = false
      @score -= 50  # modified on request by Lucas
      @current_block = MyPiece.next_piece_for_cheat(self)
    end
    @current_pos = nil
  end

  ## rotate 180 degrees
  def rotate_pi_move
    if !game_over? and @game.is_running?
      @current_block.move(0, 0, -2)
    end
    draw
  end
end

class MyTetris < Tetris
  # your enhancements here
  def set_board
    @canvas = TetrisCanvas.new
    @board = MyBoard.new(self)
    @canvas.place(@board.block_size * @board.num_rows + 3,
                  @board.block_size * @board.num_columns + 6, 24, 80)
    @board.draw
  end

  # new key binding events
  def key_bindings
    super
    ## players can press <u> key to make the falling piece rotate 180 degrees
    @root.bind('u', proc { @board.rotate_pi_move })
    ## players can press <c> key to cheat (function defined in MyBoard)
    @root.bind('c', proc { if @board.score >= 50 && !@board.will_cheat
                              @board.will_cheat = true end })
  end
end