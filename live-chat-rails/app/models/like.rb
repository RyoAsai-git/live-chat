class Like < ApplicationRecord
  t.references :user
  t.references :message

  belongs_to :user
  belongs_to :message
end
