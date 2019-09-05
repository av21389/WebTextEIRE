#!/usr/bin/env perl 
#Send Webtext Usage ./ThreeIE_WebText.pl "Your Text Here" "353871231231"

use warnings;
use WWW::Mechanize;
use HTTP::Cookies;

my $message = $ARGV[0];
$message =~ tr/+/ /;

my $recipientNumber = $ARGV[1];	#Recipient of the WebText including country code
	
my $url = "https://login.three.ie/";
my $username = '';	#Your mobile number. Three Mobile Ireland account must already exist
my $password = '';	#Your Three Ireland account password
my $mech = WWW::Mechanize->new();

#Login
$mech->cookie_jar(HTTP::Cookies->new());
$mech->get($url);
$mech->form_number(1);
$mech->field("username", $username);
$mech->field("password", $password);
$mech->click;

#Click Webtext Link
$mech->follow_link( url => 'https://messaging.three.ie/messages/send' );

#Send Message using HTTP POST Request
my $uri = "https://messaging.three.ie/messages/send";
my $data = "_token=&message=$message&recipients_contacts%5B%5D=%2B$recipientNumber&scheduled_date=&scheduled_time=&scheduled_datetime=&inputDatetime=&scheduled=";
$mech->add_header( 'content-type' => 'application/x-www-form-urlencoded' );
$mech->post($uri, Content => $data);

exit;
