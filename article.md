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

The requirements of our class are as follows:
+ immutability after consruction via the default *new* method
+ defined by the lower-left corner and either (1) the upper-right
corner or (2) its width and height

For our exercise observe the following constraints:

+ the rectangle's edges are always parallel to the x or y axes
+ the rectangle's edges have finite length

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
$ cat Box.rakumod
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
~~~

"Ho, ho, ho! Quite the little ASCII artistes aren't we? Let's see Python top that! Now lets try it out...

<!-- sol 1 testb-->
~~~raku
$ raku -I.
> use Box;
> my ($llx, $lly, $urx, $ury) = 0, 0, 2, 3;
> my $o = Box.new: :$llx, :$lly, :$urx, :$ury;
> say $o.width;
2
~~~

Hm, I see at least one problem. You've added all the attributes, but the width method relies on attributes
that may not have been initialized. What if the user had done this:

<!-- sol 1a -->
~~~raku
> my ($llx, $lly, $w, $h) = 0, 0, 2, 3;
> my $o = Box.new: :$llx, :$lly, :$w, $h;
===SORRY=== Error while compiling sol1a
Variable '$urx' is not declared
...
~~~

Boom! How can you handle that to avoid an exception? Another group please take that code and modify it accordingly.

And remove the ASCII art or the reindeer may think it's something good to eat, ho, ho, ho!

Any one? Yes, group C, please show your solution.

<!-- sol 2-->
~~~raku
~~~

That solution will work, but why are we not taking advantage of Raku's default
methods to show the values of public attributes? We shouldn't have to add our
own width method, or any other method. Any ideas!


<!-- sol 3-->
~~~raku
# use BUILD
~~~

Sorry, the BUILD submethod won't work for that without some more code. It doesn't
get access to default values. It can only assign values from arguments in its
signature.

Group B, what do you have?

<!-- sol 4-->
~~~
~~~

Okay, much better, you used the TWEAK submethod to check for valid entries. And very clever to warn
of reversed entries to adjust for lower-left being below and to the left of the upper-right corner!
Note TWEAK was not available in the in the Christmas
release of Raku, but it was added soon thereafter because it is needed so
often in real-world use cases as we've seen.  
(Note also TWEAK is a much better name for an elf than BUILD!)

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

[Santa hears a faint chime from his pocket watch and checks its face...]

Okay, Christmas people, Santa is running behind schedule and I have to
leave you soon. Besides, I don't know much more than you do and you'll
have to dig into the "docs" about class construction in order to get the gory details.
[Here](https://docs.raku.org/language/classtut#index-entry-BUILD) 
and 
[here](https://docs.raku.org/language/objects#Object_construction) 
are two places in particular that address BUILD and TWEAK and their differences.
Also 
seek help from more experienced Rakoons (the friendly community of Raku users) on IRC channel \#raku.

Well done, all! And I'm not going to leave you with an unfinished task.

I'm a pragmatic programmar and business man and "the bottom line in practical class construction is to "cut to the chase," use
the TWEAK submethod and "take care of business." 
Thus we've started to build a practical, robust, and immutable  class
with the aid of the TWEAK submethod. 

Please see my final solution in the APPENDIX below. As they say on IRC, "YMMV" (your mileage may vary).

I'm handing out candy canes and sugar plums for everyone in the class, ho, ho, ho!

Have a very Merry Chistmas, and a Happy New Year to you and your families!

# NOTES

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

# APPENDIX

The final solution (also available on Github at [this repo](https://github.com/tbrowder/advent2020/solution):

The module file **Box.rakumod**:

~~~raku
~~~

The test file contents:

~~~raku
~~~


