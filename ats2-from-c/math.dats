#define ATS_DYNLOADFLAG 0
#include "share/atspre_staload.hats"

// inline C
%{
int c_get_int(int *p, int i) {
    return p[i];
}
%}

extern fun c_get_int
  (p: ptr, i: int): int = "mac#c_get_int"

extern fun ats_sum_array
  (p: ptr, n: int): int = "ext#ats_sum_array"


// https://ats-lang.sourceforge.net/DOCUMENT/INT2PROGINATS/HTML/x162.html
// val - constant
// var - mutable variable
// let .. in .. end - local scope
// =    equality in expressions and matches
// :=   assignment 
implement ats_sum_array (p, n) = let
  var i: int = 0
  var sum: int = 0
  val () = while (i < n) let
    val x = c_get_int(p, i)
    val () = sum := sum + x
    val () = i := i + 1
  in
  end
in
  sum
end