#
# Makefile.PL for Graph-ReadWrite
#
# $Id: Makefile.PL,v 1.5 2001/04/25 10:25:22 neilb Exp $
#

use ExtUtils::MakeMaker;


&WriteMakefile(
                NAME         => 'Graph-ReadWrite',
                DISTNAME     => 'Graph-ReadWrite',
		VERSION      => '1.03',
                PREREQ_PM    => {
                                 'IO::File'   => 0,
                                 'Graph'      => 0,
                                },
                dist         => {COMPRESS => 'gzip', SUFFIX => 'gz'},
              );

