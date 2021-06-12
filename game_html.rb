
class File

  def html_start
    self.write("<!DOCTYPE html>\n<html lang='ja'>\n")
  end

  def html_end
    self.write("</html>\n")
  end

end


class GameHTML
  attr_accessor :script

  def initialize(h1 = 'Game', script = '')
    @body = GameBody.new(h1)
    @script = script
  end

  def add_canvas(canvas)
    @body.canvas = canvas
  end

  def body
    return @body.arrange
  end

  def head
    return <<"EOS"
      <head>
      #{META}
      #{LINK}
        <title>#{TITLE}</title>
        <script>#{@script}</script>
      </head>
EOS
  end

end


class GameBody
  attr_accessor :h1, :pre, :canvas, :post

  def initialize(h1 = 'Game')
    @h1 = h1
    @pre = []
    @canvas = ''
    @post = []
  end

  def arrange
    return <<"EOS"
      <body>
        <h1>#{@h1}</h1>
        #{@canvas}
      </body>
EOS
  end
end
