# encoding: utf-8

module BB
  class ProductFinder < Ferris::Region
    el(:picture)          { root.link(class: ['image']) }
    el(:step)             { root.p(class: ['product-step']) }
    el(:product_name)     { root.p(class: ['product-name']) }
    el(:add_to_cart)      { root.div(class: ['product-add-to-cart']) }

    def add_product_to_cart
      add_to_cart.click
    end
  end
end
