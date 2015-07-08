class Board < ActiveRecord::Base
  belongs_to :kanban
  has_many :cards, -> { order('created_at') }

  default_scope { order('created_at') } 

end
