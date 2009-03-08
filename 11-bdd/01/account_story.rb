
require 'rubygems'
require 'spec'
require 'spec/story'
require 'account'

Story "transfer to cash account",
%(As a savings account holder
  I want to transfer money from my savings account
  So that I can get cash easily from an ATM) do

  Scenario "savings account is in credit" do
    Given "my savings account balance is", 100 do |balance|
      @savings_account = Account.new(balance)
    end
    And "my cash account balance is", 10 do |balance|
      @cash_account = Account.new(balance)
    end
    When "I transfer", 20 do |amount|
      @savings_account.transfer_to(@cash_account, amount)
    end
    Then "my savings account balance should be", 80 do |expected_amount|
      @savings_account.balance.should == expected_amount
    end
    And "my cash account balance should be", 30 do |expected_amount|
      @cash_account.balance.should == expected_amount
    end
  end

  Scenario "savings account is overdrawn" do
    Given "my savings account balance is", -20
    And "my cash account balance is", 10
    When "I transfer", 20
    Then "my savings account balance should be", -40
    And "my cash account balance should be", 30
  end
end
