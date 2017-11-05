# encoding: utf-8

module Helpers
  module EmailValidation
    def check_email_subject(email:, subject:)
      mailer = Mailosaur.new(MAILBOX_ID, MAILOSAUR_API_KEY)
      expect { mailer.get_emails_by_recipient(email) }.to eventually be_a(Array)
      expect { mailer.get_emails_by_recipient(email).map(&:subject) }.to eventually(include(subject)).within 20
    end
  end # EmailValidation

  module Product
    def add_to_cart(product:, qty: 1)
      visit_pdp_page(product: product)
      @site.pd_page.tap do |page|
        page.fill! qty_dropdown: qty
        page.add_product_to_cart
      end
    end

    def visit_pdp_page(product:)
      @site.search(product)
      @site.search_results.go_to_pdp
    end


    def visit_chanel_pdp
      @chanel.visit
      @site.search_results.go_to_pdp
    end

    def add_chanel_to_cart(index:, qty: 1)
      @site.chanel_page.visit
      @site.search_results.item[index].product_name.click
      @site.pd_page.tap do |page|
        page.fill! qty_dropdown: qty
        page.add_product_to_cart
      end
    end
  end # Product
end # Helpers
