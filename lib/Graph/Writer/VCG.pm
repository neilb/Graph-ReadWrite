#
# Graph::Writer::VCG - write a directed graph out in VCG format
#
# $Id: VCG.pm,v 1.2 2001/02/08 18:46:29 neilb Exp $
#
package Graph::Writer::VCG;

use strict;

use Graph::Writer;
use vars qw(@ISA $VERSION);
$VERSION = sprintf("%d.%02d", q$Revision: 1.2 $ =~ /(\d+)\.(\d+)/);
@ISA = qw(Graph::Writer);

#=======================================================================
#
# _write_graph()
#
# The private method which actually does the writing out in
# VCG format.
#
# This is called from the public method, write_graph(), which is
# found in Graph::Writer.
#
#=======================================================================
sub _write_graph
{
    my $self  = shift;
    my $graph = shift;
    my $FILE  = shift;

    my $v;
    my $from;
    my $to;


    print $FILE "graph: {\n";

    foreach $v ($graph->vertices)
    {
	print $FILE "  node: { title: \"$v\" }\n";
    }

    my @edges = $graph->edges;
    while (@edges > 0)
    {
	($from, $to) = splice(@edges, 0, 2);
	print $FILE "  edge: { sourcename: \"$from\" targetname: \"$to\" }\n";
    }

    print $FILE "}\n";

    return 1;
}

1;

__END__

=head1 NAME

Graph::Writer::VCG - write out directed graph in VCG format

=head1 SYNOPSIS

    use Graph;
    use Graph::Writer::VCG;
    
    $graph = Graph->new();
    # add edges and nodes to the graph
    
    $writer = Graph::Writer::VCG->new();
    $writer->write_graph($graph, 'mygraph.vcg');

=head1 DESCRIPTION

B<Graph::Writer::VCG> is a class for writing out a directed graph
in the file format used by the I<VCG> tool, originally developed
for Visualising Compiler Graphs.
The graph must be an instance of the Graph class, which is
actually a set of classes developed by Jarkko Hietaniemi.

=head1 METHODS

=head2 new()

Constructor - generate a new writer instance.

    $writer = Graph::Writer::VCG->new();

This doesn't take any arguments.

=head2 write_graph()

Write a specific graph to a named file:

    $writer->write_graph($graph, $file);

The C<$file> argument can either be a filename,
or a filehandle for a previously opened file.

=head1 KNOWN BUGS

Currently doesn't do anything with attributes -
only the structure of the graph is written out.

=head1 SEE ALSO

=over 4

=item http://www.cs.uni-sb.de/RW/users/sander/html/gsvcg1.html

The home page for VCG.

=item Graph

Jarkko Hietaniemi's modules for representing directed graphs,
available from CPAN under modules/by-module/Graph/

=item Algorithms in Perl

The O'Reilly book which has a chapter on directed graphs,
which is based around Jarkko's modules.

=item Graph::Writer

The base-class for Graph::Writer::VCG

=back

=head1 AUTHOR

Neil Bowers E<lt>neilb@cre.canon.co.ukE<gt>

=head1 COPYRIGHT

Copyright (c) 2001, Canon Research Centre Europe. All rights reserved.

This script is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

