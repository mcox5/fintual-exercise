require 'rspec'
require_relative '../portfolio'
require_relative '../stock'
require 'date'

RSpec.describe Portfolio do
  let(:stock1) do
    Stock.new("AAPL", {
      DateTime.parse("2023-01-01") => 150,
      DateTime.parse("2023-02-01") => 155,
      DateTime.parse("2023-03-01") => 160
    })
  end

  let(:stock2) do
    Stock.new("GOOGL", {
      DateTime.parse("2023-01-01") => 2800,
      DateTime.parse("2023-02-01") => 2850,
      DateTime.parse("2023-03-01") => 2900
    })
  end

  let(:portfolio) { Portfolio.new }

  describe '#add_stock' do
    it 'adds a stock to the portfolio' do
      portfolio.add_stock(stock1, 10)
      expect(portfolio.instance_variable_get(:@holdings)[stock1.name]).to eq(10)
    end

    it 'increments the quantity if the stock already exists in the portfolio' do
      portfolio.add_stock(stock1, 10)
      portfolio.add_stock(stock1, 5)
      expect(portfolio.instance_variable_get(:@holdings)[stock1.name]).to eq(15)
    end
  end

  describe '#profit' do
    before do
      portfolio.add_stock(stock1, 10)
      portfolio.add_stock(stock2, 5)
    end

    it 'calculates the profit between two dates' do
      start_date = DateTime.parse("2023-01-01")
      end_date = DateTime.parse("2023-03-01")
      expect(portfolio.profit(start_date, end_date)).to eq(10 * (160 - 150) + 5 * (2900 - 2800))
    end
  end

  describe '#annualized_return' do
    before do
      portfolio.add_stock(stock1, 10)
      portfolio.add_stock(stock2, 5)
    end

    it 'calculates the annualized return between two dates' do
      start_date = DateTime.parse("2023-01-01")
      end_date = DateTime.parse("2023-03-01")
      profit = portfolio.profit(start_date, end_date)
      start_value = portfolio.send(:calculate_portfolio_value, start_date)
      end_value = start_value + profit
      total_return = end_value.to_f / start_value
      days = (end_date - start_date).to_i
      years = days / 365.25
      expected_annualized_return = (total_return**(1 / years) - 1)
      expect(portfolio.annualized_return(start_date, end_date)).to be_within(0.0001).of(expected_annualized_return)
    end

    context 'when the start date is greater than the end date' do
      it 'raises an error' do
        start_date = DateTime.parse("2023-03-01")
        end_date = DateTime.parse("2023-01-01")
        expect { portfolio.annualized_return(start_date, end_date) }.to raise_error("End date can not be lower or the same than start date")
      end
    end

    context 'when the initial value of the portfolio is zero' do
      it 'raises an error' do
        start_date = DateTime.parse("2023-01-01")
        end_date = DateTime.parse("2023-03-01")
        portfolio.instance_variable_set(:@stocks, [])
        expect { portfolio.annualized_return(start_date, end_date) }.to raise_error("The initial value of the portfolio is zero, the annualized return cannot be calculated.")
      end
    end
  end
end
