require 'mongoid'
require_relative 'item'

module Pioneer
  module Model
    class Fund
      include Mongoid::Document
      
      field :name, type: String
      
      has_many :items, class_name: 'Pioneer::Model::Item', order: 'DATE ascending'

      validates :name, presence: true, uniqueness: true
    end
  end
end
