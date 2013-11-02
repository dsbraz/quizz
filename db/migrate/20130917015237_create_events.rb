class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.references :player, null: false, index: true
      t.string :controller, null: false
      t.string :action, null: false
      t.string :session, null: false
      t.text   :opt

      t.timestamps
    end
  end
end
