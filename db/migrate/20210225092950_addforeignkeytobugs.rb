class Addforeignkeytobugs < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key :bugs, :projects, dependent: :delete
  end
end
