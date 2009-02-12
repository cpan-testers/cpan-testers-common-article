use ExtUtils::MakeMaker;
WriteMakefile(
    'NAME'          => 'CPAN::Testers::Common::Article',
    'VERSION_FROM'  => 'lib/CPAN/Testers/Common/Article.pm',
    'PREREQ_PM'     => {
        'Class::Accessor::Fast' => 0,
        'CPAN::DistnameInfo'    => 0,
        'Email::Simple'         => 0,
        'MIME::Base64'          => 0,
        'MIME::QuotedPrint'     => 0,
        'Time::Local'           => 0,

        'IO::File'              => 0,       # only for testing
        'Test::More'            => 0,       # only for testing
    },

    NO_META         => 1,

    ($] >= 5.005 ?    ## Add these new keywords supported since 5.005
      (ABSTRACT	=> 'Parse a CPAN Testers NNTP article',
       AUTHOR	=> 'Barbie <barbie@cpan.org>') : ()),
);
