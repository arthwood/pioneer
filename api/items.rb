require './model/fund'

module Pioneer
  module Api
    class Items
      def get(id)
        Pioneer::Model::Fund.find(id).items
      end
    end
  end
end
