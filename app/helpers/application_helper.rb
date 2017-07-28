module ApplicationHelper
  class CodeRayify < Redcarpet::Render::HTML
    def block_code(code, language)
      CodeRay.scan(code, language).div
    end
  end

  def get_avatar(u)
    if u
      if u.avatar.exists?(:original)
        u.avatar
      else
        "https://github.com/identicons/#{Digest::MD5::hexdigest(u.username).downcase}.png"
      end
    else
      "/images/avatar_placeholders/deleted.png"
    end
  end

  def container(&block)
    content = capture(&block)
    concat(content_tag(:div, content, class: 'uk-container uk-container-expand uk-margin-small-top'))
  end

  def form_field(&block)
    content = capture(&block)
    concat(content_tag(:div, content, class: 'field uk-margin'))
  end

  def form_group(&block)
    content = capture(&block)
    concat(content_tag(:div, content, class: 'form-group uk-margin'))
  end

  def markdown(text)
    coderayified = CodeRayify.new(:filter_html => true,
                                  :hard_wrap => true)
    options = {
      :fenced_code_blocks => true,
      :no_intra_emphasis => false,
      :autolink => true,
      :lax_html_blocks => true,
    }
    markdown_to_html = Redcarpet::Markdown.new(coderayified, options)
    markdown_to_html.render(text).html_safe
  end
end
