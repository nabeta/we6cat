module ApplicationHelper
  def title
    return nil unless @books
    case controller.action_name
    when 'index'
      ': 一覧表示'
    when 'show'
      ': 詳細表示'
    end
  end
end
