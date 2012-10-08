# == Schema Information
#
# Table name: events
#
#  id                     :integer          not null, primary key
#  group_id               :integer          not null
#  type                   :string(255)      not null
#  name                   :string(255)      not null
#  number                 :string(255)
#  motto                  :string(255)
#  cost                   :string(255)
#  maximum_participants   :integer
#  contact_id             :integer
#  description            :text
#  location               :text
#  application_opening_at :date
#  application_closing_at :date
#  application_conditions :text
#  event_kind_id          :integer
#  state                  :string(60)
#  priorization           :boolean          default(FALSE), not null
#  requires_approval      :boolean          default(FALSE), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class Event::Course < Event
  
  # This statement is required because this class would not be loaded otherwise.
  require_relative 'course/participation/participant'
  
  self.participation_types = [Event::Participation::Leader,
                              Event::Participation::AssistantLeader,
                              Event::Participation::Cook,
                              Event::Participation::Treasurer,
                              Event::Participation::Speaker,
                              Event::Course::Participation::Participant]
  self.participant_type = Event::Course::Participation::Participant
  
  attr_accessible :kind_id, :state, :priorization, :requires_approval


  def build_application_for(user)
    appl = Application.new
    appl.priority_1 = self
    appl.participation.person = user
    appl
  end
end