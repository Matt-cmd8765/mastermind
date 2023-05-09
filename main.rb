require 'colorize'

# player's name, player's guess
class Player
  attr_reader :name, :array

  def initialize(name)
    @name = name
  end

  def guess(array)
    puts 'Have a guess!'
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

  def show_markers(comp_array, player_array)
    @marker_array = []
    player_array.each_index do |index|
      if comp_array[index] == player_array[index]
        @marker_array.push('o'.black.swap)
      elsif comp_array.include?(player_array[index]) && comp_array[index] != player_array[index]
        @marker_array.push('o'.white.swap)
      end
    end
    puts '------------------'
    puts "#{@marker_array[0]} #{@marker_array[1]}"
    puts "#{@marker_array[2]} #{@marker_array[3]}"
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

  def winner?(player_array, comp_array)
    player_array == comp_array
  end

  def player_guess(player_array, comp_array, player)
    count = 0
    name = player.name
    until count == 12
      board = Board.new
      player.guess(player_array)
      guess = player_array.clone
      p player_array
      board.show_board(guess)
      board.show_markers(comp_array, player_array)
      if winner?(player_array, comp_array)
        puts "#{name} wins!"
        break
      end
      player_array.clear
      count += 1
    end
  end

  def loser_message(comp_array)
    puts 'LOSER! Here was the code:'
    board = Board.new
    board.show_board(comp_array)
  end

  def play
    comp_array = []
    player_array = []
    puts "Let's play! enter your name"
    name = gets.chomp
    player = Player.new(name)
    computer_code(comp_array)
    player_guess(player_array, comp_array, player)
    loser_message(comp_array)
  end
end

game = Game.new
game.play
