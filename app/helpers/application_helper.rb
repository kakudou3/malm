module ApplicationHelper

  # マークダウンへの対応
  @@markdown = Redcarpet::Markdown.new Redcarpet::Render::HTML,
    autolink: true,
    space_after_headers: true,
    no_intra_emphasis: true,
    fenced_code_blocks: true,
    tables: true,
    hard_wrap: true,
    xhtml: true,
    lax_html_blocks: true,
    strikethrough: true

  def markdown(text)
    @@markdown.render(text).html_safe
  end

  # テキスト中に含まれるurlをリンクに変換するメソッド
  def text_url_to_link text
      URI.extract(text, ['http']).uniq.each do |url|
        sub_text = ""
        sub_text << "<a href=" << url << " target=\"_blank\">" << url << "</a>"
        text.gsub!(url, sub_text)
      end
    return text
  end

  # 改行コードから改行タグを作成する
  def linebreak_to_br(text)
    return text.gsub(/\r\n|\r|\n/, "<br />")
  end
end
