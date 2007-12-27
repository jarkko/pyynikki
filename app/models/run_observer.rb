class RunObserver < ActiveRecord::Observer
  def before_save(run)
    run.age_class = run.runner.age_class_with_gender(run.event.event_date)
  end
end
