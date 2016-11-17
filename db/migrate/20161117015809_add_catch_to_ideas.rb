class AddCatchToIdeas < ActiveRecord::Migration[5.0]
  def change
    add_column :ideas, :catch, :string
  end
end
