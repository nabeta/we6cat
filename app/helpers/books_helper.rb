module BooksHelper
  def ncid(url)
    URI.parse(url).path.split('/').last
  end
end
