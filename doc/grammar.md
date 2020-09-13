# Pikchr Grammar

This file describes the grammar of the input files to Pikchr.  Keywords
and operators are shown in **bold**.  Non-terminal symbols are shown
in *italic*.  Special token classes are shown in ALL-CAPS.  A grammar
symbol followed by "*" means zero-or-more.  A grammar symbol
followed by "?" means zero-or-one.  Parentheses are used for grouping.
Two grammar symbols within "(..|..)" means one or the other.
"&lambda;" means a null production rule.

The following special token classes are recognized:

  *  NEWLINE  &rarr;  A un-escaped newline character, U+000A.
     A backslash followed by zero or more whitespace characters
     and then a U+000A character is interpreted as ordinary whitespace,
     not as a NEWLINE.

  *  LABEL  &rarr;  An object or place label starting with an
     upper-case ASCII letter and continuing with zero or more
     ASCII letters, digits, and/or underscores.  A LABEL always starts
     with an upper-case letter.

  *  VARIABLE  &rarr;  A variable name consisting of a lower-case
     ASCII letter or "$" or "@" and followed by zero or more
     ASCII letters, digits, and/or underscores.  VARIABLEs may
     contain upper-case letter, but they never begin with an upper-case.
     In this way, VARIABLEs are distinct from LABELs.

  *  NUMBER  &rarr;  A numeric literal.  The value can be a decimal
     integer, a floating point value, or a hexadecimal literal
     starting with "0x".  Decimal and floating point values can
     optionally by a two-character unit designator which is one
     of:  "in", "cm", "px", "pt", "pc", or "mm".  There can be
     no whitespace in between the numeric portion of the constant and
     the unit.

  *  ORDINAL  &rarr;  A non-zero integer literal followed by one of the
     suffixes "st", "nd", "rd", or "th".  Examples: "1st", "2nd",
    "3rd", "4th", "5th", and so forth.   As a special case, "first"
     is accepted as a special-case spelling of "1st".

  *  STRING  &rarr;  A string literal that begins and ends with
     double-quotes (U+0022).  Within the string literal, a double-quote
     character can be escaped using backslash (U+005c).  A backslash
     can also be used to escape a backslash.  No other escape sequences
     are recognized.

  *  OBJCLASS &rarr;  The name of a graphics object class.  One of:
     "arc", "arrow", "box", "circle", "cylinder", "dot", "ellipse",
     "file", "line", "move", "oval", "spline", or "text".  New object
     classes may be added in future releases.

  *  COLORNAME &rarr;  One of the 140 official HTML color names, in 
     any mixture of upper and lower cases.  The value of a COLORNAME is
     an integer which is the 24-bit RGB value of that color.  Two
     additional color names of "None" and "Off" are also recognized and
     have a value of -1.


A complete input file to Pikchr consists of a single *statement-list*.

## *statement-list*:
  * *statement* 
  * *statement-list* NEWLINE *statement*
  * *statement-list* **;** *statement*

## *statement*:
  * &lambda;
  * *object-definition*
  * LABEL **:** *object-definition*
  * LABEL **:** *place*
  * *direction*
  * VARIABLE *assignment-op* *expr*
  * **print** *print-argument* (**,** *print-argument*)\*

## *direction*:
  * **right**
  * **down**
  * **left**
  * **right**

## *assignment-op*:
  * **=**
  * **+=**
  * **-=**
  * **\*=**
  * **/=**

## *print-argument*:
  * *expr*
  * STRING

## *object-definition*:
  * OBJCLASS *attribute*\*
  * STRING *text-attribute*\* *attribute*\*
  * **[** *statement-list* **]** *attribute*\*

## *attribute*:
  * *path-element*
  * *location-attribute*
  * STRING *text-attribute*\*
  * **same**
  * **same as** *object*
  * *numeric-property* *expr*
  * *numeric-property* *expr* **%**
  * **dashed** *expr*?
  * **dotted** *expr*?
  * **color** *expr*
  * **fill** *expr*
  * **behind** *object*
  * **cw**
  * **ccw**
  * **&lt;-**
  * **-&gt;**
  * **&lt;-&gt;**
  * **invis**
  * **invisible**
  * **thick**
  * **thin**
  * **chop**
  * **fit**

## *numeric-property*:
  * **width**
  * **wid**
  * **height**
  * **ht**
  * **radius**
  * **rad**
  * **diameter**
  * **thickness**

