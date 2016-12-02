class CreateTweets < ActiveRecord::Migration[5.0]
  def change
    create_table :tweets do |t|
      t.string :tweet
      t.string :picture
      t.references :user, tweet:true, foreign_key: { on_delete: :cascade}, nill: false
      t.timestamps null: false
    end
  end
end
