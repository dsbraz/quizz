class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :username, null: false, uniqueness: true
      t.string :password_digest, null: false

      t.timestamps
    end
  end
end
