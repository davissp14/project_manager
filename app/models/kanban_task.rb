class KanbanTask < ActiveRecord::Base
  belongs_to :project
  belongs_to :kanban

end