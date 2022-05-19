FactoryGirl.define do
  factory :message, :class => PointlessFeedback::Message do
    name          'A Developer'
    email_address 'developer@pointlesscorp.com'
    description   'Site is broke'
    topic         'Other'
    url           'https://www.viget.com/'
  end
end
