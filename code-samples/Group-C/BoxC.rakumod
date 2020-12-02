unit module BoxC;
class Box is export {
    has$.llx;
    has$.lly;
    has$.urx;
    has$.ury;
    has$.w;
    has$.h;
    method width {
        if $!urx.defined {
            $!urx - $!llx
        }
        elsif $!w.defined {
            $!w
        }
    }
}
