require 'rubygems'
require 'spec/story'
require 'spec/story/extensions/main'

require File.join(File.dirname(__FILE__), "../account")

steps_for(:bank) do
  Given("my savings account balance is '$savings'") do |savings|
    @savings_account ||= Account.new(savings)
  end
end

steps_for(:bank) do
  Given("my cash account balance is '$cash'") do |cash|
    @cash_account ||= Account.new(cash)
  end
end

steps_for(:bank) do
  When("I transfer '$amount'")  do |amount|
     @savings_account.transfer_to(@cash_account, amount)
  end
end

steps_for(:bank) do
  Then("my savings account balance should be '$expected_amount'") do |expected_amount| 
     @savings_account.balance.should == expected_amount.to_f
  end
end
