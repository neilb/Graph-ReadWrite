#
# Makefile.PL for Graph-ReadWrite
#
# $Id: Makefile.PL,v 1.2 2001/02/08 18:49:04 neilb Exp $
#

use ExtUtils::MakeMaker;


&WriteMakefile(
                NAME         => 'Graph-ReadWrite',
                DISTNAME     => 'Graph-ReadWrite',
		VERSION      => '1.00',
		# VERSION_FROM => 'lib/Graph/Writer.pm',
                PREREQ_PM    => {
                                 'IO::File'   => 0,
                                 'Graph'      => 0,
                                },
                dist         => {COMPRESS => 'gzip', SUFFIX => 'gz'},
              );

