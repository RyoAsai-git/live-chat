class Message < ApplicationRecord
  belongs_to :user

  validatates :content, presence: true
end
