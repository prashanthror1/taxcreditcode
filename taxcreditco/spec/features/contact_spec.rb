require 'spec_helper'
require 'pages/contact_page'
require 'roo'

describe "Contact Submit", type: :feature do
  before :each do
    @contact_page = ContactPage.new
    @contact_page.load
  end

  it "navigates to contact page and page displays" do
    expect(@contact_page.title).to eq('Contact TCC | TCC')
    expect(@contact_page).to be_displayed
  end

  it "submits the form with data from excel file" do
    xlsx = Roo::Spreadsheet.open(File.expand_path(File.dirname(__FILE__) + '/../data/contacts.xlsx'))
    data = xlsx.sheet(0).parse(firstname: /NAME/i, jobtitle: /Title/i, email: /Email/i, phone: /Phone/i, company: /\ACompany\z/i, company_size: /Company\sSize/i, state: /State|Region/i, industry: /Industry/i, message: /Additional Information/i)
    success_message = 'Thanks for reaching out! A representative will be in touch shortly.'
    successful = 0
    unsuccessful = 0
       data.each do |info|
         @contact_page.load
         within(".contact-box") do
         @contact_page.firstname.set info[:firstname]
         @contact_page.jobtitle.set info[:jobtitle]
         @contact_page.email.set info[:email]
         @contact_page.phone.set info[:phone]
         @contact_page.company.set info[:company]
         @contact_page.company_size.set info[:company_size]
         @contact_page.state.set info[:state]
         @contact_page.industry.set info[:industry]
         @contact_page.message.set info[:message]
         @contact_page.submit.click
       end
       begin
       if @contact_page.submitted.visible?
         expect(@contact_page.submitted.text).to eq(success_message)
         puts "Form Sucessfully Submitted\n\n"
         successful += 1
       end
       rescue => e
         errors = @contact_page.error_messages.collect{|err| err.text}
         puts "Form Not Sucessfully Submitted \nErrors Encountered : #{errors} for the data #{info.inspect}\n\n"
         unsuccessful += 1
       end
     end
     puts "\n\n========  Successful Submits = #{successful}  ========"
     puts "\n\n========  Unsuccessful Submits = #{unsuccessful}  ========"
  end
end
