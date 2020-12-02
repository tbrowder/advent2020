use Test;
use Box;

my $o;
# assign values to be used for all class attrs
my $llx = 0;
my $lly = 0;
my $urx = 1;
my $ury = 2;
my $w   = 3;
my $h   = 4;

# object should die during construction if required attrs aren't provided
dies-ok {$o = Box.new: :$llx, :$lly, :$urx}, "begin testing incomplete new args, all tests die-ok";
dies-ok {$o = Box.new: :$llx, :$lly, :$ury};
dies-ok {$o = Box.new: :$lly, :$urx, :$ury};
dies-ok {$o = Box.new: :$llx, :$urx, :$ury};
dies-ok {$o = Box.new: :$llx, :$lly, :$w};
dies-ok {$o = Box.new: :$llx, :$lly, :$h};
dies-ok {$o = Box.new: :$lly, :$w, :$h};
dies-ok {$o = Box.new: :$llx, :$w, :$h}, "end testing incomplete new args";
# builds ok with expected args
lives-ok {$o = Box.new: :$llx, :$lly, :$urx, :$ury}, "builds ok";
lives-ok {$o = Box.new: :$llx, :$lly, :$w, :$h}, "builds ok";

$o = Box.new: :$llx, :$lly, :$w, :$h;
is $o.urx, 3, "given w,h calculate urx,ury";
is $o.ury, 4;

$urx = 1;
$ury = 2;
$o = Box.new: :$llx, :$lly, :$urx, :$ury;
is $o.w, 1, "given urx,ury calculate w,h";
is $o.h, 2;

# test precedence of h,w over ury,urx
$llx = 1;
$lly = 2;
$urx = 2;
$ury = 3;
$w   = 4;
$h   = 5;
$o = Box.new: :$llx, :$lly, :$urx, :$ury, :$w, :$h;
is $o.w, 4, "given urx,ury and w,h use w,h";
is $o.urx, 5;
is $o.h, 5;
is $o.ury, 7;

# ensure urx > llx
$llx = 3;
$urx = 2;
$lly = 2;
$ury = 3;
dies-ok {$o = Box.new: :$llx, :$lly, :$urx, :$ury;}, "invalid: llx > urx (this and all following tests die-ok)";

# ensure ury > lly
$llx = 1;
$urx = 2;
$lly = 2;
$ury = 1;
dies-ok {$o = Box.new: :$llx, :$lly, :$urx, :$ury;}, "invalid: lly > ury";

# ensure w > zero
$llx = 1;
$urx = 1;
$lly = 2;
$ury = 1;
dies-ok {$o = Box.new: :$llx, :$lly, :$urx, :$ury;}, "invalid: w <= zero";

# ensure h > zero
$llx = 1;
$urx = 2;
$lly = 1;
$ury = 1;
dies-ok {$o = Box.new: :$llx, :$lly, :$urx, :$ury;}, "invalid: h <= zero";

done-testing;
