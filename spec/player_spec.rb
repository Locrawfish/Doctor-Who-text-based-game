require_relative '../app/player'
require_relative '../app/room'
require_relative '../app/game'
require 'rspec'
require 'pry'
require 'spec_helper'

describe Player do
  before do
    @player= Player.new
  end

  describe '#move' do
    context 'standardized_move is forward' do
      before { @move = 'forward' }

      context 'a player can move forward' do
        it 'changes players y_coord by +1' do
          @player.y_coord = 0
          @player.move(@move)

          expect(@player.y_coord).to eq 1
        end
      end

      context 'a player cannot move forward' do
        it 'does not change players y_coord' do
          @player.y_coord = 2
          @player.move(@move)

          expect(@player.y_coord).to eq 2
        end
      end
    end

    context 'standardized_move is backward' do
      before { @move = 'backward' }

      context 'a player can move backward' do
        it 'changes players y_coord by -1' do
          @player.y_coord = 1
          @player.move(@move)

          expect(@player.y_coord).to eq 0
        end
      end

      context 'a player cannot move backward' do
        it 'does not change players y_coord' do
          @player.y_coord = 0
          @player.move(@move)

          expect(@player.y_coord).to eq 0
        end
      end
    end

    context 'standardized_move is right' do
      before { @move = 'right' }

      context 'a player can move right' do
        it 'changes players x_coord by 1' do
          @player.x_coord = 1
          @player.move(@move)

          expect(@player.x_coord).to eq 2
        end
      end

      context 'a player cannot move right' do
        it 'does not change players x_coord' do
          @player.x_coord = 2
          @player.move(@move)

          expect(@player.x_coord).to eq 2
        end
      end
    end

    context 'standardized_move is left' do
      before { @move = 'left' }

      context 'a player can move left' do
        it 'changes players x_coord by -1' do
          @player.x_coord = 1
          @player.move(@move)

          expect(@player.x_coord).to eq 0
        end
      end

      context 'a player cannot move left' do
        it 'does not change players x_coord' do
          @player.x_coord = 0
          @player.move(@move)

          expect(@player.x_coord).to eq 0
        end
      end
    end

    context 'standardized_move is up' do
      before { @move = 'up' }

      context 'a player can move up a floor' do
        it 'changes players z_coord by +1' do
          @player.z_coord = 0
          @player.move(@move)

          expect(@player.z_coord).to eq 1
        end
      end

      context 'a player cannot move up a floor' do
        it 'does not change players z_coord' do
          @player.z_coord = 2
          @player.move(@move)

          expect(@player.z_coord).to eq 2
        end
      end
    end

    context 'standardized_move is down' do
      before { @move = 'down' }

      context 'a player can move down a floor' do
        it 'changes players z_coord by -1' do
          @player.z_coord = 2
          @player.move(@move)

          expect(@player.z_coord).to eq 1
        end
      end

      context 'a player cannot move down a floor' do
        it 'does not change players z_coord' do
          @player.z_coord = 0
          @player.move(@move)

          expect(@player.z_coord).to eq 0
        end
      end
    end
  end
end
