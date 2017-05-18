module Searchable
  extend ActiveSupport::Concern

  attr_accessor :limit, :offset

  included do
    belongs_to :mls_server
    belongs_to :profile
    validates :mls_server, presence: true
  end

  def results
    query.order(order).limit(limit).offset(offset)
  end

  def total_results
    query.count
  end

  def next_page_offset
    offset.to_i + limit.to_i
  end

  def more?
    next_page_offset < total_results
  end

  def limit
    @limit ||= 12
  end

  def offset
    @offset ||= 0
  end
end
