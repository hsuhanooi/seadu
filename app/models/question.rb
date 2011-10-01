class Question < ActiveRecord::Base
  STATUS_MAP = ["new", "done"]
  
  belongs_to :room_id
  
  def status
    STATUS_MAP[status_key]
  end
end