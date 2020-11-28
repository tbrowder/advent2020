TWEAKing with Class

Santa was browsing the etrade magazines on his iPad one morning and
came across an
[article](https://www.wealthsimple.com/en-ca/magazine/cobol-controls-your-money?utm_medium=email&utm_source=topic+optin&utm_campaign=awareness&utm_content=20201121+prog+nl&mkt_tok=eyJpIjoiTmpWa1pEWTJNRE13WldZNSIsInQiOiJJXC9PQ1JRQWRvdjNhMWhHS0NmdHFnVE9kNGQ0Z3h5RXpMWm0wN0VlVHFYb1pvNTRrbUdlSVE0a09CSTAxKzVuVVltbzBtUjdKb3RzYVp5Z240Q2x1WUhhQlByWmRQNUJyNFBcL0d6c0Y1NGRXbU0yWUtHQ2xtN0luR0RIV3JtWjFjIn0%3D)
referenced in the latest *O'Reilly Programming Newsletter* about how
ancient COBOL is the programming language still used for the bulk of
the world's business software.

He had been aware of that since his operations had always been at the
forefront of big business practice over the cenruries, and he was very
proud of the cutting edge efficiencies in his maximally-automated toy
factories.

He had been keeping a keen eye (filled with a twinkle) on Larry Wall's
new [Raku](https://raku.org) language since its formal release on
Christmas Day in 2015, and decided it was time to incorporate its use
in his new five-year plan. (After all, he mused, it is supposed to be
the "100 year language.") He soon called a meeting of his IT staff
leaders to get the ball rolling.

At the meeting he handed out copies of Dr. Juan Merelo's new book,
[Raku Recipes](https://www.apress.com/gp/book/9781484262573), to
inspire the coding cowboys in the crowd. "Now people, let's start at
the beginning and teach [Raku](https://raku.org) as the initial
programming language for IT students at the North Pole University. In
the meantime, make sure all current IT coders have a copy of JJ's
book, and I expect them to start learning to use Raku in their spare
time" he said with a chuckle.  "And have them all join the \#raku IRC
channel" he added.

[Some weeks later, Santa was the guest instructor in a beginning Raku class. We
listen in as he deals with class design. Santa is speaking...]

Let's look at a practical case for class submethods. We are rewriting
our page layout software for our publishing department.  As you may
know, we have now started writing PDF directly using David Warring's
fine [Raku PDF modules](https://pdf-raku.github.io), but we also do a
lot of automated document production with PostScript. In both cases we
use the convention of describing the location of page objects (text,
images, etc.) as a 2D reference of x,y coordinates with the default
origin at the lower-left corner of the page with the positive x and y
axes pointing to the right and up, respectively.

For today's class exercise, divide yourselves into two-elf teams and
come up with a Raku class to describe rectangular areas on a page that
will contain text or images. You all had geometry in high school, but
perhaps a little review is in order.

A rectangle is a quadrilateral (a four-sided plane figure) with
opposite sides parallel and adjacent sides at right angles to each
other. Adjacent sides may be of different lengths. Note we will not
consider rectangles with zero-length edges as valid.

A free-floating rectangle can be precisely defined by its width and length.
A fixed rectangle on an orthogonal x,y plane must have one of its diagonals
defined by either the coordinates of its two endpoints or one endpoint and
the diagonal's angle from one of the positive x-axis.

For our exercise observe the following constraints:

+ the rectangle's edges are always parallel to the x or y axes
+ the class attributes must be defined at creation time and will be immutable after successful construction
+ rectangles should have their corners in the positive x,y quadrant

Your work should have at least the necessary attributes to define and
position your class. You should also have code to show the creation of
an instance of your class.

You may start and will have a few minutes to complete the
assignment. Raise your hands when finished--the first group to finish
gets a candy cane. :-D

...

Okay, group A show your class.

<!-- sol 1 -->
~~~raku
#!/usr/bin/env raku
class Box {

                        ;
                       ;;;
                        ;
                       ;;;
                      ;;;;;
                     ;;;;;;;
                    ;;has$.h;
                   ;;;;;;;;;;;
                  ;;;has$.urx;;
                 ;;;;;;;;;;;;;;;
                ;;;has$.ury;;;;;;
               ;;;;;;;;;;;;;;;;;;;
              ;;;;;;;;;;;;has$.w;;;
             ;;;has$.llx;;;;;;;;;;;;
            ;;;;;;;;;;;;;;;;;;;;;;;;;
           ;;;;;;;;;;;;;;has$.lly;;;;;
          ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                       ;;;
                     ;;;;;;;

    method width {
        $!urx - $!llx
    }
}
my ($llx, $lly, $urx, $ury) = 0, 0, 2, 3;
my $o = Box.new: :$llx, :$lly, :$urx, :$ury;
say $o.width;
~~~

"Ho, ho, ho! Quite the little ASCII artistes aren't we? Let's see Python top that! Now lets try it out...

<!-- test 1 -->
~~~
$ raku -I.
> use Box;
> my ($llx, $lly, $urx, $ury) = 0, 0, 2, 3;
> my $o = Box.new: :$llx, :$lly, :$urx, :$ury;
> say $o.width;
~~~

Hm, I see at least one problem. You've added all the attributes, but the width method relies on attributes
that may not have been initialized. What if the user had done this:

~~~
> my ($llx, $lly, $w, $h) = 0, 0, 2, 3;
> my $o = Box.new: :$llx, :$lly, :$w, $h;
> say $o.width;
~~~

How can you handle that? Another group take that code and modify it accordingly.

And please remove the ASCII art or the reindeer may think it's tundra grass, ho, ho, ho!

Any one? Yes, group C, please show your solution.

<!-- sol 2-->
~~~
# use BUILD
~~~

And your

"Sorry, the BUILD submethod won't work for that. Group B, what do you have?

<!-- sol 4-->
~~~
~~~

Okay, much better, you used the TWEAK submethod to check for valid entries. And very clever to warn
of reversed entries to adjust for lower-left being below and to the left of the upper-right corner!

However, you
haven't allowed for any other way to create the Box object other than entering
the lower-left corner and upper-right corner coordinates. Does any other group have a solution
for entering a corner along with the width and height?

Group D, please show it.

<!-- sol 5-->
~~~
~~~

Okay, very good. But still only one method of entry.
Let's learn from the demonstrations so far and integrate the useful things into a final
solution. And this time, for extra credit, add tests for your class.

<!-- sol 6-->
~~~
~~~

Well done, all. I'm handing out candy canes and sugar plums for everyone in the class, ho, ho, ho!

Have a very Merry Chistmas and a Happy New Year to you and your families!





APPENDIX

For inspiration for this article I thank my friend JJ Merelo and his
new book *Raku Recipes* (mentioned above).

The Santa Claus inspiration was from
watching a rerun of the wonderful 1994 movie *The Santa Clause* starring Tim Allen.
(Note there were also the sequels *The Santa Clause 2*, released in 2002, and
*The Santa Clause 3: The Escape Clause*, released in 2006.) In case you've never heard
the population of Santa's North Pole being estimated at over one million elves, I
point you to this year's movie, [The Christmas Chronicles 2](https://www.imdb.com/title/tt11057644/?ref_=fn_al_tt_1),
and ask the question: how
do you suppose millions of children could be left gifts by Santa on Christmas
without an operation with resources greater than Amazon, Fed EX, UPS, and the USPS combined?
