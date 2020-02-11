class Contact < ApplicationRecord
  validates :first_name, :last_name, :date_of_birth, presence: true
  validates :first_name, uniqueness: { scope: :last_name, message: 'must be unique within the scope of last name' }

  validate :has_at_least_one_email
  validate :has_at_least_one_phone_number

  has_many :addresses, dependent: :destroy
  has_many :emails, dependent: :destroy
  has_many :phone_numbers, dependent: :destroy

  accepts_nested_attributes_for :addresses, allow_destroy: true
  accepts_nested_attributes_for :emails, allow_destroy: true
  accepts_nested_attributes_for :phone_numbers, allow_destroy: true

   private

    def has_at_least_one_email
      if emails.empty?
        errors.add(:emails, 'must be present (one or more)')
      end
    end

    def has_at_least_one_phone_number
      if phone_numbers.empty?
        errors.add(:phone_numbers, 'must be present (one or more)')
      end
    end
end
