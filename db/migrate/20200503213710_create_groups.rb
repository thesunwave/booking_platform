class CreateGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :groups do |t|
      t.date :start_date
      t.belongs_to :course

      t.timestamps
    end
  end
end
