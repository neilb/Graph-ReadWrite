#
# Graph::Writer::XML - write a directed graph out as XML
#
# $Id: XML.pm,v 1.3 2001/03/18 14:10:17 neilb Exp $
#
package Graph::Writer::XML;

use Graph::Writer;
use XML::Writer;

use vars qw(@ISA $VERSION);
$VERSION = sprintf("%d.%02d", q$Revision: 1.3 $ =~ /(\d+)\.(\d+)/);
@ISA = qw(Graph::Writer);


#=======================================================================
#
# _write_graph() - perform the writing of the graph
#
# This is invoked from the public write_graph() method,
# and is where the actual writing of the graph happens.
#
# Basically we start a graph element then:
#	[] dump out any attributes of the graph
#	[] dump out all vertices, with any attributes of each vertex
#	[] dump out all edges, with any attributes of each edge
# And then close the graph element. Ta da!
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
    my %attributes;
    my $xmlwriter;


    $xmlwriter = XML::Writer->new(OUTPUT      => $FILE,
                                  DATA_MODE   => 1,
                                  DATA_INDENT => 2);
    $xmlwriter->setOutput($FILE);

    $xmlwriter->startTag('graph');

    #-------------------------------------------------------------------
    # dump out attributes of the graph, if it has any
    #-------------------------------------------------------------------
    %attributes = $graph->get_attributes();
    foreach my $attr (keys %attributes)
    {
	$xmlwriter->emptyTag('attribute', 
				'name' => $attr,
				'value' => $attributes{$attr});
    }

    #-------------------------------------------------------------------
    # dump out vertices of the graph, including any attributes
    #-------------------------------------------------------------------
    foreach $v ($graph->vertices)
    {
	%attributes = $graph->get_attributes($v);

	if (keys %attributes > 0)
	{
	    $xmlwriter->startTag('node', 'id' => $v);

	    foreach my $attr (keys %attributes)
	    {
		$xmlwriter->emptyTag('attribute', 
					'name' => $attr,
					'value' => $attributes{$attr});
	    }

	    $xmlwriter->endTag('node');
	}
	else
	{
	    $xmlwriter->emptyTag('node', 'id' => $v);
	}
    }

    #-------------------------------------------------------------------
    # dump out edges of the graph, including any attributes
    #-------------------------------------------------------------------
    my @edges = $graph->edges;
    while (@edges > 0)
    {
	($from, $to) = splice(@edges, 0, 2);
	%attributes = $graph->get_attributes($from, $to);
	if (keys %attributes > 0)
	{
	    $xmlwriter->startTag('edge', 'from' => $from, 'to' => $to);

	    foreach my $attr (keys %attributes)
	    {
		$xmlwriter->emptyTag('attribute', 
					'name' => $attr,
					'value' => $attributes{$attr});
	    }

	    $xmlwriter->endTag('edge');
	}
	else
	{
	    $xmlwriter->emptyTag('edge', 'from' => $from, 'to' => $to);
	}
    }

    $xmlwriter->endTag('graph');
    $xmlwriter->end();

    return 1;
}

1;

__END__

=head1 NAME

Graph::Writer::XML - write out directed graph as XML

=head1 SYNOPSIS

    use Graph;
    use Graph::Writer::XML;
    
    $graph = Graph->new();
    # add edges and nodes to the graph
    
    $writer = Graph::Writer::XML->new();
    $writer->write_graph($graph, 'mygraph.xml');

=head1 DESCRIPTION

B<Graph::Writer::XML> is a class for writing out a directed graph
in a simple XML format.
The graph must be an instance of the Graph class, which is
actually a set of classes developed by Jarkko Hietaniemi.

The XML format is designed to support the Graph classes:
it can be used to represent a single graph with a collection
of nodes, and edges between those nodes.
The graph, nodes, and edges can all have attributes specified,
where an attribute is a (name,value) pair, with the value being scalar.

=head1 METHODS

=head2 new()

Constructor - generate a new writer instance.

    $writer = Graph::Writer::XML->new();

This doesn't take any arguments.

=head2 write_graph()

Write a specific graph to a named file:

    $writer->write_graph($graph, $file);

The C<$file> argument can either be a filename,
or a filehandle for a previously opened file.

=head1 KNOWN BUGS

No attempt is made to validate the XML in any formal way.

Attribute values must be scalar. If they're not, well,
you're on your own.

=head1 SEE ALSO

=over 4

=item XML::Writer

The perl module used to actually write out the XML.
It handles entities etc.

=item Graph

Jarkko Hietaniemi's modules for representing directed graphs,
available from CPAN under modules/by-module/Graph/

=item Algorithms in Perl

The O'Reilly book which has a chapter on directed graphs,
which is based around Jarkko's modules.

=item Graph::Writer

The base-class for Graph::Writer::XML

=back

=head1 AUTHOR

Neil Bowers E<lt>neilb@cre.canon.co.ukE<gt>

=head1 COPYRIGHT

Copyright (c) 2001, Canon Research Centre Europe. All rights reserved.

This script is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

