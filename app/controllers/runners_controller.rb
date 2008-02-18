class RunnersController < ApplicationController
  def index
  end

  def show
    @runner = Runner.find(params[:id])
    @recent = @runner.runs.find_recent
    @page_title = @runner.name
    @breadcrumbs << {:url => runner_path(@runner), :title => @runner.name}
  end
  
  def index
    @runners = Runner.find(:all, :order => "last_name, first_name").group_by do |runner|
      runner.last_name.first
    end
  end
end
