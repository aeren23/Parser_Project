# Basit if-else testi
x =: 10
y =: 20

if x > y then {
    print "x büyüktür y"
} else {
    print "y büyüktür x"
}

# Loop testi
i =: 0
loop i < 5 {
    i =: i + 1
} {
    print i
}

# Fonksiyon testi
function topla(a, b) {
    return a + b
} endfunc

sonuc =: topla(3, 4)
print "3 + 4 =", sonuc

# İç içe fonksiyon çağrısı
function kare(x) {
    return x * x
} endfunc

print "5'in karesi:", kare(5)