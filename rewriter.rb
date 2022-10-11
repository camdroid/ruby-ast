require 'rubocop'
require 'rubocop-ast'
require 'parser/current'

code = File.read('main.rb')
ast = Parser::CurrentRuby.parse code
buffer = Parser::Source::Buffer.new('( example )', source: code)

class UpdateMerakiImage < Parser::TreeRewriter
  def on_casgn(node)
    scope, lvar, val = *node
    if lvar == :IMAGE_UP
      new_code = "#{lvar} = '1.3.5'"
      replace(node.loc.expression, new_code)
    end
  end
end

rewriter = UpdateMerakiImage.new

# Rewrite the AST, returns a String with the new form.
puts rewriter.rewrite(buffer, ast)
