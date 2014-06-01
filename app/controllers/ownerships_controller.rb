class OwnershipsController < ApplicationController
  before_action :authenticate_user!

  def create
    @game = Game.find(params[:ownership][:owned_id])
    current_user.add_to_library!(@game)
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end

  def destroy
    @game = Ownership.find(params[:id]).owned
    current_user.remove_from_library!(@game)
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end
end
