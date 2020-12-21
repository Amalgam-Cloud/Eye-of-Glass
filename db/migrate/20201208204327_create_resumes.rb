class CreateResumes < ActiveRecord::Migration[6.0]
  def change
    create_table :resumes do |t|
      t.string :name
      t.string :attachment
      t.references :user
      t.string :true_label
      t.string :pred_label

      t.timestamps
    end
  end
end
