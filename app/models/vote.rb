class Vote < ActiveRecord::Base
  TYPE_MAP = ["up"]

  belongs_to :question
  
  def type
    TYPE_MAP[type_key]
  end
end