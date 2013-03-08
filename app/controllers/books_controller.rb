class BooksController < ApplicationController
  def index
    page = params[:page] ||= 1

    url = "http://ci.nii.ac.jp/books/opensearch/search"
    url += "?format=rss"
    if query_entered?(params)
      url += "&q=#{params[:freeword]}"
      url += "&title=#{params[:title]}"
      url += "&author=#{params[:author]}"
      url += "&publisher=#{params[:publisher]}"
      url += "&isbn=#{params[:isbn]}"
      url += "&issn=#{params[:issn]}"
      url += "&pub_year=#{params[:pub_year]}"
      url += "&type=#{params[:type]}"
      url += "&p=#{page}"
      url += "&appid=#{YAML.load(open("#{Rails.root.to_s}/config/application.yml").read)['cinii']['appid']}"

      doc = Nokogiri::XML(open(URI.encode(url)))
      books = doc.xpath('//xmlns:item').map{|e| Book.new(e)}
      @total_count = doc.at('//opensearch:totalResults').content.to_i
      @books = Kaminari::paginate_array(books, :total_count => @total_count).page(page).per(20)
      @start_record = (page.to_i - 1) * 20 + 1
      flash[:notice] = nil
    else
      if URI.parse(request.url).query
        flash[:notice] = '検索語を入力してください。'
      end
    end
  end

  def show
    ncid = params[:id].to_s
    raise if ncid.length != 10
    @book = Rails.cache.fetch("isbd_#{ncid}"){
      open("http://ci.nii.ac.jp/ncid/#{ncid}.txt").read.split("\r\n")
    }
    rdf = Rails.cache.fetch("holding_#{ncid}"){
      open("http://ci.nii.ac.jp/ncid/#{ncid}.rdf").read
    }
    @book.delete_at(0)
    @holdings = Nokogiri::XML(rdf).xpath('//bibo:owner')
  end

  private
  def query_entered?(params)
    [:freeword, :title, :author, :publisher, :isbn, :issn, :pub_year].each do |column|
      return true if params[column].present?
    end
    false
  end
end
