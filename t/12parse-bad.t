#!/usr/bin/perl -w
use strict;

use lib 'lib';
use Test::More tests => 21;
use IO::File;

use CPAN::Testers::Common::Article;

my @files = (
    't/nntp/bad-001.txt',
    't/nntp/bad-002.txt',
    't/nntp/bad-003.txt',
);

for my $file (@files) {
    my $article = readfile($file);
    $a = CPAN::Testers::Common::Article->new($article);
    isa_ok($a,'CPAN::Testers::Common::Article');
    ok(!$a->parse_report());
}

@files = (
    't/nntp/bad-004.txt',
    't/nntp/bad-005.txt',
    't/nntp/bad-006.txt',
    't/nntp/bad-007.txt',
    't/nntp/bad-008.txt',
);

for my $file (@files) {
    my $article = readfile($file);
    $a = CPAN::Testers::Common::Article->new($article);
    isa_ok($a,'CPAN::Testers::Common::Article');
    ok($a->parse_report());
    is($a->from, '');
}

sub readfile {
    my $file = shift;
    my $text;
    my $fh = IO::File->new($file)   or return;
    while(<$fh>) { $text .= $_ }
    $fh->close;
    return $text;
}
