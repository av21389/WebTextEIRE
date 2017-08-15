#!/usr/bin/env perl
#Send Webtext
#Usage ./TescoMobileIE_WebText.pl "Your Text Here" "0871231231"

use warnings;
use WWW::Mechanize;
use HTTP::Cookies;

my $message = $ARGV[0];
$message =~ tr/+/ /;

my $recipientNumber = $ARGV[1];	#Recipient of the WebText
	
my $url = "https://my.tescomobile.ie/tmi-selfcare-web/login";
my $username = '0871234567';	#Your mobile number. Tesco Mobile IE account must already exist
my $password = 'PASSWORD';		#Your Tesco Mobile IE account password
my $mech = WWW::Mechanize->new();

#Login
$mech->cookie_jar(HTTP::Cookies->new());
$mech->get($url);
$mech->form_number(1);
$mech->field("j_username", $username);
$mech->field("j_password", $password);
$mech->click;


#Send Message using HTTP POST Request
my $uri = "https://my.tescomobile.ie/tmi-selfcare-web/rest/webtext/sendWebText";
my $json = qq({"message":"$message","contacts":[],"groups":[],"msisdns":["$recipientNumber"]});

$mech->add_header( 'content-type' => 'application/json' );
$mech->post($uri, Content => $json);

exit;
