class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :twitter_user_id,       NULL: false
      t.string :twitter_status_id,     NULL: false
      t.string :screen_name,           NULL: false

      t.timestamps
    end

    add_index :users, :twitter_status_id, unique: true
    add_index :users, :twitter_user_id,   unique: true
  end
end
