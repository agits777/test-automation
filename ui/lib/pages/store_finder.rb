# encoding: utf-8

require_relative '../regions/stores_info'

module BB
  class StoreFinder < Ferris::Page

    partial_url { '/store-finder' }
    # initial page
    el(:current_location_btn)    { b.button(class: ['get-current-location']) }
    el(:search_store_btn)        { b.button(class: ['search-store-link']) }
    el(:search_store_input)      { b.text_field(class: ['search-store-input']) }
    el(:no_store_found_msg)      { b.div(class: ['no-store-found']) }
    # store finder page
    rgn(:stores_info, BB::StoresInfo) { b.divs(class: 'custom-scrollbar') }
    el(:store_list)              { b.div(class: ['store-list']) }
    el(:more_results)            { b.link(class: ['pagination-btn']) }
    el(:pagination_more)         { b.span(xpath:'//span[@class="icon-chevron-thin-right"]')}
    el(:pagination_less)         { b.span(xpath:'//span[@class="icon-chevron-thin-left"]')}
    # store details
    el(:store_name_details)      { b.span(class: ['icon-chevron-thin-right']) }


    def search_store(input)
      search_store_input.set input
      search_store_btn.click
    end

    def stores_count
      stores_info[0].store_name.count - 1
    end

    def store_details(index)
      stores_info[0].store_details_lnk[index].click
    end

    def get_directions(index)
      stores_info[0].get_directions_lnk[index].click
      @site.b.windows.last.use
    end

    def pagination(option)
      option == 'more' ? pagination_more.click : pagination_less.click
    end
  end
end
