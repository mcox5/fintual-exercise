require_relative 'stock'

class Portfolio
  def initialize
    @stocks = []
    @holdings = {} # { stock_name(string) => quantity(float | integer) }
  end

  def add_stock(stock, quantity)
    if @holdings.key?(stock.name)
      @holdings[stock.name] += quantity
    else
      @stocks << stock
      @holdings[stock.name] = quantity
    end
  end

  def profit(start_date, end_date)
    start_value, end_value = [0.0] * 2

    @stocks.each do |stock|
      quantity = @holdings[stock.name]
      start_price = stock.price(start_date)
      end_price = stock.price(end_date)

      start_value += start_price * quantity
      end_value += end_price * quantity
    end

    end_value - start_value
  end

  def annualized_return(start_date, end_date)
    raise "End date can not be lower or the same than start date" if start_date >= end_date

    start_value = calculate_portfolio_value(start_date)
    end_value = calculate_portfolio_value(end_date)

    raise "The initial value of the portfolio is zero, the annualized return cannot be calculated." if start_value.zero?

    total_return = (end_value.to_f / start_value)
    days = (end_date - start_date).to_i
    years = days / 365.25
    (total_return**(1 / years) - 1)
  end

  private

  def calculate_portfolio_value(date)
    @stocks.reduce(0) do |sum, stock|
      quantity = @holdings[stock.name]
      price = stock.price(date)
      sum + price * quantity
    end
  end
end
