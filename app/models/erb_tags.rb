require 'erb'
require 'haml'

module ErbTags
  
  include Radiant::Taggable

  class TagError < StandardError; end
  
  desc %{
    Exécute un script de vue
    
    *Usage*:
    
    <pre><code><r:erb name="foo" /></code></pre>
  }
  tag "erb" do |tag|
    raise 'L\'attribut "name" doit être défini.' unless tag.attr['name']
    
    pathname = pathname_rhtml = pathname(tag, 'rhtml')
    unless File.exists? pathname
      pathname = pathname(tag, 'haml')
    end
    raise 'Le fichier "%s" n\'existe pas.' % pathname_rhtml unless File.exists? pathname
    
    # exécution du tag s'il est namspacé et s'il existe
    name = tag.attr['name']
    if name.index(':') && tags.include?(name)
      render_tag name, tag
    end
    
    # rendu du template
    template = File.read(pathname)
    
    if File.extname(pathname) == '.rhtml'
      # erb
      erb = ERB.new(template)
      content = erb.result(OpenStruct.new(tag.locals.to_hash).send(:binding))
    else
      # haml
      haml_engine = Haml::Engine.new(template)
      content = haml_engine.render Object.new, tag.locals.to_hash
    end
    
    # utilisation des mêmes parser et context de la page
    tag.locals.page.send :parse, content
  end
  
  private
  
  def pathname(tag, extension)
    filename = tag.attr['name'].gsub(':', '/')
    "#{RAILS_ROOT}/app/views/#{filename}.#{extension}"
  end
    
end

module Radius
  class DelegatingOpenStruct
    def to_hash
      @hash
    end
  end
end