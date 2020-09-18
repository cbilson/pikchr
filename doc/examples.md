# Pikchr Examples

## Usage Note

~~~ pikchr toggle
box color red wid 2.6in \
    "Click on any diagram on this page" big \
    "to see the Pikchr source text" big

~~~

## How To Build Pikchr

~~~ pikchr toggle
            filewid *= 1.2
  Src:      file "pikchr.y"; move
  LemonSrc: file "lemon.c"; move
  Lempar:   file "lempar.y"; move
            arrow down from LemonSrc.s
  CC1:      oval "C-Compiler" ht 50%
            arrow " generates" ljust above
  Lemon:    oval "lemon" ht 50%
            arrow from Src chop down until even with CC1 \
              then to Lemon.nw rad 20px
            "Pikchr source " rjust "code input " rjust \
              at 2nd vertex of previous
            arrow from Lempar chop down until even with CC1 \
              then to Lemon.ne rad 20px
            " parser template" ljust " resource file" ljust \
              at 2nd vertex of previous
  PikSrc:   file "pikchr.c" with .n at lineht below Lemon.s
            arrow from Lemon to PikSrc chop
            arrow down from PikSrc.s
  CC2:      oval "C-Compiler" ht 50%
            arrow
  Out:      file "pikchr.o" "or" "pikchr.exe" wid 110%
~~~


## Syntax diagrams

~~~ pikchr toggle
$r = 0.2in
linerad = 0.75*$r
linewid = 0.25

# Start and end blocks
#
box "element" bold fit
line down 50% from last box.sw
dot rad 250% color black
X0: last.e + (0.3,0)
arrow from last dot to X0
move right 3.9in
box wid 5% ht 25% fill black
X9: last.w - (0.3,0)
arrow from X9 to last box.w


# The main rule that goes straight through from start to finish
#
box "object-definition" italic fit width 70% at 11/16 way between X0 and X9
arrow to X9
arrow from X0 to last box.w

# The LABEL: rule
#
arrow right $r from X0 then down 1.25*$r then right $r
oval " LABEL " fit
arrow 50%
oval "\":\"" fit
arrow 200%
box "position" italic fit
arrow
line right until even with X9 - ($r,0) \
  then up until even with X9 then to X9
arrow from last oval.e right $r*0.5 then up $r*0.8 right $r*0.8
line up $r*0.45 right $r*0.45 then right

# The VARIABLE = rule
#
arrow right $r from X0 then down 2.5*$r then right $r
oval " VARIABLE " fit
arrow 70%
box "assignment-operator" italic fit width 80%
arrow 70%
box "expr" italic fit
line right until even with X9 - ($r,0) \
  then up until even with X9 then to X9

# The PRINT rule
#
arrow right $r from X0 then down 3.75*$r then right $r
oval "\"print\"" fit
arrow
box "print-args" italic fit
line right until even with X9 - ($r,0) \
  then up until even with X9 then to X9
~~~

## Swimlanes

From the [Branching, Forking, Merging, and Tagging][bfmt] paper on
the Fossil website.

[bfmt]: https://fossil-scm.org/fossil/doc/trunk/www/branching.wiki

~~~ pikchr toggle
    $laneh = 0.75

    # Draw the lanes
    down
    box width 3.5in height $laneh fill 0xacc9e3
    box same fill 0xc5d8ef
    box same as first box
    box same as 2nd box
    line from 1st box.sw+(0.2,0) up until even with 1st box.n \
      "Alan" above aligned
    line from 2nd box.sw+(0.2,0) up until even with 2nd box.n \
      "Betty" above aligned
    line from 3rd box.sw+(0.2,0) up until even with 3rd box.n \
      "Charlie" above aligned
    line from 4th box.sw+(0.2,0) up until even with 4th box.n \
       "Darlene" above aligned

    # fill in content for the Alice lane
    right
A1: circle rad 0.1in at end of first line + (0.2,-0.2) \
       fill white thickness 1.5px "1" 
    arrow right 50%
    circle same "2"
    arrow right until even with first box.e - (0.65,0.0)
    ellipse "future" fit fill white height 0.2 width 0.5 thickness 1.5px
A3: circle same at A1+(0.8,-0.3) "3" fill 0xc0c0c0
    arrow from A1 to last circle chop "fork!" below aligned

    # content for the Betty lane
B1: circle same as A1 at A1-(0,$laneh) "1"
    arrow right 50%
    circle same "2"
    arrow right until even with first ellipse.w
    ellipse same "future"
B3: circle same at A3-(0,$laneh) "3"
    arrow right 50%
    circle same as A3 "4"
    arrow from B1 to 2nd last circle chop

    # content for the Charlie lane
