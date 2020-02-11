class PhoneNumber < ApplicationRecord
  validates :body, presence: true, phone: { possible: true }
  belongs_to :contact

  def body= body
    super(Phonelib.parse(body).international)
  end
end
