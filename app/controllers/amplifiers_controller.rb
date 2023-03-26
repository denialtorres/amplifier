class AmplifiersController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @amplifiers = current_user.amplifiers.order(created_at: :desc)
  end
end
