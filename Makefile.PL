#
# Makefile.PL for Graph-ReadWrite
#
# $Id: Makefile.PL,v 1.2 2005/01/02 19:06:58 neilb Exp $
#

use ExtUtils::MakeMaker;


&WriteMakefile(
                NAME         => 'Graph-ReadWrite',
                DISTNAME     => 'Graph-ReadWrite',
		VERSION      => '2.00',
                PREREQ_PM    => {
                                 'IO::File'	=> 0,
                                 'Graph'	=> 0.5,
				 'XML::Parser'	=> 0,
				 'XML::Writer'	=> 0,
                                },
                dist         => {COMPRESS => 'gzip', SUFFIX => 'gz'},
              );

