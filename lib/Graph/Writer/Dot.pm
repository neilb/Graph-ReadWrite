#
# Graph::Writer::Dot - write a directed graph out in Dot format
#
# $Id: Dot.pm,v 1.2 2001/11/11 14:24:36 neilb Exp $
#
package Graph::Writer::Dot;

use strict;

use Graph::Writer;
use vars qw(@ISA $VERSION);
$VERSION = sprintf("%d.%02d", q$Revision: 1.2 $ =~ /(\d+)\.(\d+)/);
@ISA = qw(Graph::Writer);

#-----------------------------------------------------------------------
# List of valid dot attributes for the entire graph, per node,
# and per edge. You can set other attributes, but they won't get
# written out.
#-----------------------------------------------------------------------
my %valid_attributes =
(
    graph => [qw(center clusterrank color concentrate fontcolor fontname
		 fontsize label layerseq margin mclimit nodesep nslimit
		 ordering ordering orientation page rank rankdir ranksep
		 ratio size)],
    node  => [qw(color fontcolor fontname fontsize height width label
		 layer shape shapefile style URL)],
    edge  => [qw(color decorate dir fontcolor fontname fontsize id
		 label layer minlen style weight)],
);

#=======================================================================
#
# _init()
#
# class-specific initialisation. There isn't any here, but it's
# kept as a place-holder.
#
#=======================================================================
sub _init
{
    my $self = shift;

    $self->SUPER::_init();
}

#=======================================================================
#
# _write_graph()
#
# The private method which actually does the writing out in
# dot format.
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
    my $gn;
    my %attributes;
    my @keys;


    #-------------------------------------------------------------------
    # If the graph has a 'name' attribute, then we use that for the
    # name of the digraph instance. Else it's just 'g'.
    #-------------------------------------------------------------------
    $gn = $graph->has_attribute('name') ? $graph->get_attribute('name') : 'g';
    print $FILE "digraph $gn\n{\n";

    #-------------------------------------------------------------------
    # Dump out any overall attributes of the graph
    #-------------------------------------------------------------------
    %attributes = $graph->get_attributes();
    @keys = grep(exists $attributes{$_}, @{$valid_attributes{'graph'}});
    if (@keys > 0)
    {
	print $FILE "  /* graph attributes */\n";
	foreach my $a (@keys)
	{
	    print $FILE "  $a = \"$attributes{$a}\";\n";
	}
    }

    #-------------------------------------------------------------------
    # Generate a list of nodes, with attributes for those that have any.
    #-------------------------------------------------------------------
    print $FILE "\n  /* list of nodes */\n";
    foreach $v ($graph->vertices)
    {
	print $FILE "  $v";
	%attributes = $graph->get_attributes($v);
	@keys = grep(exists $attributes{$_}, @{$valid_attributes{'node'}});
	if (@keys > 0)
	{
	    print $FILE " [", join(',', map { "$_=\"$attributes{$_}\"" } @keys), "]";
	}
	print $FILE ";\n";
    }

    #-------------------------------------------------------------------
    # Generate a list of edges, along with any attributes
    #-------------------------------------------------------------------
    print $FILE "\n  /* list of edges */\n";
    my @edges = $graph->edges;
    while (@edges > 0)
    {
	($from, $to) = splice(@edges, 0, 2);
	print $FILE "  $from -> $to";
	%attributes = $graph->get_attributes($from, $to);
	@keys = grep(exists $attributes{$_}, @{$valid_attributes{'edge'}});
	if (@keys > 0)
	{
	    print $FILE " [", join(',', map { "$_ = \"$attributes{$_}\"" } @keys), "]";
	}
	print $FILE ";\n";
    }

    #-------------------------------------------------------------------
    # close off the digraph instance
    #-------------------------------------------------------------------
    print $FILE "}\n";

    return 1;
}

1;

__END__

=head1 NAME

Graph::Writer::Dot - write out directed graph in Dot format

=head1 SYNOPSIS

    use Graph;
    use Graph::Writer::Dot;
    
    $graph = Graph->new();
    # add edges and nodes to the graph
    
    $writer = Graph::Writer::Dot->new();
    $writer->write_graph($graph, 'mygraph.dot');

=head1 DESCRIPTION

B<Graph::Writer::Dot> is a class for writing out a directed graph
in the file format used by the I<dot> tool (part of the AT+T graphviz
package).
The graph must be an instance of the Graph class, which is
actually a set of classes developed by Jarkko Hietaniemi.

=head1 METHODS

=head2 new()

Constructor - generate a new writer instance.

    $writer = Graph::Writer::Dot->new();

This doesn't take any arguments.

=head2 write_graph()

Write a specific graph to a named file:

    $writer->write_graph($graph, $file);

The C<$file> argument can either be a filename,
or a filehandle for a previously opened file.

=head1 SEE ALSO

=over 4

=item http://www.graphviz.org/

The home page for the AT+T graphviz toolkit that
includes the dot tool.

=item Graph

Jarkko Hietaniemi's modules for representing directed graphs,
available from CPAN under modules/by-module/Graph/

=item Algorithms in Perl

The O'Reilly book which has a chapter on directed graphs,
which is based around Jarkko's modules.

=item Graph::Writer

The base-class for Graph::Writer::Dot

=back

=head1 AUTHOR

Neil Bowers E<lt>neil@bowers.comE<gt>

=head1 COPYRIGHT

Copyright (c) 2001, Neil Bowers. All rights reserved.
Copyright (c) 2001, Canon Research Centre Europe. All rights reserved.

This script is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

