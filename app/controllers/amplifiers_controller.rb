class AmplifiersController < ApplicationController
  before_action :authenticate_user!

  def index
    @amplifiers = current_user.amplifiers.order(created_at: :desc)
    @pagy, @amplifiers = pagy(@amplifiers)
  end

  def new
    @amplifier = current_user.amplifiers.build
  end
end
