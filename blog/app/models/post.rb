class Post < ApplicationRecord
  belogns_to :user
  belogns_to :company
end
