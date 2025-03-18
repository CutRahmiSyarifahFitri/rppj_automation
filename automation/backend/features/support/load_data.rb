# Handle load data
class LoadData
  p 'call load_data.rb'
  def login_requirement
    @login_requirement ||= LoginRequirement.new
  end
end
