class Board < ActiveRecord::Base
  belongs_to :kanban
  has_many :cards

end
