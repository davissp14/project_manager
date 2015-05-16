class Account < ActiveRecord::Base
  belongs_to :owner, class_name: "User", foreign_key: :owner_id, primary_key: :id
  has_many :users
  has_many :projects

end
