require_dependency 'repositories_helper'

module Checkout
  module RepositoriesHelperPatch
    def self.included(base) # :nodoc:
      base.send(:include, InstanceMethods)

      base.class_eval do
        alias_method :repository_field_tags_without_checkout, :repository_field_tags
        alias_method :repository_field_tags, :repository_field_tags_with_checkout
        alias_method :scm_select_tag_without_javascript, :scm_select_tag
        alias_method :scm_select_tag, :scm_select_tag_with_javascript
      end
    end

    module InstanceMethods
      def repository_field_tags_with_checkout(form, repository)
        tags = repository_field_tags_without_checkout(form, repository) || ""
        return tags if repository.class.name == "Repository"

        tags << controller.render_to_string(:partial => 'projects/settings/repository_checkout', :locals => {:form => form, :repository => repository, :scm => repository.type.demodulize}).html_safe
      end

      def scm_select_tag_with_javascript(*args)
        heads_for_wiki_formatter
        content_for :header_tags do
          javascript_include_tag('subform', :plugin => 'redmine_checkout') +
          stylesheet_link_tag('checkout', :plugin => 'redmine_checkout')
        end
        scm_select_tag_without_javascript(*args)
      end
    end
  end
end

RepositoriesHelper.send(:include, Checkout::RepositoriesHelperPatch)

