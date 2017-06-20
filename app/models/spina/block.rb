module Spina
  class Block < ActiveRecord::Base
    include Spina::BlockPartable

    translates :title, :description

    scope :published, -> { where(active: true) }
    scope :draft, -> { where(active: false) }

    has_many :block_parts, dependent: :destroy, inverse_of: :block

    accepts_nested_attributes_for :block_parts, allow_destroy: true

    alias_attribute :block_part, :part
    alias_attribute :parts, :block_parts

    def view_template_config(theme)
      view_template_name = view_template.presence || 'block'
      theme.blocks_templates.find { |template| template[:name] == view_template_name }
    end

    def view_template_block_parts(theme)
      theme.blocks_parts.select do |block_part|
        template_config = view_template_config(theme)
        block_part[:name].in? template_config[:block_parts]
      end
    end
  end
end
