class CreateAssigns < ActiveRecord::Migration[6.0]
  def change
    create_table :assigns do |t|
      t.integer :bug_id
      t.integer :user_id

      t.timestamps
    end
    add_index :assigns, :bug_id
    add_index :assigns, :user_id
  end
end
