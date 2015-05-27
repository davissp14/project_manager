class Card < ActiveRecord::Base
  belongs_to :board
  belongs_to :kanban

end
