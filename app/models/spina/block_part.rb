module Spina
  class BlockPart < ApplicationRecord
    include Part
    include Optionable

    belongs_to :block, inverse_of: :block_parts
    belongs_to :page_partable, polymorphic: true, optional: true

    accepts_nested_attributes_for :page_partable, allow_destroy: true

    validates :name, uniqueness: {scope: :block_id}

    alias_attribute :partable, :page_partable
    alias_attribute :partable_type, :page_partable_type
    alias_method :page_partable_attributes=, :partable_attributes=

    def position(theme)
      block.view_template_config(theme)[:block_parts].index { |block_part| block_part == self.name }.to_i
    end

  end
end
