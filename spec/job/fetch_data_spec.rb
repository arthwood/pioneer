require 'spec_helper'
require './job/fetch_data'

module Pioneer
  describe Job::FetchData do
    describe '#work' do
      let(:content) { double }
      let(:file) { double(read: content) }
      let(:rows) do
        [
          %w(head fund_1 fund_2),
          %w(2013-04-05 bd 23.98),
          %w(2013-04-06 102 24.02),
          %w(2013-04-09 108 24.13),
        ]
      end
      
      before do
        subject.stub(open: file)
        CSV.stub(parse: rows)
        Model::Fund.delete_all
        Model::Item.delete_all
      end
      
      it 'should insert data' do
        subject.work
        
        funds = Model::Fund.all
        expect(funds.count).to eq(2)
        expect(Model::Item.count).to eq(6)
        expect(funds[0].items.first.value).to be_nil
        expect(funds[1].items.first.value).to eq(23.98)
      end
    end
  end
end
