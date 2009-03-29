require 'rubygems'
require 'spec'

Given /^a username '(.*)'$/ do |username|
  @username = username
end

Given /^a password '(.*)'$/ do |password|
  @password = password
end

Given /^an email '(.*)'$/ do |email|
  @email = email
end

When /^the user logs in with username and password$/ do
  @correct_user = User.login(@username, @password)
end

Then /^the login form should be shown again$/ do
  @correct_user.should be_false
end

Given /^there is no user with this username$/ do
  User.find_by_username(@username).should be_nil
end

When /^the user creates an account with username, password and email$/ do
  @created_user = User.new @username, @password, @email
end

Then /^there should be a user named '(.*)'$/ do |username|
  User.find_by_username(username).should_not be_nil
end

Then /^should redirect to '\/'$/ do
  @created_user.should be_true
end
