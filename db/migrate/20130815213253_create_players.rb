class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :username, null: false, uniqueness: true, index: true
      t.string :password_digest, null: false
      t.string :avatar
      t.references :team, null: false, index: true

      t.timestamps
    end
  end
end
