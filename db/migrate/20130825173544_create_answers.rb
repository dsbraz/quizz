class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.string :json_value, null: false
      t.references :question, null: false, index: true
      t.references :player, null: false, index: true

      t.timestamps
    end
  end
end
