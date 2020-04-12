class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string  :description
      t.float   :amount
      t.string  :date
      t.integer :list_id
      t.integer :user_id
    end
  end
end