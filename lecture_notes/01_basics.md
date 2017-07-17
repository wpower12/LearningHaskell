# Haskell Basics

Haskell is a lazy, functional language.

Function are first-class citizens of the language.  That means they can be treated like variables of any other kind.  You can pass them as parameters to other functions and other cool stuff.

Purity - Haskell programs are referentially transparent.  So everything in the expression is immutable.  The variables and data structures are fixed, they are just read, and then operations are done on the read data.  Also, pure implies that ther are no side effects in any haskell expression.  No data outside of the scope of the expression will change.  Another way to think of this is that calling a function with the same parameters will always result in the same output.  

Laziness - This means that an expression will not be evaluated until its result is needed by another expression.  This allows cool things like infinite data structures. (WAT.) 

Statically typed - Everything, including the first class funcitons have static types that must mesh together at compile time, or you get an error.  Types are a critical componenet of reasoning about a haskell program.  They provide a strong means to check for logical errors, and help document the reasoning of the code.  

## Themes

Types - See above.  

Abstraction - Haskell makes use of parametric polymorpohism, higher-order functions (functions that take and/or return other functions).  These all aid in abstraction.  This is above and beyond 'dont repeat yourself'. 

Wholemeal Programming - Reason about progrmaming by thinking about the data as a whole, and what operations must be executed on it to get a full result.  