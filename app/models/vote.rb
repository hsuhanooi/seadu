class Vote < ActiveRecord::Base
  belongs_to :question
end