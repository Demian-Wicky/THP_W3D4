require 'nokogiri'
require 'httparty'

def get_urls
  url = 'https://www.nosdeputes.fr/deputes'
  unparsed_page = HTTParty.get(url)
  parsed_page = Nokogiri::HTML(unparsed_page.body)
  a = []

  former_deputy_listings = parsed_page.css('div.anciens').css('span.list_nom') # anciens députés
  all_deputy_listings = parsed_page.css('div.list_dep').css('span.list_nom') # tous les députés
  deputy_listings = all_deputy_listings - former_deputy_listings # députés actuels

  deputy_listings.each do |deputy_listing|
    first_name = deputy_listing.text.strip.split(', ')[1]
    last_name = deputy_listing.text.strip.split(', ')[0]
    #https://stackoverflow.com/questions/15686752/ruby-method-to-remove-accents-from-utf-8-international-characters
    email = "#{last_name.downcase}.#{first_name.downcase}@assemblee-nationale.fr".tr("ÀÁÂÃÄÅàáâãäåĀāĂăĄąạảÇçĆćĈĉĊċČčÐðĎďĐđÈÉÊËèéêểệễëĒēĔĕĖėĘęĚěẹĜĝĞğĠġĢģĤĥĦħÌÍÎÏìíîïĨĩĪīĬĭĮįİıịỉĴĵĶķĸĹĺĻļĽľĿŀŁłÑñŃńŅņŇňŉŊŋÒÓÔÕÖØòóôộỗổõöøŌōŎŏŐőọỏơởợỡŔŕŖŗŘřŚśŜŝŞşŠšſŢţŤťŦŧÙÚÛÜùúûüŨũŪūŬŭŮůŰűŲųụưủửữựŴŵÝýÿŶŷŸŹźŻżŽžứừửựữốồộỗổờóợỏỡếềễểệẩẫấầậỳỹýỷỵặẵẳằắ","AAAAAAaaaaaaAaAaAaaaCcCcCcCcCcDdDdDdEEEEeeeeeeEeEeEeEeEeeGgGgGgGgHhHhIIIIiiiiIiIiIiIiIiiiJjKkkLlLlLlLlLlNnNnNnNnnNnOOOOOOoooooooooOoOoOoooooooRrRrRrSsSsSsSssTtTtTtUUUUuuuuUuUuUuUuUuUuuuuuuuWwYyyYyYZzZzZzuuuuuooooooooooeeeeeaaaaayyyyyaaaaa")
    deputy_listing = {
      first_name: first_name,
      last_name: last_name,
      email: email,
    }
    a << deputy_listing
  end

  return a
end

print get_urls