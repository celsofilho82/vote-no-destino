class CreateVotersessions < ActiveRecord::Migration[6.0]
  def change
    create_table :votersessions do |t|
      t.string :session_id

      t.timestamps
    end
  end
end
