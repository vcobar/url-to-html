class Job < ActiveRecord::Base
  after_initialize :default_values


  private
    def default_values
      self.completed ||= false
    end
end
