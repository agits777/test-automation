# encoding: utf-8

require_relative '../regions/items'

module BB
  class SearchResults < Ferris::Page
    include BB::Helpers
    partial_url { '/search?text=' }

    rgn(:item, BB::Items)        { b.lis(class: 'product-tile') }
    el(:filter_brand_rgn)        { b.div(id: 'filterOptions') }
    el(:select_brand_btn)        { filter_brand_rgn.lis(class: ['option']) }

    el(:load_more_lnk)           { b.link(text: '2') }
    el(:next_page_lnk)           { b.link(class: ['icon-chevron-right']) }
    el(:qv_wrapper)              { b.div(class: ['quick-view-wrapper']) }
    el(:exposed_search)          { b.text_field(class: ['typeahead-search']) }
    el(:qty_dropdown)            { b.select(class: ['sort-by']) }
    el(:invalid_search_msg)      { b.span(xpath: '//span[@class="searched-text"]') }

    def go_to_pdp(index: 0)
      item[index].go_to_pdp
    end

    def search_results_count
      item.count - 1
    end

    def next_page
      next_page_lnk.click
      @site.ensure_loaded
    end

    def hover_product(index: 0)
      item[index].hover_product
    end

    def qv_click(index: 0)
      item[index].qv_click
    end

    def brand_name(i)
      item[i].brand_name.text
    end

    def product_name(i)
      item[i].product_name.text
    end

    def select_brand(option)
      select_brand_btn[option].click
    end

    def filter_by_brand(option)
      @site.b.scroll.to :center
      select_brand_btn[option].click
      @site.ensure_loaded
      @brand_selected = select_brand_btn[option].text
    end

    def brand_text(option)
      select_brand_btn[option].text
    end

    def sort_by(criteria)
      @site.search_results.fill! qty_dropdown: criteria
      @site.ensure_loaded
      @site.b.refresh
      case criteria
        when 'price-desc'
          price = []
          item.each do |i|
            price << i.product_price.text
          end
          price.delete_if do |element|
            true if element.length >= 8
          end
          get_num(price[0]) >= get_num(price[price.size - 1]) ? @sorting = true : @sorting = false
        when 'price-asc'
          price = []
          item.each do |i|
            price << i.product_price.text
          end
          price.delete_if do |element|
            true if element.length >= 8
          end
          get_num(price[0]) <= get_num(price[price.size - 1]) ? @sorting = true : @sorting = false
      end
      @sorting
    end
  end
end