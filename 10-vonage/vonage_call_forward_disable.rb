require 'rubygems'

require 'watir'

include Watir

ie = IE.new
ie.goto( 'http://www.vonage.com/' )

ie.text_field( :name, 'username' ).set( 'username')
ie.text_field( :name, 'password' ).set( 'password' )
ie.button( :name, 'submit' ).click

ie.link(:text,"Features").click

ie.button( :name, 'callForwardingButton' ).click

ie.button(:value,'Disable').click

ie.link(:text,"Log Out").click
ie.close
