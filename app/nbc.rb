module NBC

  def self.fetch_sports
    errors = Pointer.new(:object)
    url = 'http://scores.nbcsports.msnbc.com/ticker/data/sports.js.asp?order='
    data = NSData.alloc.initWithContentsOfURL(NSURL.URLWithString(url), error:errors)
    json = NSJSONSerialization.JSONObjectWithData(data, options:0, error:errors)
  end

end
