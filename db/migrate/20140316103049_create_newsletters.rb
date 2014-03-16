class CreateNewsletters < ActiveRecord::Migration
  def change
    create_table :newsletters do |t|
      t.string :subject
      t.string :introduction
      t.string :body
      t.integer :campaign_id
      t.integer :week_id

      t.timestamps
    end
  end
end
