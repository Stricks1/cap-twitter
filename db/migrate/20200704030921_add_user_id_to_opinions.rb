class AddUserIdToOpinions < ActiveRecord::Migration[5.2]
  def change
    add_column :opinions, :user_id, :integer
  end
end
