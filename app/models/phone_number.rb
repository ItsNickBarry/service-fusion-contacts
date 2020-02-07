class PhoneNumber < ApplicationRecord
  validates :body, presence: true
  belongs_to :contact
end
