class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.references :postable, polymorphic: true, index: true
      t.timestamps
    end
  end
end
