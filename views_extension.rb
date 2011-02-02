class ViewsExtension < Radiant::Extension
  
  version "1.0"
  description "Render embedded ruby (rhtml or haml) with ease"
  url "https://github.com/lunaweb/radiant-views-extension"
  
  def activate
    Page.send :include, ViewsTags
  end
  
end
