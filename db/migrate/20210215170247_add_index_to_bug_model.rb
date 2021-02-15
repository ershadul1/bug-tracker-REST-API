class AddIndexToBugModel < ActiveRecord::Migration[6.0]
  def change
    add_index :bugs, :project_id
    add_index :bugs, :author_id
  end
end
