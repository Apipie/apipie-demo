class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.integer :user_id
      t.text :text
      t.datetime :scheduled_at
      t.boolean :sent

      t.timestamps
    end
  end
end
