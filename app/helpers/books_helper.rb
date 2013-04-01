# -*- encoding: utf-8 -*-
module BooksHelper
  def we6cat_title
    return nil unless @books
    case controller.action_name
    when 'index'
      ': 一覧表示'
    when 'show'
      ': 詳細表示'
    end
  end

  def ncid(url)
    URI.parse(url).path.split('/').last
  end
end
