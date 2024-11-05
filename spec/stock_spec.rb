require 'rspec'
require_relative '../stock'
require 'date'

RSpec.describe Stock do
  let(:prices) do
    {
      DateTime.parse("2023-01-01") => 150,
      DateTime.parse("2023-02-01") => 155,
      DateTime.parse("2023-03-01") => 160
    }
  end

  let(:stock) { Stock.new("AAPL", prices) }

  describe '#initialize' do
    it 'initializes with a name and prices' do
      expect(stock.name).to eq("AAPL")
      expect(stock.instance_variable_get(:@prices)).to eq(prices)
    end
  end

  describe '#price' do
    context 'when the exact date is available' do
      it 'returns the price for a given date' do
        expect(stock.price(DateTime.parse("2023-01-01"))).to eq(150)
        expect(stock.price(DateTime.parse("2023-02-01"))).to eq(155)
        expect(stock.price(DateTime.parse("2023-03-01"))).to eq(160)
      end
    end

    context 'when the exact date is not available' do
      it 'returns the closest price for a date if exact date is not available' do
        expect(stock.price(DateTime.parse("2023-01-15"))).to eq(150)
        expect(stock.price(DateTime.parse("2023-02-15"))).to eq(155)
        expect(stock.price(DateTime.parse("2023-03-15"))).to eq(160)
      end
    end

    context 'when is no record for the date' do
      it 'raises an error if no price is found before the date input' do
        expect { stock.price(DateTime.parse("2022-12-31")) }.to raise_error("Price not found for date 31-12-2022")
      end
    end
  end
end
