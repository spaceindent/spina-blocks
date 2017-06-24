# require 'app/helpers/spina/blocks_helper'
module Spina
  class Railtie < Rails::Railtie
    initializer "blocks.view_helpers" do
      ActionView::Base.send :include, Spina::BlocksHelper

      # patch the theme to support block parts and templates.
      ::Spina::Theme.class_eval do |theme|
        attr_accessor :blocks_parts, :blocks_templates
      end
    end
  end
end
