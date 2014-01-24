require 'mongoid'
require_relative 'fund'

module Pioneer
  module Model
    class Item
      include Mongoid::Document

      field :date, type: Date
      field :value, type: BigDecimal
      
      belongs_to :fund, class_name: 'Pioneer::Model::Fund'

      validates :date, presence: true, uniqueness: {scope: :fund_id}
    end
  end
end
