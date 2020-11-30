unit class Box;

# must define all two:
has $.llx;
has $.lly;

# must define one of the two:
has $.urx;
has $.w;
# must define one of the two:
has $.ury;
has $.h;

submethod TWEAK() {
    # check mandatory attrs
    my $err = 0;
    my $msg = "FATAL: class Box undefined attr(s):\n";
    if not $!llx.defined {
        ++$err;
        $msg ~= "\$llx\n";
    }
    if not $!lly.defined {
        ++$err;
        $msg ~= "\$lly\n";
    }
    if not $!urx.defined and not $!w.defined {
        ++$err;
        $msg ~= "\$urx and \$w\n";
    }
    if not $!ury.defined and not $!h.defined {
        ++$err;
        $msg ~= "\$ury and \$h\n";
    }
    die $msg if $err;
     
    # h vs ury
    # h has precedence over ury
    if $!h.defined {
        $!ury = $!lly + $!h;
    }
    elsif $!ury.defined {
        $!h   = $!ury - $!lly;
    }
    # w vs urx
    # w has precedence over urx
    if $!w.defined {
       $!urx = $!llx + $!w;
    }
    elsif $!urx.defined {
       $!w   = $!urx - $!llx;
    }

    $msg = "FATAL: class Box has invalid attr(s):\n";
    # ensure urx > llx 
    if $!urx < $!llx {
        ++$err;
        $msg ~= "\$llx > \$urx\n";
    }
    # ensure ury > lly
    if $!ury < $!lly {
        ++$err;
        $msg ~= "\$lly > \$ury\n";
    }
    # ensure w > 0
    if $!w <= 0 {
        ++$err;
        $msg ~= "\$w <= zero\n";
    }
    # ensure h > 0
    if $!h <= 0 {
        ++$err;
        $msg ~= "\$h <= zero\n";
    }
    die $msg if $err;
}
