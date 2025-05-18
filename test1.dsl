x =: 5
y =: 10

loop x < 10 {
  print x
  x =: x + 1
}


if x < y then {
  print "x küçüktür y"
} else {
  print "y küçüktür x"
}


function topla(a,b) {
  print a - b
} endfunc

topla(3,5)



