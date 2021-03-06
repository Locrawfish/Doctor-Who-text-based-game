require_relative '../app/game'
require_relative '../app/player'
require_relative '../app/data'
require 'rspec'
require 'pry'
require 'spec_helper'

describe Game do
  before do
    @game = Game.new
  end

  describe "#get_player_move" do
    context 'user provides move' do
      before { $stdin = StringIO.new("DOwN ") }
      after { $stdin = STDIN } 

      it "downcases and strips the user input" do
        expect(@game).to receive(:check_move).with('down')
        @game.get_player_move
      end
    end
  end

  describe '#get_player_answer' do
    before { $stdin = StringIO.new("DocTor WhO ") }

    after { $stdin = STDIN }

    it 'downcases and strips user input' do
      expect(@game).to receive(:check_answer).with('doctor who')
      @game.get_player_answer
    end
  end

  describe '#print_question' do
    before { $stdin = StringIO.new("up") }
    after { $stdin = STDIN }

    context 'user is by a room with a question' do
      before do
        @game.player.z_coord, @game.player.x_coord, @game.player.y_coord = 0,0,1
      end

      it 'prints the player the room and question they are in' do
        output = "You're in #{@game.player_room.room_number}. Here's your question: #{@game.player_room.question}\n\n"
        expect { @game.print_question }.to output(output).to_stdout
      end
    end

    context "user is by a room that doesn't have a question" do
      before do
        @game.player.z_coord, @game.player.x_coord, @game.player.y_coord = 1,1,1
      end

      it 'does not print question if the room does not have one' do
        output = "You're in #{@game.player_room.room_number}. This room doesn't have a question. Keep going.\n\n"
        expect { @game.print_question }.to output(output).to_stdout
      end
    end
  end

  describe '#play' do
    context 'player reaches the winning room' do
      before do
        $stdin = StringIO.new("forward")
        @game.player.z_coord, @game.player.x_coord, @game.player.y_coord = 0,0,1
      end

      after { $stdin = STDIN }

      it 'changes the players position' do
        @game.play
        expect(@game.player.coordinates).to eq [0,0,2]
      end
    end
  end

  describe "#check_move" do
    context 'user gives actual move' do
      it 'standardizes user input' do
        move = 'down'
        expect(@game).to receive(:give_move_feedback).never
        @game.check_move(move)
      end
    end

    context 'user provides incomplete move' do
      it "returns standardized input" do
        move = "righ"
        expect(@game).to receive(:give_move_feedback).never
        @game.check_move(move)
      end
    end

    context 'user provides an incorrect move' do
      it 'gives user feedback on moves' do
        move = "geronimo"
        expect(@game).to receive(:give_move_feedback).once
        @game.check_move(move)
      end
    end
  end
end
