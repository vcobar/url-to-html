module ApplicationHelper
  def jsonp(results)
    return "#{params["callback"]||"loadit"}(#{results.to_json});"
  end  
end
