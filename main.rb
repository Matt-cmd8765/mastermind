require 'colorize'

# player's name, player's guess
class Player
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def guess(array)
    puts 'Have a guess! Pick 4 numbers between 1 and 6'
    counter = 0
    until counter == 4
      num = gets.chomp
      until num.to_i.between?(1,6)
        puts 'Please pick a number between 1 and 6 OR ELSE'
        num = gets.chomp
      end
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

  def white(blacks, whites, master_array, marker_array)
    white_array = whites.uniq
    white_array.each do |num|
      m = master_array.count(num)
      b = blacks.count(num)
      w = whites.count(num)
      if m < w
        result = m - b
        result.times do
          marker_array.push('o'.white.swap)
        end
      elsif w < m
        result = m - w
        result.times do
          marker_array.push('o'.white.swap)
        end
      elsif w == m
        result = w - b
        result.times do
          marker_array.push('o'.white.swap)
        end
      end
    end
  end

  def show_markers(master_array, player_array)
    @marker_array = []
    @blacks = []
    @whites = []
    player_array.each_index do |index|
      if master_array[index] == player_array[index]
        @blacks.push(player_array[index])
        @marker_array.push('o'.black.swap)
      elsif master_array[index] != player_array[index] && master_array.include?(player_array[index])
        @whites.push(player_array[index])
      end
    end
    white(@blacks, @whites, master_array, @marker_array)
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

  def winner?(player_array, master_array)
    player_array == master_array
  end

  def player_guess(player_array, master_array, player)
    count = 0
    name = player.name
    until count == 12
      board = Board.new
      player.guess(player_array)
      guess = player_array.clone
      board.show_board(guess)
      board.show_markers(master_array, player_array)
      if winner?(player_array, master_array)
        puts "#{name} wins!"
        break
      end
      player_array.clear
      count += 1
    end
    if !winner?(player_array, master_array)
      loser_message(master_array)
    end
  end

  def computer_guess(player_array, master_array)
    count = 0
    until count == 12
      board = Board.new
      computer_code(player_array)
      guess = player_array.clone
      board.show_board(guess)
      board.show_markers(master_array, player_array)
      if winner?(player_array, master_array)
        puts 'Computer wins!'
        break
      end
      player_array.clear
      count += 1
    end
    if !winner?(player_array, master_array)
      loser_message(master_array)
    end
  end

  def loser_message(master_array)
    puts 'LOSER! Here was the code:'
    board = Board.new
    board.show_board(master_array)
  end

  def play
    master_array = []
    player_array = []
    puts "Let's play! enter your name"
    name = gets.chomp
    player = Player.new(name)
    puts 'Would you like to be the code master(M) or guesser(G)?'
    choice = gets.chomp
    if choice == 'G'
      computer_code(master_array)
      player_guess(player_array, master_array, player)
    elsif choice == 'M'
      player.guess(master_array)
      computer_guess(player_array, master_array)
    end
  end
end

game = Game.new
game.play
