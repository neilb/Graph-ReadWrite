#
# Makefile.PL for Graph-ReadWrite
#
# $Id: Makefile.PL,v 1.2 2001/11/11 14:29:36 neilb Exp $
#

use ExtUtils::MakeMaker;


&WriteMakefile(
                NAME         => 'Graph-ReadWrite',
                DISTNAME     => 'Graph-ReadWrite',
		VERSION      => '1.04',
                PREREQ_PM    => {
                                 'IO::File'   => 0,
                                 'Graph'      => 0,
                                },
                dist         => {COMPRESS => 'gzip', SUFFIX => 'gz'},
              );

