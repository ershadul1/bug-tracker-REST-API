class Addforeignkeytoresolves < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key :resolves, :bugs, dependent: :delete
  end
end
