require 'colorize'

# player's name, player's guess
class Player
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def guess(array)
    puts 'Make your guess fuck-boy!'
    counter = 0
    until counter == 4
      num = gets.chomp
      array.push(num.to_i)
      counter += 1
    end
  end
end

# Stores the game pieces. display the board
class Board
  def make_pieces(piece)
    case piece
    when 1
      '1'.red.swap
    when 2
      '2'.blue.swap
    when 3
      '3'.green.swap
    when 4
      '4'.yellow.swap
    when 5 
      '5'.cyan.swap
    when 6 
      '6'.magenta.swap
    end
  end

  def show_board(array)
    # change the color of the ints into pieces
    array.map! do |piece|
      make_pieces(piece)
    end
    puts '------------------'
    puts "#{array[0]} #{array[1]} #{array[2]} #{array[3]}" 
    puts '------------------'
  end
end

# Play the game. Get the guesses from the play and see if it matches the code. Provide markers
class Game
  
  def computer_code(array)
    counter = 0
    until counter == 4
      num = rand(1..6)
      array.push(num)
      counter += 1
    end
  end

  def player_guess(array)
    player.guess(array)
    board.show_board(array)
  end

  def play
    puts "Let's play! enter your name"
    name = gets.chomp
    player = Player.new(name)
    board = Board.new
    comp_array = []
    player_array = []
    self.computer_code(comp_array)
    player.guess(player_array)
    board.show_board(player_array)
  end
end

game = Game.new
game.play


# array = [1,2,3,4,5]

# board = Board.new
# board.show_board(array)