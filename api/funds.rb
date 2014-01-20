require './model/fund'

module Pioneer
  module Api
    class Funds
      def get
        Pioneer::Model::Fund.all
      end
    end
  end
end
