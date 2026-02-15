class PawnGamesController < ApplicationController
  before_action :set_pawn_game

  def show; end # @game already available

  def update
    PawnGameService.new(@game).run(params[:commands])

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to root_path }
    end
  end

  def reset
    @game.reset!

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to root_path }
    end
  end

  private

  def set_pawn_game
    @game = PawnGame.first_or_create!
  end
end
