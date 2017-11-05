# encoding: utf-8

module BB
  class Amazon < Ferris::Page
    partial_url { '/gp/help/customer/display.html' }

    # initial page
    el(:submit)        { b.button(class: ['nav-input']) }
    el(:search)        { b.text_field(id: 'twotabsearchtextbox') }

  end
end