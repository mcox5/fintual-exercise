class Stock
  attr_reader :name

  def initialize(name, prices)
    @name = name
    @prices = prices # Hash { date => price }
  end

  def price(date)
    valid_dates = @prices.keys.select { |d| d <= date }

    closest_date = valid_dates.max
    raise "Price not found for date #{date.strftime('%d-%m-%Y')}" unless closest_date

    @prices[closest_date]
  end
end
