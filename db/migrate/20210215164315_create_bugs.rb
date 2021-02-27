class CreateBugs < ActiveRecord::Migration[6.0]
  def change
    create_table :bugs do |t|
      t.integer :project_id
      t.integer :author_id
      t.string :title
      t.text :description
      t.string :priority, :default => 'medium'
      t.string :status, :default => 'open'

      t.timestamps
    end
  end
end
