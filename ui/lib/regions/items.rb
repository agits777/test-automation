# encoding: utf-8

module BB
  class Items < Ferris::Region
    el(:picture)          { root.link(class: ['product-img']) }
    el(:brand_name)       { root.p(class: ['product-brand-name']) }
    el(:product_name)     { root.p(class: ['product-name']) }
    el(:product_price)    { root.p(class: ['product-price']) }
    el(:qv)               { root.input(class: ['quick-view-btn']) }
    el(:picture)          { b.link(class: ['product-img']) }

    def go_to_pdp
      picture.click
    end

    def qv_click
      qv.click
    end

    def hover_product
      brand_name.hover
    end
  end
end
