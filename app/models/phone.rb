class Phone < ActiveRecord::Base
  belongs_to :owner, polymorphic: true

  validates :number, numericality: true, length: { is: 10 }

  def number=(num)
    super(num.to_s.gsub(/\D/, ''))
  end

  def to_s
    format('(%s) %s-%s', number[0..2], number[3..5], number[6..9])
  end
end
