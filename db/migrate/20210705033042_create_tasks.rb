class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.string :name
      t.references :task_list, null: false, foreign_key: true
      t.references :event, null: true, foreign_key: true
      t.datetime :completed_at, null: true
      t.datetime :due_date, null: true
      t.text :notes, null: true

      t.timestamps
    end
  end
end
