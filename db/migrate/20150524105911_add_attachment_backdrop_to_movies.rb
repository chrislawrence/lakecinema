class AddAttachmentBackdropToMovies < ActiveRecord::Migration
  def self.up
    change_table :movies do |t|
      t.attachment :backdrop
    end
  end

  def self.down
    remove_attachment :movies, :backdrop
  end
end
