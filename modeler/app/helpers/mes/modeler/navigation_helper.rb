module Mes::Modeler::NavigationHelper
  # Single main menu item
  def main_menu_item(text, url: nil, icon: nil)
    link_to url, 'data-toggle': 'collapse', 'data-parent': '#sidebar' do
      content_tag(:span, nil, class: "glyphicon glyphicon-#{icon}") +
        content_tag(:span, " #{text}", class: 'text') +
        content_tag(:span, nil, class: 'glyphicon glyphicon-chevron-left pull-right')
    end
  end

  # Main menu tree menu
  def main_menu_tree(text, icon: nil, sub_menu: nil, url: '#')
    content_tag :li, class: 'sidebar-menu-item' do
      main_menu_item(text, url: url, icon: icon) +
        render(partial: "mes/modeler/shared/sub_menu/#{sub_menu}")
    end
  end

  def link_to_new(resource)
    options[:data] = { action: 'new' }
    options[:class] = 'btn btn-success btn-sm'
    link_to_with_icon('plus', Mes.t(:new), edit_object_url(resource))
  end

  def link_to_edit(resource, options = {})
    url = options[:url] || edit_object_url(resource)
    options[:data] = { action: 'edit' }
    options[:class] = 'btn btn-primary btn-sm'
    link_to_with_icon 'pencil', Mes.t(:edit), url, options
  end

  def link_to_delete(resource, options = {})
    url = options[:url] || object_url(resource)
    name = options[:name] || Mes.t(:delete)
    options[:class] = 'btn btn-danger btn-sm delete-resource'
    options[:data] = { confirm: Mes.t(:are_you_sure), action: 'remove' }
    link_to_with_icon 'remove', name, url, options
  end

  def link_to_with_icon(icon_name, text, url, options = {})
    options[:class] = (options[:class].to_s + " icon-link with-tip action-#{icon_name}").strip
    options[:class] += ' no-text' if options[:no_text]
    options[:title] = text if options[:no_text]
    text = options[:no_text] ? '' : raw("<span class='text'>#{text}</span>")
    options.delete(:no_text)
    if icon_name
      icon = content_tag(:span, '', class: "glyphicon glyphicon-#{icon_name}")
      text.insert(0, icon + ' ')
    end
    link_to(text.html_safe, url, options)
  end

  def button(text, icon_name = nil, button_type = 'submit', options = {})
    if icon_name
      icon = content_tag(:span, '', class: "glyphicon glyphicon-#{icon_name}")
      text.insert(0, icon + ' ')
    end
    button_tag(text.html_safe, options.merge(type: button_type, class: "btn btn-primary #{options[:class]}"))
  end

  def button_link_to(text, url, html_options = {})
    if html_options[:method] &&
       html_options[:method].to_s.downcase != 'get' &&
       !html_options[:remote]
      form_tag(url, method: html_options.delete(:method)) do
        button(text, html_options.delete(:icon), nil, html_options)
      end
    else
      if html_options['data-update'].nil? && html_options[:remote]
        object_name, action = url.split('/')[-2..-1]
        html_options['data-update'] = [action, object_name.singularize].join('_')
      end

      html_options.delete('data-update') unless html_options['data-update']

      html_options[:class] = html_options[:class] ? "btn #{html_options[:class]}" : 'btn btn-default'

      if html_options[:icon]
        icon = content_tag(:span, '', class: "glyphicon glyphicon-#{html_options[:icon]}")
        text.insert(0, icon + ' ')
      end

      link_to(text.html_safe, url, html_options)
    end
  end

  def sidebar_menu_item(link_text, url, options = {})
    is_active = url.ends_with?(controller.controller_name) ||
                url.ends_with?("#{controller.controller_name}/edit") ||
                url.ends_with?("#{controller.controller_name.singularize}/edit")
    options.merge!(class: is_active ? 'active' : nil)
    content_tag(:li, options) do
      link_to(link_text, url)
    end
  end
end
