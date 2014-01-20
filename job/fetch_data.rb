require 'open-uri'
require 'csv'
require './model/fund'

module Pioneer
  module Job
    class FetchData
      def work
        content = open('http://www.pioneer.com.pl/pioneer/funds.csv').read
        
        rows = CSV.parse(content, col_sep: ';')
        
        header = rows.shift
        header.shift
        fund_names = header
        cols = rows.transpose
        dates = cols.shift
        
        Pioneer::Model::Fund.delete_all
        Pioneer::Model::Item.delete_all
        
        fund_names.each_with_index do |name, idx|
          name = name.encode('utf-8', 'iso-8859-2')
          fund = Pioneer::Model::Fund.create(name: name)
          p name
          cols[idx] = cols[idx].map { |i| i == 'bd' ? nil : i }

          Pioneer::Model::Item.create(
            dates.zip(cols[idx]).map do |date, value|
              {fund_id: fund.id, date: date, value: value && value.gsub(',', '.')}
            end
          )
        end
      end
    end
  end
end
