module Spina
  module Admin
    # This should behave just like pages for editing, with a few overloads.
    class BlocksController < AdminController
      include BlocksHelper

      before_action :set_breadcrumb
      before_action :set_tabs, only: [:new, :create, :edit, :update]
      before_action :set_locale

      def index
        redirect_to admin_blocks_path unless current_admin_path.starts_with?('/blocks')
        @blocks = case(params[:filter])
        when 'draft'
          Block.draft
        else
          Block.published
        end
      end

      def new
        @block = Block.new
        if new_block_templates.any? { |template| template[0] == params[:view_template] }
          @block.view_template = params[:view_template]
        end

        add_breadcrumb I18n.t('spina.pages.new')
        @block_parts = @block.view_template_block_parts(current_theme).map { |part| @block.part(part) }
        render layout: 'spina/admin/admin'

      end

      def create
        @block = Block.new(block_params)
        add_breadcrumb I18n.t('spina-blocks.new')
        if @block.save
          redirect_to spina.edit_admin_block_url(@block)
        else
          @block_parts = @block.view_template_page_parts(current_theme).map { |part| @page.part(part) }
          render :new, layout: 'spina/admin/blocks'
        end
      end

      def edit
        @block = Block.find(params[:id])
        add_breadcrumb @block.title
        @block_parts = @block.view_template_block_parts(current_theme).map { |part| @block.part(part) }
        render layout: 'spina/admin/blocks'
      end

      def update
        I18n.locale = params[:locale] || I18n.default_locale
        @block = Block.find(params[:id])
        respond_to do |format|
          if @block.update_attributes(block_params)
            add_breadcrumb @block.title
            @block.touch
            I18n.locale = I18n.default_locale
            format.html { redirect_to spina.edit_admin_block_url(@block, params: {locale: @locale}) }
            format.js
          else
            format.html do
              @block_parts = @block.view_template_block_parts(current_theme).map { |part| @block.block_part(part) }
              render :edit, layout: 'spina/admin/blocks'
            end
          end
        end
      end

      def destroy
        @block = Block.find(params[:id])
        @block.destroy
        redirect_to spina.admin_blocks_url
      end

      private def set_locale
        @locale = params[:locale] || I18n.default_locale
      end

      private def set_breadcrumb
        add_breadcrumb I18n.t('spina-blocks.blocks'), spina.admin_pages_path
      end

      private def set_tabs
        @tabs = %w{block_content advanced}
      end

      def block_params
        params.require(:block).permit!.merge(locale: params[:locale] || I18n.default_locale)
      end

    end
  end
end
