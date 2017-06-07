class Stock < ApplicationRecord

  def self.find_by_ticker(ticker_symbol)
    where(ticker: ticker_symbol).first
  end

  def self.look_up_stock(ticker_symbol)
    look_up = StockQuote::Stock.quote(ticker_symbol)
    return nil unless look_up.name

    stock = Stock.new(ticker: look_up.symbol, name: look_up.name)
    stock.last_price = stock.price
    stock
  end

  def price
    closing_price = StockQuote::Stock.quote(ticker).close
    return "#{closing_price} (Closing)" if closing_price

    opening_price = StockQuote::Stock.quote(ticker).open
    return "#{opening_price} (Opening)" if opening_price

    'Unavaliable'
  end

end
