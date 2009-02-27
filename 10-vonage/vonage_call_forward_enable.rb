require 'rubygems'

require 'watir'

include Watir

ie = IE.new
ie.goto( 'http://www.vonage.com/' )

ie.text_field( :name, 'username' ).set( 'username' )
ie.text_field( :name, 'password' ).set( 'password' )
ie.button( :name, 'submit' ).click

ie.link(:text,"Features").click

ie.button( :name, 'callForwardingButton' ).click

ie.select_list( :name, 'callForwardingSeconds' ).select( 'Instantly' )
ie.text_field( :name, 'singleAddress' ).set( '15035551234' )

ie.button(:value,'Enable').click

ie.link(:text,"Log Out").click
ie.close