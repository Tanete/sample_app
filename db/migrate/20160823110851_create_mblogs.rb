class CreateMblogs < ActiveRecord::Migration[5.0]
  def change
    create_table :mblogs do |t|
      t.string :mid
      t.datetime :created_timestamp
      t.text :content
      t.string :source
      t.string :user_id
      t.string :user_name
      t.string :user_gender
      t.integer :user_status_count
      t.integer :user_fansNum

      t.timestamps
    end
  end
end
