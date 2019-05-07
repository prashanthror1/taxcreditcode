class ContactPage < SitePrism::Page

  set_url '/contact'
  set_url_matcher /contact/

  element(:firstname, 'input[name="firstname"]')
  element(:jobtitle, 'input[name="jobtitle"]')
  element(:email, 'input[name="email"]')
  element(:phone, 'input[name="phone"]')
  element(:company, 'input[name="company"]')
  element(:company_size, 'input[name="company_size"]')
  element(:state, 'input[name="state"]')
  element(:industry, 'input[name="industry"]')
  element(:message, 'textarea[name="message"]')
  element(:submit, 'input[type="submit"]')
  elements(:error_messages, 'label[class="hs-error-msg"]')
  element(:submitted,'.submitted-message')
end
