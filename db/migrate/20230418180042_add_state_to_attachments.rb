class AddStateToAttachments < ActiveRecord::Migration[7.0]
  def change
    add_column :attachments, :state, :integer
  end
end
