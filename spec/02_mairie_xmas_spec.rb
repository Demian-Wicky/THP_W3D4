require_relative '../lib/02_mairie_xmas'

describe "the get_urls method" do
  it "should return an array" do
    expect(get_urls).to be_an(Array) 
  end
  it "the array should not be empty" do
    expect(get_urls).not_to be_empty
  end

end

describe "the mairie_xmas method" do
  it "should return an array" do
    expect(mairie_xmas).to be_an(Array)
  end

  it "should contain a key CHARS with a value that contains a @" do
    expect(mairie_xmas).to include("CHARS" => include("@"))
  end

end