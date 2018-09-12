set terminal svg enhanced size 800,600
set output 'file.svg'
set title "ASL Digital Burnup Chart"

set timefmt "%Y%m%d"
set format x "%Y%m%d"
set xdata time
set xrange ["20180701":"20191201"]
set yrange [0:1700]
set xtics rotate
set xtics rotate
set xtics nomirror "20180701", 1209600, "20191201"
set ytics 

set style line 1 lt 1 lw 2 pt 3 ps 0.5
set style line 2 lt 2 lw 2 pt 3 ps 0.5
set style line 3 lt 3 lw 2 pt 3 ps 0.5
set style line 4 lt 4 lw 2 pt 3 ps 0.5
set style line 5 lt 8 lw 2 pt 3 ps 0.5
set style line 6 lt 6 lw 2 pt 3 ps 0.5
set style line 7 lt 7 lw 2 pt 3 ps 0.5


f(x)=a+b*x
a = 1
b = 1e-8
fit [strptime("%Y%m%d","20180601"):strptime("%Y%m%d","21390801")] f(x) datafile u 1:2 via a,b

a2 = 1 
b2 = 1 
f2(x) = a2 + b2 * x 
fit [strptime("%Y%m%d","20180601"):strptime("%Y%m%d","21390801")] f2(x) datafile u 1:3 via a2, b2 

plot datafile using 1:2 with lines ls 7 title 'Done',\
     f(x) with lines ls 4 dt 3 title 'Expected Done', \
     f2(x) with lines ls 3 dt 4 title 'Expected Backlog', \
datafile using 1:3 with lines ls 6 title "Total Backlog"

