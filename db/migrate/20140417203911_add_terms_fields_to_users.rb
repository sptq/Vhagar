class AddTermsFieldsToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :acceptTerms, :boolean, default: false
  	add_column :users, :acceptMarketingTerms, :boolean, default: false
  end
end
