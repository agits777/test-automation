# encoding: utf-8

module BB
  class SiteFooter < Ferris::Region

    el(:privacy_policy)       { b.li(class: ['privacy']) }
    el(:terms_of_use)         { b.li(class: ['terms-of-use']) }
    el(:copyright)            { b.li(class: ['copyright']) }
    el(:footer_links)         { b.lis(class: ['footer-link']) }
    el(:facebook)             { b.link(class: ['icon-facebook']) }
    el(:twitter)              { b.link(class: ['icon-twitter']) }
    el(:pinterest)            { b.link(class: ['icon-pinterest']) }
    el(:open_mobile_content)  { b.spans(class: ['icon-arrow-down']) }
    el(:close_mobile_content) { b.spans(class: ['icon-arrow-up']) }

    def terms_click
      terms_of_use.link.click
    end

    def privacy_click
      privacy_policy.link.click
    end

    def copyright_year
      page_year = copyright.text.scan(/\d/).join('').gsub! '2015', ''
      actual_year = Time.new.year
      page_year.to_i == actual_year
    end

    def click_social_icon(icon)
    case icon
      when 'facebook'
        facebook.click
        @site.after_visit
      when 'twitter'
        twitter.click
        @site.after_visit
      when 'pinterest'
        pinterest.click
        @site.after_visit
    end
    end

    def open_content
      (0..1).each do |i|
        open_mobile_content[i].click
      end
    end

    def close_content
      (0..1).each do |i|
        close_mobile_content[i].click
      end
    end

  end
end
