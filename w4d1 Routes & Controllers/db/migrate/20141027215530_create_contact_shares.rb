class CreateContactShares < ActiveRecord::Migration
  def change
    create_table :contact_shares do |t|
      t.references :contact, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
