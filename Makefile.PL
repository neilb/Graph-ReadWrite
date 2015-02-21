#
# Makefile.PL for Graph-ReadWrite
#

use ExtUtils::MakeMaker;

my $mm_ver = $ExtUtils::MakeMaker::VERSION;
if ($mm_ver =~ /_/) { # dev version
    $mm_ver = eval $mm_ver;
    die $@ if $@;
}

&WriteMakefile(
    NAME         => 'Graph::ReadWrite',
    DISTNAME     => 'Graph-ReadWrite',
    ABSTRACT     => 'Classes for reading and writing directed graphs',
    AUTHOR       => 'Neil Bowers <neil@bowers.com>',
    VERSION      => '2.07',
    LICENSE      => 'perl',

    ($mm_ver <= 6.45
        ? ()
        : (META_MERGE => {
            'meta-spec' => { version => 2 },
            resources => {
                bugtracker  => 'http://rt.cpan.org/Public/Dist/Display.html?Name=Graph-ReadWrite',
                repository  => {
                    type => 'git',
                    web  => 'https://github.com/neilbowers/Graph-ReadWrite',
                    url  => 'git://github.com/neilbowers/Graph-ReadWrite.git',
                },
            },
          })
    ),

    PREREQ_PM    => {
                     'IO::File'            => 0,
                     'Graph'               => 0.5,
                     'XML::Parser'         => 0,
                     'XML::Writer'         => 0,
                     'Parse::Yapp::Driver' => 0,
                     'parent'              => 0,
                     'Carp'                => 0,
                     'File::Compare'       => 0,
                    },

    ($mm_ver >= 6.48
        ? (MIN_PERL_VERSION => 5.006)
        : ()
    ),

    ($mm_ver >= 6.52
        ? (CONFIGURE_REQUIRES => {
                'ExtUtils::MakeMaker' => 6.30,
          })
        : ()
    ),

    dist         => {COMPRESS => 'gzip', SUFFIX => 'gz'},
);

