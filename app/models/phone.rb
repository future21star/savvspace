class Phone < ActiveRecord::Base
  belongs_to :owner, polymorphic: true

  validates :number, numericality: true, length: { is: 10 }

  def number=(num)
    super(num.to_s.gsub(/\D/, ''))
  end
end
