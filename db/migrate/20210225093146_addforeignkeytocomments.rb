class Addforeignkeytocomments < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key :comments, :bugs, dependent: :delete
  end
end
