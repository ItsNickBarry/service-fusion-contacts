class Email < ApplicationRecord
  validates :body, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  belongs_to :contact
end
