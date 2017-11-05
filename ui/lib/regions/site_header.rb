# encoding: utf-8

module BB
  class SiteHeader < Ferris::Region

    el(:level1)           { b.lis(class: ['nav-link-2']) }
    el(:flyout)           { b.div(class: ['menu-flyout']) }
    
    def navigate_main_menu(menu, index)
      level1[menu].hover
      index.times do
        @site.b.send_keys :tab
      end
      @site.b.send_keys :enter
    end

    def initializer
      case site.args[:session].breakpoint
      when :desktop then
        class << self
          el(:search_btn)   { b.button(class: ['icon-magnifying']) }
          el(:search_field) { b.text_field(xpath: '//form[@id="nav-search"]//input') }
        end
      else
        class << self
          el(:search_btn)   { b.span(class: ['icon-magnifying']) }
          el(:search_field) { b.text_field(id: 'text') }
        end
      end
    end

    def search(product)
      search_btn.click
      search_field.set product, :enter
    end
  end
end
