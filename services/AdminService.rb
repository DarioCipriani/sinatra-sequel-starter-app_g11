require './models/career.rb'
require './models/init.rb'

class AdminService
  
  def self.newCareer(name)

       career = Career.new(name:name)
        return unless career.valid?
       career.save
   
  end

  def self.delete(name)

       career = Career.find(name: name)       
       if !career.nil?
        outcome = Outcome.find(career_id: career.id)
        survey = Survey.find(career_id: career.id)
        if outcome.nil? && survey.nil?
           career.destroy
        end
       end
   
  end
end
