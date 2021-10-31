module ApplicationHelper
  def default_meta_tags
    {
      title:       "〇〇王！！ - quiz about me -",
      description: "「私について一番詳しいのは誰！？」YouTubeで話題の企画「〇〇王」がWEB上で楽しめるサービス",
      keywords:    "〇〇王！！, quiz, YouTube, YouTuber, 東海オンエア", 
      icon: [
        { href: image_url('favicon.png') },
      ],
      noindex: ! Rails.env.production?,
      canonical: request.original_url,
      charset: "UTF-8",
      og: {
        title: "〇〇王！！ - quiz about me -",
        description: "「私について一番詳しいのは誰！？」YouTubeで話題の企画「〇〇王」がWEB上で楽しめるサービス", 
        type: "website",
        url: request.original_url,
        image: image_url("ogp.png"),
        site_name: "〇〇王！！ - quiz about me -",
        locale: "ja_JP"
      },
      twitter: {
        site: '@quiz_about_me',
        card: 'summary_large_image',
      },
      fb: {
        app_id: '***************'
      }
    }
  end
end
  