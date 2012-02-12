#
# Makefile.PL for Graph-ReadWrite
#

use ExtUtils::MakeMaker;


&WriteMakefile(
                NAME         => 'Graph-ReadWrite',
                DISTNAME     => 'Graph-ReadWrite',
                VERSION      => '2.01',
                PREREQ_PM    => {
                                 'IO::File'     => 0,
                                 'Graph'        => 0.5,
                                 'XML::Parser'  => 0,
                                 'XML::Writer'  => 0,
                                },
                dist         => {COMPRESS => 'gzip', SUFFIX => 'gz'},
              );

