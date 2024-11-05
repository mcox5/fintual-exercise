# Fintual Exercise

This repository contains an exercise where a simple portfolio with stocks is constructed, and the **profit** and **annualized return** between two given dates are calculated.

## Table of Contents

- [Setup](#setup)
- [How to Run the Tests](#how-to-run-the-tests)
- [How to Run the Example](#how-to-run-the-example)
- [Project Structure](#project-structure)
- [Contact](#contact)

## Setup

Before running the code, please ensure you have the following:

- **Ruby Version**: 3.2.3 (verify your current version with `ruby -v`).
- **Required Gems**:
  - [`rspec`](https://rspec.info/) (for unit testing): Install with `$ gem install rspec`.

## How to Run the Tests

From main folder `$ rspec spec` to run unit test of `stock` and `portfolio`

## How to Run the Example

From main folder `$ ruby example.rb`

## Project Structure

The project is organized as follows:

### `stock.rb`
The `Stock` class represents a stock and includes the following components:

#### Initialization

To create a Stock instance, you need to provide the name and a hash of historical prices.

```ruby
stock = Stock.new("AAPL", {
  Date.parse("2023-01-01") => 150,
  Date.parse("2023-02-01") => 155,
  Date.parse("2023-03-01") => 160
})
```

#### Methods
`price(date)`: Returns the price of the stock on a given date.
Assumptions:
- If the date is in the future or there is no data for that date, the assumptions is to get the closer date before
- If the date is before the first price record it will raise error.
- If the date is between two records, it will take the first record from the buttom.

### `portfolio.rb`
The Portfolio class represents the investment portfolio and includes the following components:

#### Initialization

Creates an empty portfolio.

```ruby
portfolio = Portfolio.new
```
#### Methods
- `add_stock(stock, quantity)`: Adds a specific quantity of a stock to the portfolio. If the stock already exists, it increments the quantity.

```ruby
portfolio.add_stock(stock_name, quantity)
portfolio.add_stock('GOOGL', 10000)
```
- `profit(start_date, end_date)`: Calculates the total profit of the portfolio between two dates.
```ruby
portfolio.profit(start_date, end_date)
```

- `annualized_return(start_date, end_date)`: Calculates the annualized return of the portfolio between two dates.

```ruby
annualized_return = portfolio.annualized_return(start_date, end_date)
```

The steps to calulate the annualized return were:
1. **Calculate Total Return**
```ruby
total_return = portfolio_value(end_date) / portfolio_value(start_date)
```

2. **Calculate Number between start date and end date**
```ruby
number_of_days = (end_date - start_date)
```

3. **Convert days to years**
(we use 365.25 to include leap year each 4 years )
```ruby
number_of_years = number_days / 365.25
```

4. **Get annualized return**
```ruby
annualized_return = (total_return^(1 / years) - 1)
```

### `example.rb`
This script contains a practical example of how to use the Stock and Portfolio classes. It includes creating stocks with historical prices, building the portfolio, and executing the calculation methods.

### `spec/`
This folder contains the unit tests written with RSpec for the Stock and Portfolio classes.

## Contact

For any questions or comments, please contact me[matiascoxed@gmail.com]:
