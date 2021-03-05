class RemoveBoookIdFromBookComments < ActiveRecord::Migration[5.2]
  def change
    remove_column :book_comments, :boook_id, :integer
  end
end
