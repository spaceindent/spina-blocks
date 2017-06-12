module Spina
  module Blocks
    include ActiveSupport::Configurable

    config_accessor :name, :description, :plugin_type

    self.name = 'Blocks'
    self.description = 'Reusable blocks for Spina Pages'

    self.plugin_type = 'page_part'
  end
end
