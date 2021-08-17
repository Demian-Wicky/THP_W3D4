require 'nokogiri'
require 'httparty'

### USED TO WORK A FEW WEEKS AGO. ISSUE WITH LAZY LOADING ?

def dark_trader

  url = 'https://coinmarketcap.com/all/views/all/'
  unparsed_page = HTTParty.get(url)
  parsed_page = Nokogiri::HTML(unparsed_page.body)
  cryptos = []
  crypto_listings = parsed_page.css('tr.cmc-table-row') #crypto_listings.count => 200 | we get an array af 200 elements
  crypto_listings.each do |crypto_listing|
    crypto = {
      crypto_listing.css('a.cmc-table__column-name--symbol').text =>
      crypto_listing.css('td.cmc-table__cell--sort-by__price').text.gsub('$','').gsub(',', '').to_f
    }
    cryptos << crypto
  end
  return cryptos
end

print dark_trader