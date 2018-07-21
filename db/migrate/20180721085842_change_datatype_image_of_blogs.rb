class ChangeDatatypeImageOfBlogs < ActiveRecord::Migration[5.1]
  def change
    change_column :blogs, :image, :string
  end
end
