class HomeController < ApplicationController

  before_filter :authenticate_user!, only: :test

  def index
  end

  def test

  end
end
