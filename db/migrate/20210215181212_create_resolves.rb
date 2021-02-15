class CreateResolves < ActiveRecord::Migration[6.0]
  def change
    create_table :resolves do |t|
      t.integer :bug_id
      t.integer :user_id

      t.timestamps
    end
    add_index :resolves, :bug_id
    add_index :resolves, :user_id
  end
end
