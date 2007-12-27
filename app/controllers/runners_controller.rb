class RunnersController < ApplicationController

  def index
  end

  def show
    @runner = Runner.find(params[:id])
    @page_title = @runner.name
  end
end
