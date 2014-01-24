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
        dates = cols.shift.map {|i| Date.parse(i)}
        
        fund_names.each_with_index do |name, idx|
          name = name.encode('utf-8', 'iso-8859-2')
          fund = Pioneer::Model::Fund.find_or_create_by(name: name)
          p name
          
          cols[idx] = cols[idx].map { |i| i == 'bd' ? nil : i }
          data_set = dates.zip(cols[idx])
          last_item = fund.items.last
          last_date = last_item && last_item.date
          data_set = data_set.select {|date, value| last_date.nil? || date > last_date}
          data_set.map do |date, value|
            fund.items.create(date: date, value: value && value.gsub(',', '.'))
          end
        end
      end
    end
  end
end
