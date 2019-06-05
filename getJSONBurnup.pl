#! /usr/local/bin/perl
use strict;
use warnings;
use 5.010;
use Cwd;
use lib cwd;
use JSON::Parse 'json_file_to_perl';
use Data::Dumper;
my $file = shift || die "No filename";

my $p = json_file_to_perl ($file);
my $DEBUG = 0;
my $progress = 0;
my $total = 0;
my $INPROGRESS = 'In Progress';
my $DONE = 'Done';
my $NOTSTARTED = 'Not Started';
my %cards_hash;
my %lists_hash;
my @cards = @{$p->{cards}};
foreach my $card (@cards)
{
        $cards_hash{$card->{name}} = $card->{idList};
}

my @lists = @{$p->{lists}};
foreach my $list (@lists)
{
	if (!$list->{closed})
	{	
		$lists_hash{$list->{id}} = $list->{name};
	}
}

foreach my $cardName (keys %cards_hash)
{
	my $colText = $lists_hash{$cards_hash{$cardName}};
                if (($colText) &&
		(($colText =~ /$NOTSTARTED/) || ($colText =~ /$INPROGRESS/) || ($colText =~ /$DONE/)))
                {
                        $cardName =~ /\[\s*?(\d+)\s*?Points\s*?\]/i;
                        my $points = $1;
                        if($points)
			{
                        	$total += $points;
				print "$cardName is $points points - total is $total ";
			}
                         
                        if (($colText =~ /$INPROGRESS/) &&               
                                ($cardName =~ /\[\s*?(\d+)\s*?\%\s*?\]/))
                        {
				print $cardName;
                                my $percentage = $1;
                                print "percentage is $percentage";
                                $progress += $points * ($percentage/100);
                                 print "Progress is $progress";
                        }
                        if ($colText =~ /$DONE/)
                        {
                                if($points)
				{
					$progress += $points;
				}
                        }
                        print "\n";
                }
}
my $date = `date +%Y%m%d`;
$date =~s/\n+//;
say "Total is $total";
say "Progress is $progress";
print "$date $progress $total";
