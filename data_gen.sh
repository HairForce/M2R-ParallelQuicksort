OUTPUT_DIR=data/$1
mkdir -p $OUTPUT_DIR
mkdir -p $OUTPUT_DIR/csvs

	cd ./src
	make clean
	make
	cd ..

for NB in 1 2 5 10 20; do
	mkdir -p $OUTPUT_DIR/$NB
	OUTPUT_FILE=$OUTPUT_DIR/$NB/measures.txt
	touch OUTPUT_FILE
	for j in 100 1000 10000 100000 1000000 10000000; do
		for rep in `seq 1 50`; do	

			echo "Size: $j" >> $OUTPUT_FILE;
			./src/parallelQuicksort $j >> $OUTPUT_FILE;
		done ;
	done;

	perl ./scripts/csv_quicksort_extractor.pl < $OUTPUT_FILE > $OUTPUT_DIR/csvs/$NB'_ThreadsRaw'.csv
	perl ./scripts/csv_quicksort_extractor2.pl < $OUTPUT_FILE > $OUTPUT_DIR/csvs/$NB'_Threads'.csv
done;

