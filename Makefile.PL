#
# Makefile.PL for Graph-ReadWrite
#
# $Id: Makefile.PL,v 1.3 2002/01/13 13:25:36 neilb Exp $
#

use ExtUtils::MakeMaker;


&WriteMakefile(
                NAME         => 'Graph-ReadWrite',
                DISTNAME     => 'Graph-ReadWrite',
		VERSION      => '1.05',
                PREREQ_PM    => {
                                 'IO::File'   => 0,
                                 'Graph'      => 0,
                                },
                dist         => {COMPRESS => 'gzip', SUFFIX => 'gz'},
              );

