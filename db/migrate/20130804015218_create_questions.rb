class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :name, null: false
      t.string :answer_key, null: false
      t.references :track, null: false, index: true

      t.timestamps
    end
  end
end
