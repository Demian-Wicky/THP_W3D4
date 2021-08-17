require 'nokogiri'
require 'httparty'

def get_urls # gets the url of each city and returns them in an array
  url = 'http://annuaire-des-mairies.com/val-d-oise.html'
  unparsed_page = HTTParty.get(url)
  parsed_page = Nokogiri::HTML(unparsed_page.body)
  city_urls = []
  city_listings = parsed_page.css('a.lientxt') #city_listings.count => 185 | we get an array af 185 elements
  city_listings.each do |city_listing|
    url = "http://annuaire-des-mairies.com" + (city_listing.attributes["href"].value)[1..-1]
    city_urls << url
  end
  return city_urls
end

def mairie_xmas
  city_names_and_emails = []
  city_urls = get_urls
  nb_of_cities = city_urls.size
  city_urls.each_with_index do |city_url , index|
    url = city_url
    unparsed_page = HTTParty.get(url)
    parsed_page = Nokogiri::HTML(unparsed_page.body)
    name_and_email = {
      url[35..-6].upcase => #name
      parsed_page.css('tbody')[0].css('td')[7].text #email
    }
    city_names_and_emails << name_and_email
    system ('clear')
    puts ("▓" * (((index+1)*50)/nb_of_cities) + "░" * 50)[0..49] + "  #{(((index+1)*100)/nb_of_cities.to_f).round(1)} %"
  end
  return city_names_and_emails
end


print mairie_xmas