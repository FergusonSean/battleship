class BattleshipController < ApplicationController
  def index
    Ship.setup_game_if_necessary
  end

  def fire
    shot_params = params.require(:shot).permit(:x,:y, :player)

    shot_params[:result] = Ship.hit?(shot_params[:player].to_i, shot_params[:x].to_i, shot_params[:y].to_i) ? "hit" : "miss"

    Shot.create(shot_params)
    render json: shot_params
  end

  def last_shot
    render json: Shot.where(player: params[:player]).last
  end
end
