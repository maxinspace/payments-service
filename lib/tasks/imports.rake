namespace :csv_import do
  desc "Update merchants from CSV file"
  task :merchants, [:filename] => :environment do |t, args|
    Tasks::MerchantCsvImport.new(args[:filename]).call
  end

  desc "Update transactions from CSV file"
  task :transactions, [:filename] => :environment do |t, args|
    Tasks::TransactionCsvImport.new(args[:filename]).call
  end
end
