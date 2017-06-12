module Spina
  module Blocks
    class Engine < ::Rails::Engine
      isolate_namespace Spina

      initializer "blocks.register" do
        Spina::Plugin.register do |plugin|
          plugin.name = 'blocks'
          plugin.namespace = 'blocks'
        end

        ActiveSupport.on_load :action_view do
          include Spina::Admin::BlocksHelper
        end
      end
    end
  end
end
