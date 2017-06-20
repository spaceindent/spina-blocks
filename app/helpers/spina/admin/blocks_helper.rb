module Spina
  module Admin
    module BlocksHelper
      def new_block_templates
        current_theme.blocks_templates.map do |view_template|
          [view_template[:name], view_template[:title], view_template[:description], view_template[:usage]]
        end.compact
      end
    end
  end
end
