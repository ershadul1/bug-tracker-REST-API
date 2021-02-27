class Addforeignkeytoassigns < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key :assigns, :bugs, dependent: :delete
  end
end
