# encoding: utf-8

module BB
    class HomePage < Ferris::Page
      partial_url { '' }

      el(:shoppers_link) { b.link(href:'http://www1.shoppersdrugmart.ca/en/home') }

        def shoppers_site
            shoppers_link.click
        end
    end
end