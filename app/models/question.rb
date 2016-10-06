class Question < ApplicationRecord
  belongs_to :user
  # макс длина вопроса 255
  validates :text, :user, length: {maximum: 255}, presence: true
end
