#
# Makefile.PL for Graph-ReadWrite
#

use ExtUtils::MakeMaker;


&WriteMakefile(
        NAME         => 'Graph-ReadWrite',
        DISTNAME     => 'Graph-ReadWrite',
        ABSTRACT     => 'Classes for reading and writing directed graphs',
        AUTHOR       => 'Neil Bowers <neil@bowers.com>',
        VERSION      => '2.02',
        META_MERGE   => {
             resources => {
                repository => 'https://github.com/neilbowers/Graph-ReadWrite',
             },
        },
        PREREQ_PM    => {
                         'IO::File'            => 0,
                         'Graph'               => 0.5,
                         'XML::Parser'         => 0,
                         'XML::Writer'         => 0,
                         'Parse::Yapp::Driver' => 0,
                        },
        dist         => {COMPRESS => 'gzip', SUFFIX => 'gz'},
      );

