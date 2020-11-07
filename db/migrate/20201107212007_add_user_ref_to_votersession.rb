class AddUserRefToVotersession < ActiveRecord::Migration[6.0]
  def change
    add_reference :votersessions, :user, null: true, foreign_key: true
  end
end
