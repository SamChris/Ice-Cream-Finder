class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.text :body,              NULL: false
      t.string :twitter_user_id, NULL: false

      t.timestamps
    end

    add_index :statuses, :twitter_user_id, unique: true


  end
end
