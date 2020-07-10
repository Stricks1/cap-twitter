class AddCopiedIdToOpinions < ActiveRecord::Migration[5.2]
  def change
    add_column :opinions, :copied_id, :integer
  end
end
