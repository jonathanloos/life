class AddFieldsToTasks < ActiveRecord::Migration[6.1]
  def change
      add_column :tasks, :completed_at, :datetime, default: nil
      add_column :tasks, :due_date, :datetime, default: nil
      add_column :tasks, :notes, :string, default: nil

      add_reference :tasks, :event, foreign_key: true
  end
end
