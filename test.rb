require './job/fetch_data'

I18n.enforce_available_locales = false

Mongoid.load!('./config/mongoid.yml', :development)

fd = Pioneer::Job::FetchData.new

fd.work
