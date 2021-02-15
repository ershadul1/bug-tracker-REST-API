class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.text :content
      t.integer :bug_id
      t.integer :user_id

      t.timestamps
    end
    add_index :comments, :bug_id
    add_index :comments, :user_id
  end
end
