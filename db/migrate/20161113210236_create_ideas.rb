class CreateIdeas < ActiveRecord::Migration[5.0]
  def change
    create_table :ideas do |t|
      t.references :user, index: true, foreign_key: true
      t.string :idea_name
      t.text :content
      t.text :purpose
      t.text :remark
      t.string :picture

      t.timestamps
      t.index [:user_id, :created_at]
    end
  end
end
