use lib '.';
use BoxA;
my ($llx, $lly, $urx, $ury) = 0, 0, 2, 3;
my $o = Box.new: :$llx, :$lly, :$urx, :$ury;
say $o.width;