## *text-attribute*:
  * **above**
  * **below**
  * **ljust**
  * **rjust**
  * **bold**
  * **italic**
  * **big**
  * **small**
  * **aligned**

## *path-element*:
  * **from** *position*
  * **to** *position*
  * **then**? **go**? *direction* *expr*? **%**?
  * **then**? **go**? *direction* **until**? **even with** *place*
  * (**then**|**go**) *expr*? **heading** *expr*
  * (**then**|**go**) *expr*? *compass-direction*
  * **close**

## *compass-direction*:
  * **n**
  * **north**
  * **ne**
  * **e**
  * **east**
  * **se**
  * **s**
  * **south**
  * **sw**
  * **w**
  * **west**
  * **nw**

## *location-attribute*:
  * **at** *position*
  * **with** *edgename* **at** *position*
  * **with** *dot-edgename* **at** *position*

## *position*:

  *  *expr* **,** *expr*
  *  *place*
  *  *place* **+** *expr* **,** *expr*
  *  *place* **-** *expr* **,** *expr*
  *  *place* **+(** *expr* **,** *expr* **)**
  *  *place* **-(** *expr* **,** *expr* **)**
  *  **(** *position* **,** *position* **)**
  *  **(** *position* **)**
  *  *expr* **of the way between** *position* **and** *position*
  *  *expr* **way between** *position* **and** *position*
  *  *expr* **between** *position* **and** *position*
  *  *expr* **<** *position* **,** *position* **>**
  *  *expr* *heading-from* *position*

## *heading-from*:

  *  **above**
  *  **below**
  *  **right of**
  *  **left of**
  *  **n of**
  *  **north of**
  *  **ne of**
  *  **e of**
  *  **east of**
  *  **se of**
  *  **s of**
  *  **south of**
  *  **sw of**
  *  **w of**
  *  **west of**
  *  **nw of**
  *  **heading** *expr* **from**

## *place*:

  *  *object*
  *  *object* *dot-edgename*
  *  *edgename* **of** *object*
  *  ORDINAL **vertex of** *object*

## *object*:
  *  LABEL
  *  *object* **.** LABEL
  *  *nth-object* **of**|**in** *object*

## *nth-object*:

  *  ORDINAL OBJCLASS
  *  ORDINAL **last** OBJCLASS
  *  ORDINAL **previous** OBJCLASS
  *  **last** OBJCLASS
  *  **previous** OBJCLASS
  *  **last**
  *  **previous**
  *  ORDINAL **[]**
  *  ORDINAL **last []**
  *  ORDINAL **previous []**
  *  **last []**
  *  **previous []**

## *dot-edgename*:
  * **.n**
  * **.north**
  * **.t**
  * **.top**
  * **.ne**
  * **.e**
  * **.east**
  * **.right**
  * **.se**
  * **.s**
  * **.south**
  * **.bot**
  * **.bottom**
  * **.sw**
  * **.w**
  * **.west**
  * **.left**
  * **.nw**
  * **.c**
  * **.start**
  * **.end**

## *edgename*:
  * **n**
  * **north**
  * **ne**
  * **e**
  * **east**
  * **se**
  * **s**
  * **south**
  * **sw**
  * **w**
  * **west**
  * **nw**
  * **t**
  * **top**
  * **bot**
  * **bottom**
  * **left**
  * **right**
  * **start**
  * **end**


## *expr*:

  *  NUMBER
  *  VARIABLE
  *  COLORNAME
  *  *place* **.x**
  *  *place* **.y**
  *  *object* *dot-property*
  *  **(** *expr* **)**
  *  *expr* **+** *expr*
  *  *expr* **-** *expr*
  *  *expr* **\*** *expr*
  *  *expr* **/** *expr*
  *  **-** *expr*
  *  **+** *expr*
  *  **abs(** *expr* **)**
  *  **cos(** *expr* **)**
  *  **int(** *expr* **)**
  *  **sin(** *expr* **)**
  *  **sqrt(** *expr* **)**
  *  **max(** *expr* **,** *expr* **)**
  *  **min(** *expr* **,** *expr* **)**

## *dot-property*:

  * **.wid**
  * **.width**
  * **.ht**
  * **.height**
  * **.rad**
  * **.radius**
  * **.diameter**
  * **.thickness**
  * **.dashed**
  * **.dotted**
  * **.color**
  * **.fill**
