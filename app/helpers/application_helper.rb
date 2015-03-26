module ApplicationHelper

  def full_title(page_title = '')
    base_title = "Go-Notes"
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end

  def active_link_to(icon_name, link_text, link_path, options={})
    options[:class] = 'active' if current_page?(link_path)
    link_to "#{image_tag(icon_name, class: 'img-responsive', alt: 'link_text', title: 'link_text', size: '68')} <span>#{link_text}</span>".html_safe, link_path, options
  end
end
