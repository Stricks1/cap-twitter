class AddIndexToOpinions < ActiveRecord::Migration[5.2]
  def change
    add_index :opinions, :user_id
    add_index :opinions, :copied_id
  end
end
