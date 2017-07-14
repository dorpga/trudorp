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

  def init_simplemde(el=nil)
    if el
      "<script type='text/javascript'>var simplemde = new SimpleMDE(document.getElementById('##{el}'));</script>".html_safe
    else
      "<script type='text/javascript'>var simplemde = new SimpleMDE();</script>".html_safe
    end
  end

  def unpkg(p)
    "<script type='text/javascript' src='https://unpkg.com/#{p}' charset='utf-8'></script>".html_safe
  end

  def container(&block)
    content = capture(&block)
    concat(content_tag(:div, content, class: 'uk-container uk-container-expand uk-margin-small-top'))
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
