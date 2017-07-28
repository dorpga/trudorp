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

  def quill_blog_editor()
    '<div id="toolbar-container">
    <span class="ql-formats">
    <select class="ql-font"></select>
    <select class="ql-size"></select>
    </span>
    <span class="ql-formats">
    <button class="ql-bold"></button>
    <button class="ql-italic"></button>
    <button class="ql-underline"></button>
    <button class="ql-strike"></button>
    </span>
    <span class="ql-formats">
    <select class="ql-color"></select>
    <select class="ql-background"></select>
    </span>
    <span class="ql-formats">
    <button class="ql-script" value="sub"></button>
    <button class="ql-script" value="super"></button>
    </span>
    <span class="ql-formats">
    <button class="ql-header" value="1"></button>
    <button class="ql-header" value="2"></button>
    <button class="ql-blockquote"></button>
    <button class="ql-code-block"></button>
    </span>
    <span class="ql-formats">
    <button class="ql-list" value="ordered"></button>
    <button class="ql-list" value="bullet"></button>
    <button class="ql-indent" value="-1"></button>
    <button class="ql-indent" value="+1"></button>
    </span>
    <span class="ql-formats">
    <button class="ql-direction" value="rtl"></button>
    <select class="ql-align"></select>
    </span>
    <span class="ql-formats">
    <button class="ql-link"></button>
    <button class="ql-image"></button>
    <button class="ql-video"></button>
    <button class="ql-formula"></button>
    </span>
    <span class="ql-formats">
    <button class="ql-clean"></button>
    </span>
    </div>
    <div id="blog_post_body_editor"></div>
    <script type="text/javascript" charset="utf-8">
    var editor = new Quill("#blog_post_body_editor", {
      modules: {
        toolbar: "#toolbar-container"
      },
      theme: "snow"
    });
    editor.root.innerHTML = document.getElementById("blog_post_body").value
    var form = document.getElementById("blog_post_form");
    form.onsubmit = function() {
      var body = document.getElementById("blog_post_body");
      body.value = editor.root.innerHTML
    };
    </script>
    '.html_safe
  end

  def quill_forum_editor()
    "
    <div id='forum_post_body_editor'></div>
    <script type='text/javascript' charset='utf-8'>
      var editor = new Quill('#forum_post_body_editor', {
        modules: {
          toolbar: [
            [{ 'header': [1, 2, 3, 4, false] }],
            [
              'bold', 'italic', 'underline', 'strike'
            ],
            [
              'blockquote', 'code-block'
            ],
            [
              'link', 'image', 'video'
            ],
            [
              {
                'list': 'ordered'
              }, {
                'list': 'bullet'
              }
            ],
            [
              {
                'script': 'sub'
              }, {
                'script': 'super'
              }
            ]
          ]
        },
        theme: 'snow'
      });
      editor.root.innerHTML = document.getElementById('forum_post_body').value
      var form = document.getElementById('forum_post_form');
      form.onsubmit = function () {
        var body = document.getElementById('forum_post_body');
        body.value = editor.root.innerHTML
      };
    </script>
    ".html_safe
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