C1: circle same as A1 at B1-(0,$laneh) "1"
    arrow 50%
    circle same "2"
    arrow right 0.8in "goes" "offline"
C5: circle same as A3 "5"
    arrow right until even with first ellipse.w \
      "back online" above "pushes 5" below "pulls 3 &amp; 4" below
    ellipse same "future"

    # content for the Darlene lane
D1: circle same as A1 at C1-(0,$laneh) "1"
    arrow 50%
    circle same "2"
    arrow right until even with C5.w
    circle same "5"
    arrow 50%
    circle same as A3 "6"
    arrow right until even with first ellipse.w
    ellipse same "future"
D3: circle same as B3 at B3-(0,2*$laneh) "3"
    arrow 50%
    circle same "4"
    arrow from D1 to D3 chop
~~~



## PIC Examples From The [Brian W. Kernighan paper][bwk]

[bwk]: /uv/pic.pdf

-----

From page 18.  This example had to be modified slighly to expand
the macro by hand.

~~~ pikchr toggle
# Change from the original:
#    * Expand the macro by hand, as Pikchr does not support
#      macros
#
#define ndblock {
#  box wid boxwid/2 ht boxht/2
#  down;  box same with .t at bottom of last box;   box same
#}
boxht = .2; boxwid = .3; circlerad = .3; dx = 0.05
down; box; box; box; box ht 3*boxht "." "." "."
L: box; box; box invis wid 2*boxwid "hashtab:" with .e at 1st box .w
right
Start: box wid .5 with .sw at 1st box.ne + (.4,.2) "..."
N1: box wid .2 "n1";  D1: box wid .3 "d1"
N3: box wid .4 "n3";  D3: box wid .3 "d3"
box wid .4 "..."
N2: box wid .5 "n2";  D2: box wid .2 "d2"
arrow right from 2nd box
#ndblock
  box wid boxwid/2 ht boxht/2
  down;  box same with .t at bottom of last box;   box same
spline -> right .2 from 3rd last box then to N1.sw + (dx,0)
spline -> right .3 from 2nd last box then to D1.sw + (dx,0)
arrow right from last box
#ndblock
  box wid boxwid/2 ht boxht/2
  down;  box same with .t at bottom of last box;   box same
spline -> right .2 from 3rd last box to N2.sw-(dx,.2) to N2.sw+(dx,0)
spline -> right .3 from 2nd last box to D2.sw-(dx,.2) to D2.sw+(dx,0)
arrow right 2*linewid from L
#ndblock
  box wid boxwid/2 ht boxht/2
  down;  box same with .t at bottom of last box;   box same
spline -> right .2 from 3rd last box to N3.sw + (dx,0)
spline -> right .3 from 2nd last box to D3.sw + (dx,0)
circlerad = .3
circle invis "ndblock"  at last box.e + (1.2,.2)
arrow dashed from last circle.w to 5/8<last circle.w,2nd last box> chop
box invis wid 2*boxwid "ndtable:" with .e at Start.w
~~~


-----

From page 19:  The length of the line for "intermediate code" had to
be lengthened so that the text would fit.

~~~ pikchr toggle
        arrow "source" "code"
LA:     box "lexical" "analyzer"
        arrow "tokens" above
P:      box "parser"
        arrow "intermediate" "code" wid 200%
Sem:    box "semantic" "checker"
        arrow
        arrow <-> up from top of LA
LC:     box "lexical" "corrector"
        arrow <-> up from top of P
Syn:    box "syntactic" "corrector"
        arrow up
DMP:    box "diagnostic" "message" "printer"
        arrow <-> right  from east of DMP
ST:     box "symbol" "table"
        arrow from LC.ne to DMP.sw
        arrow from Sem.nw to DMP.se
        arrow <-> from Sem.top to ST.bot
~~~

------

From page 20:  Various minor tweaks

~~~ pikchr toggle
        circle "DISK"
        arrow "character" "defns" right 150%
CPU:    box "CPU" "(16-bit mini)"
        arrow <- from top of CPU up "input " rjust
        arrow right from CPU.e
CRT:    "   CRT" ljust wid 1px
        line from CRT - 0,0.075 up 0.15 \
                then right 0.5 \
                then right 0.5 up 0.25 \
                then down 0.5+0.15 \
                then left 0.5 up 0.25 \
                then left 0.5
Paper:  CRT + 1.05,0.75
        arrow <- from Paper down 1.5
        " ...  paper" ljust at end of last arrow + 0, 0.25
        circle rad 0.05 at Paper + (-0.055, -0.25)
        circle rad 0.05 at Paper + (0.055, -0.25)
        "   rollers" ljust at Paper + (0.1, -0.25)
~~~
