use lib '.';
use BoxC;
my ($llx, $lly, $w, $h) = 0, 0, 2, 3;
my $o = Box.new: :$llx, :$lly, :$w, :$h;
say $o.width;
