#
# Makefile.PL for Graph-ReadWrite
#
# $Id: Makefile.PL,v 1.5 2002/07/03 17:42:11 neilb Exp $
#

use ExtUtils::MakeMaker;


&WriteMakefile(
                NAME         => 'Graph-ReadWrite',
                DISTNAME     => 'Graph-ReadWrite',
		VERSION      => '1.07',
                PREREQ_PM    => {
                                 'IO::File'	=> 0,
                                 'Graph'	=> 0,
				 'XML::Parser'	=> 0,
				 'XML::Writer'	=> 0,
                                },
                dist         => {COMPRESS => 'gzip', SUFFIX => 'gz'},
              );

