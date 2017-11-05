## VERSION 1.2.1
  - Added more tests for newsletter modal dialog
## VERSION 1.2.0
  - Added new page account history
  - Added automated tests for account history
## VERSION 1.1.0
  - Added new page fir store finder
  - Added new region for store lists
  - Added automated tests for store finder
## VERSION 0.9.0
  - Added new page: product finder LRP
  - Added new page product finder Vichy
  - Added new region: product_finder
  - Added automated tests for product finder pages LRP and Vichy
## VERSION 0.8.3
  - Added 18 more tests for checkout flow with chanel products
## VERSION 0.8.2
  - Added 3 more tests for social links
  - Fixed tests for mobile breakpoint
## VERSION 0.8.1
  - Added new region Footer
  - Added new test scripts for global footer
## VERSION 0.7.2
  - Adding test for Chanel PD Page
## VERSION 0.7.1
  - Fixing PDP tests to ensure new fabricator works
  - Disabling mobile test run for PDP as they are not relevant
## VERSION 0.7.0
  - Implementing new user fabricator
  - Changes for settings, shipping info, newsletter, order confirmation, 
  checkout flow to accomodate new user fabricator
  - removed optimum functionality from newsletter page
  - Adding elir yml file
## VERSION 0.6.0
  - Add new account settings page
  - Add tests for the account settings page
  - Incorporating code review changes for the account settings page
## VERSION 0.5.0
  - Create new cart page object
  - Add tests for cart page
## VERSION 0.4.0
  - Created new page spec PDP
  - Add tests for PDP
## VERSION 0.3.2
  - Create shipping data fabricator
  - Add tests for account shipping page

## VERSION 0.2.2
  - Create newsletter fabricator
  - Add tests for newsletter fields validation
  - Add tests for successful newsletter subscription
  - Add skip to 3 of the French tests due to a bug   
  
## VERSION 0.1.2
  - add unicode_utils
  - add fix for some french characters which didn't respond to .upcase
  - add skip to one of the test due to a bug   
  
## VERSION 0.1.1
  - Add master and pcf to user fabricator
  - Add tests to checkout flow to test different payment options
  - Fixed minor bugs
  - Change mailosaur inbox to correct one

## VERSION 0.1.0
  - Add checkout flow tests for anonymous and registered users
  - Replaced watir_model with fabrication
  - Updated all specs to use fabrication
  - Add localization property files
  - Add new page objects (Checkout, Order Confirmation, PDP, Search Results)
  - Add new site regions (Items, Site Header)
  - Add dotenv gem