class Sprint < ActiveRecord::Base
  belongs_to :project
  belongs_to :owner, class_name: "User", foreign_key: :owner_id, primary_key: :id
  
end
