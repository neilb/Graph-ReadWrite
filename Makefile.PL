#
# Makefile.PL for Graph-ReadWrite
#
# $Id: Makefile.PL,v 1.4 2001/03/18 14:12:01 neilb Exp $
#

use ExtUtils::MakeMaker;


&WriteMakefile(
                NAME         => 'Graph-ReadWrite',
                DISTNAME     => 'Graph-ReadWrite',
		VERSION      => '1.02',
                PREREQ_PM    => {
                                 'IO::File'   => 0,
                                 'Graph'      => 0,
                                },
                dist         => {COMPRESS => 'gzip', SUFFIX => 'gz'},
              );

