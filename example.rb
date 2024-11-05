require_relative 'stock'
require_relative 'portfolio'
require 'date'

def format_date(date)
  date.strftime('%d-%m-%Y')
end

# Stocks
stock1 = Stock.new("AAPL", {
  DateTime.parse("2023-01-01") => 150,
  DateTime.parse("2023-02-01") => 155,
  DateTime.parse("2023-03-01") => 160
})

stock2 = Stock.new("GOOGL", {
  DateTime.parse("2023-01-01") => 2800,
  DateTime.parse("2023-02-01") => 2850,
  DateTime.parse("2023-03-01") => 2950
})

# Portfolio
portfolio = Portfolio.new

portfolio.add_stock(stock1, 10.3)
portfolio.add_stock(stock2, 5)
portfolio.add_stock(stock1, 5)

# Dates
start_date = DateTime.parse('2023-01-01')
end_date = DateTime.parse('2023-03-01')

# Results
puts "Profit from #{format_date(start_date)} to #{format_date(end_date)}: $#{portfolio.profit(start_date, end_date)}"
puts "Annualized return from #{format_date(start_date)} to #{format_date(end_date)}: #{portfolio.annualized_return(start_date, end_date).round(4) * 100}%"
