module Spina
  module BlocksHelper
    def render_block(slug, opts = {})
      @block = Block.find_by(slug: slug)

      return if @block.nil?
      return unless @block.live?

      template = "#{current_theme.name}/blocks/#{@block.slug}"
      render template
    end
  end
end
