#!/usr/bin/perl -w
use strict;

use Test::More tests => 27;
use CPAN::Testers::Common::Article;
use IO::File;

my @perls = (
  {
    text => 'Summary of my perl5 (revision 5.0 version 6 subversion 1) configuration',
    perl => '5.6.1'
  },
  {
    text => 'Summary of my perl5 (revision a version b subversion c) configuration',
    perl => '0'
  },
  {
    text => 'Summary of my perl5 (revision 5.0 version 8 subversion 0 patch 17332) configuration',
    perl => '5.8.0 patch 17332',
  },
  {
    text => 'Summary of my perl5 (revision 5.0 version 8 subversion 1 RC3) configuration',
    perl => '5.8.1 RC3',
  },
  {
    text => 'Summary of my perl5 (revision 5 patchlevel 6 subversion 1) configuration',
    perl => '5.6.1',
  },
  {
    text => 'on Perl 5.8.8, created by CPAN-Reporter',
    perl => '5.8.8',
  },
  {
    text => '/site_perl/5.8.8/',
    perl => '5.8.8',
  },
  {
    text => 'on perl 5.8.8, created by CPAN-Reporter',
    perl => '5.8.8',
  },
  {
    head => 'v5.12.0 RC1',
    text => 'Summary of my perl5 (revision 5.0 version 12 subversion 0) configuration',
    perl => '5.12.0 RC1',
  },
  {
    head => 'v5.12.0',
    text => 'Summary of my perl5 (revision 5.0 version 12 subversion 0) configuration',
    perl => '5.12.0',
  },

  {
    text => 'on perl 5, created by CPAN-Reporter',
    perl => '0',
  },
  {
    text => 'Summary of my perl5 (revision 5.0) configuration',
    perl => '0'
  },
  {
    text => 'Summary of my perl5 (revision 5.0 version 8) configuration',
    perl => '0'
  },
  {
    text => '/site_perl/5.8/',
    perl => '0'
  },
#  {
#    text => '',
#    perl => '',
#  },
);

my $article = readfile('t/nntp/126015.txt');
my $ctca = CPAN::Testers::Common::Article->new($article);
isa_ok($ctca,'CPAN::Testers::Common::Article');

for(@perls) {
  my $text = $_->{text};
  my $perl = $_->{perl};
  my $head = $_->{head};

  my $version = $ctca->_extract_perl_version($text,$head);
  is($version, $perl,".. matches perl $perl");
}

my @dates = (
    { date => 'Wed, 13 September 2004 06:29',   result => ['200409','200409130629',1095053340] },
    { date => '13 September 2004 06:29',        result => ['200409','200409130629',1095053340] },
    { date => 'September 22, 1999 06:29',       result => ['199909','199909220629',937978140] },
    { date => 'Wed, 13 September 2004',         result => ['200409','200409130000',1095030000] },
    { date => '13 September 2004',              result => ['200409','200409130000',1095030000] },
    { date => 'September 22, 1999',             result => ['199909','199909220000',937954800] },
    { date => 'Sep 22, 1999',                   result => ['199909','199909220000',937954800] },

    { date => 'September 22, 1995',             result => ['000000','000000000000',0] },
    { date => 'Month 22, 1999',                 result => ['000000','000000000000',0] },

    { date => '13/09/2004',                     result => ['000000','000000000000',0] },
    { date => '13-09-2004T06:29:00Z',           result => ['000000','000000000000',0] },
    { date => '',                               result => ['000000','000000000000',0] },
);

for my $date (@dates) {
    my @extract = $ctca->_extract_date($date->{date});
    #diag("$date->{date}: " . Dumper(\@extract));
    is_deeply(\@extract, $date->{result}, ".. test for $date->{date}");
}

sub readfile {
    my $file = shift;
    my $text;
    my $fh = IO::File->new($file)   or return;
    while(<$fh>) { $text .= $_ }
    $fh->close;
    return $text;
}
