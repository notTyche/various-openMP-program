#!/bin/sh



run_test() {

    >&2 echo " + Running 'Esercizio $1'"

    echo "### Esercizio $1"
    echo ""
    echo "##### Timing:"
    echo "| Threads |    $4         |   $5         |  $6  |"
    echo "|---------|--------------------|--------------------|-------------|"


    export OMP_NUM_THREADS=1


    
    g++ -fopenmp -DPASSI=$4 $3 -o $2

    r1=$(./$2 $7)


    g++ -fopenmp -DPASSI=$5 $3 -o $2

    r2=$(./$2 $7)


    g++ -fopenmp -DPASSI=$6 $3 -o $2

    r3=$(./$2 $7)

    echo "| $OMP_NUM_THREADS       |   $r1         |   $r2         |   $r3  |"



    export OMP_NUM_THREADS=2


    g++ -fopenmp -DPASSI=$4 $3 -o $2

    r4=$(./$2 $7)


    g++ -fopenmp -DPASSI=$5 $3 -o $2

    r5=$(./$2 $7)


    g++ -fopenmp -DPASSI=$6 $3 -o $2

    r6=$(./$2 $7)

    echo "| $OMP_NUM_THREADS       |   $r4         |   $r5         |   $r6  |"



    export OMP_NUM_THREADS=4


    g++ -fopenmp -DPASSI=$4 $3 -o $2

    r7=$(./$2 $7)


    g++ -fopenmp -DPASSI=$5 $3 -o $2

    r8=$(./$2 $7)


    g++ -fopenmp -DPASSI=$6 $3 -o $2

    r9=$(./$2 $7)

    echo "| $OMP_NUM_THREADS       |   $r7         |   $r8         |   $r9  |"



    export OMP_NUM_THREADS=8


    g++ -fopenmp -DPASSI=$4 $3 -o $2

    r10=$(./$2 $7)


    g++ -fopenmp -DPASSI=$5 $3 -o $2

    r11=$(./$2 $7)


    g++ -fopenmp -DPASSI=$6 $3 -o $2

    r12=$(./$2 $7)

    echo "| $OMP_NUM_THREADS       |   $r10         |   $r11        |   $r12  |"



    d1=$(echo "print(\"x%1.3f\" % ($r1/$r4))" | python)
    d2=$(echo "print(\"x%1.3f\" % ($r2/$r5))" | python)
    d3=$(echo "print(\"x%1.3f\" % ($r3/$r6))" | python)
    d4=$(echo "print(\"x%1.3f\" % ($r1/$r7))" | python)
    d5=$(echo "print(\"x%1.3f\" % ($r2/$r8))" | python)
    d6=$(echo "print(\"x%1.3f\" % ($r3/$r9))" | python)
    d7=$(echo "print(\"x%1.3f\" % ($r1/$r10))" | python)
    d8=$(echo "print(\"x%1.3f\" % ($r2/$r11))" | python)
    d9=$(echo "print(\"x%1.3f\" % ($r3/$r12))" | python)

    
    echo ""
    echo "##### Speedup:"
    echo "| Threads |    $4         |   $5         |  $6  |"
    echo "|---------|--------------------|--------------------|-------------|"
    echo "| 1       |    x1.000          |   x1.000           |   x1.000    |"
    echo "| 2       |    $d1          |   $d2           |   $d3    |"
    echo "| 4       |    $d4          |   $d5           |   $d6    |"
    echo "| 8       |    $d7          |   $d8           |   $d9    |"
    echo ""
    echo "-------------------------------------------------------------------"
    echo ""
    echo ""

}




echo "# Spring Bonus"
echo ""


echo ""
echo "Test eseguiti su **$(uname -o)**<br>"
echo " > **Processore:** $(cat /proc/cpuinfo | grep 'model name' | cut -d : -f2 | head -1 | xargs)<br>"
echo " > **Threads:**    $(cat /proc/cpuinfo | grep processor | wc -l)<br>"
echo ""
echo ""
echo ""
    

run_test "1" ex1 src/ex1.cpp 1000000 10000000 100000000
run_test "2" ex2 src/ex2.cpp 1000000 10000000 100000000
run_test "3 (Standard)" ex3 src/ex3.cpp 1000000 10000000 100000000 1
run_test "3 (Reduction)" ex3 src/ex3.cpp 1000000 10000000 100000000 2
run_test "3 (Monte Carlo)" ex3 src/ex3.cpp 1000000 10000000 100000000 3
run_test "4" ex4 src/ex4.cpp 1000000 10000000 100000000
run_test "5 (Game of Life)" "gol -lallegro_image -lallegro_memfile -lallegro_ttf -lallegro_font -lallegro_physfs -lallegro_dialog -lallegro_video -lallegro_acodec -lallegro_main -lallegro_primitives -lallegro_audio -lallegro" src/launch.cpp 1000000 10000000 100000000

echo ""

rm 
>&2 echo "Benchmark completed"
