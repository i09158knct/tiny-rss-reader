class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.string :title
      t.string :url
      t.text :summary
      t.text :content
      t.datetime :published_at
      t.boolean :unread
      t.integer :feed_id

      t.timestamps
    end
  end
end
