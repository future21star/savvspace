require 'database_cleaner'

DatabaseCleaner.strategy = :deletion

RSpec.configure do |config|

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:deletion)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end

end
