# encoding: utf-8
require 'date'

module BB
  class AccountHistory < Ferris::Page
    include BB::Helpers

    partial_url { '/my-account/orders' }

    # initial page
    el(:optimum_block)            { b.div(class: ['optimum-point-block']) }
    el(:total_page)               { optimum_block.span(class: ['label-head']) }
    el(:address_block)            { b.div(class: ['address-block']) }
    el(:address_elements)         { address_block.spans(class: ['label-head']) }
    el(:date_block)               { b.div(class: ['ordered-date-block']) }
    el(:date_ordered)             { date_block.ul(class: ['date-details']) }
    el(:delivery)                 { date_block.spans(class: ['label-head']) }
    el(:details_lnk)              { b.button(class: ['order-review-continue-btn']) }
    el(:product_details)          { b.div(class: ['product-detail']) }
    el(:order_details)            { b.labels(class: ['info']) }
    el(:back_to_history_lnk)      { b.link(class: ['orderHistoryPage']) }
    el(:report_problem_lnk)       { b.uls(class: ['other-tasks']) }

    def date_placed
      current = DateTime.now
      month = Date::MONTHNAMES[current.month]
      date = current.day.to_s
      year = current.year.to_s
      @placed = month + ' ' + date + ',' + ' ' + year
    end

    def view_details
      details_lnk.click
    end

    def back_to_history
      back_to_history_lnk.click
    end

    def report_problem
      case @site.args[:session].breakpoint
        when :desktop
          report_problem_lnk[3].click
        when :mobile
          report_problem_lnk[0].link.click
        when :tablet
          report_problem_lnk[2].link.click
      end
    end
  end
end
