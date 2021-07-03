class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.references :user, null: false, foreign_key: true
      t.datetime :start_date
      t.string :name
      t.datetime :end_date

      t.timestamps
    end
  end
end
