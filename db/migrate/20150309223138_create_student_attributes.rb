class CreateStudentAttributes < ActiveRecord::Migration
  def change
    create_table :student_attributes do |t|

      t.timestamps null: false
      t.belongs_to :requirement_subcategory, index: true
      t.belongs_to :user, index: true

      t.string :value_array, array: true, :null => true
      t.string :value, :null => true

    end
  end
end
