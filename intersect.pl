$a = -45520;
$b = 2.97319e-05;

$a2 = 1;
$b2 = 7.51659e-07;

# $a + $b * x = $a2 + $b2* x

# $b * x = $a2 + $b2 * x - a

# ($b * x) - ($b2 * x) = $a2 - a

# ($b - $b2) * x = $a2 - $a

# x = ($a2 - $a) / ($b - $b2)

$x = ($a2 - $a) /($b - $b2);

print $x;