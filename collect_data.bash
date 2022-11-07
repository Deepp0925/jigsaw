# this will collect all the numbers and report them to seperate files
# for each dataset
# the output file will be csv format in the following format:
# avg_accuracy, overall_accuracy, kappa, training_time, testing_time, total_time


# DATASETS=("BOT" "IP" "PC" "SA" "PU" "KSC" "IP_my_test" "PU_09" "IP_09" "SA_09" "PU_my_test" "SA_my_test")
DATASETS=("PU_org" "IP_org" "SA_org")
PARENT_DIR="all_results"
NUM_OF_RUNS=30

DATA_FILE="${PARENT_DIR}/data_org.txt"
#  make sure the data file is empty
> $DATA_FILE
# place the header
echo "dataset,avg_accuracy,overall_accuracy,kappa,training_time,testing_time,total_time" >> $DATA_FILE
for DATASET in "${DATASETS[@]}"
do

    echo "$DATASET," >> $DATA_FILE
    # create the output folder for this dataset
    OUTPUT_DIR="${PARENT_DIR}/${DATASET}"

    
    TOTAL_TIMES=()
    TOTAL_TIME_MEAN=0
    TRAINING_TIMES=()
    TRAINING_TIME_MEAN=0
    TESTING_TIMES=()
    TESTING_TIME_MEAN=0
    AVG_ACCURACIES=()
    AVG_ACCURACY_MEAN=0
    OVERALL_ACCURACIES=()
    OVERALL_ACCURACY_MEAN=0
    KAPPAS=()
    KAPPA_MEAN=0

    # for each run, collect the data
    for ((i=1; i<= $NUM_OF_RUNS; i++)) do
        # the output file will be named 'result.txt'
        OUTPUT_FILE="${OUTPUT_DIR}/${i}/result.txt"

        if [ -f "$OUTPUT_FILE" ]; then
            echo "$OUTPUT_FILE exists."
            # collect the data
            TOTAL_TIME=$(grep -i "total time" $OUTPUT_FILE | egrep '(\.?[0-9]?)*' -ow)
            TOTAL_TIMES+=($TOTAL_TIME)
            # add the total time to the mean
            TOTAL_TIME_MEAN=$(echo "$TOTAL_TIME_MEAN + $TOTAL_TIME" | bc -l)

            TRAINING_TIME=$(grep -i "training time" $OUTPUT_FILE |  egrep '(\.?[0-9]?)*' -ow)
            TRAINING_TIMES+=($TRAINING_TIME)
            # add the training time to the mean
            TRAINING_TIME_MEAN=$(echo "$TRAINING_TIME_MEAN + $TRAINING_TIME" | bc -l)

            TESTING_TIME=$(grep -i "testing time" $OUTPUT_FILE |  egrep '(\.?[0-9]?)*' -ow)
            TESTING_TIMES+=($TESTING_TIME)
            # add the testing time to the mean
            TESTING_TIME_MEAN=$(echo "$TESTING_TIME_MEAN + $TESTING_TIME" | bc -l)

            OVERALL_ACCURACY=$(grep -i "overall accuracy" $OUTPUT_FILE |  egrep '(-?\.?[0-9]?)*' -ow)
            OVERALL_ACCURACIES+=($OVERALL_ACCURACY)
            # add the overall accuracy to the mean
            OVERALL_ACCURACY_MEAN=$(echo "$OVERALL_ACCURACY_MEAN + $OVERALL_ACCURACY" | bc -l)

            AVG_ACCURACY=$(grep -i "average accuracy" $OUTPUT_FILE |  egrep '(-?\.?[0-9]?)*' -ow)
            AVG_ACCURACIES+=($AVG_ACCURACY)
            # add the average accuracy to the mean
            AVG_ACCURACY_MEAN=$(echo "$AVG_ACCURACY_MEAN + $AVG_ACCURACY" | bc -l)

            KAPPA=$(grep -i "kappa accuracy" $OUTPUT_FILE |  egrep '(-?\.?[0-9]?)*' -ow)
            KAPPAS+=($KAPPA)
            # add the kappa to the mean
            KAPPA_MEAN=$(echo "$KAPPA_MEAN + $KAPPA" | bc -l)

            # append the data to the data file
            echo ",$AVG_ACCURACY,$OVERALL_ACCURACY,$KAPPA,$TRAINING_TIME,$TESTING_TIME,$TOTAL_TIME" >> $DATA_FILE

        fi
    done

    # compute the mean
    TOTAL_TIME_MEAN=$(echo "$TOTAL_TIME_MEAN / $NUM_OF_RUNS" | bc -l)
    TRAINING_TIME_MEAN=$(echo "$TRAINING_TIME_MEAN / $NUM_OF_RUNS" | bc -l)
    TESTING_TIME_MEAN=$(echo "$TESTING_TIME_MEAN / $NUM_OF_RUNS" | bc -l)
    AVG_ACCURACY_MEAN=$(echo "$AVG_ACCURACY_MEAN / $NUM_OF_RUNS" | bc -l)
    OVERALL_ACCURACY_MEAN=$(echo "$OVERALL_ACCURACY_MEAN / $NUM_OF_RUNS" | bc -l)
    KAPPA_MEAN=$(echo "$KAPPA_MEAN / $NUM_OF_RUNS" | bc -l)

    # compute the standard deviation
    TOTAL_TIME_STD=0
    TRAINING_TIME_STD=0
    TESTING_TIME_STD=0
    AVG_ACCURACY_STD=0
    OVERALL_ACCURACY_STD=0
    KAPPA_STD=0

    for ((i=0; i< $NUM_OF_RUNS; i++)) do
        TOTAL_TIME_STD=$(echo "$TOTAL_TIME_STD + (${TOTAL_TIMES[$i]} - $TOTAL_TIME_MEAN)^2" | bc -l)
        TRAINING_TIME_STD=$(echo "$TRAINING_TIME_STD + (${TRAINING_TIMES[$i]} - $TRAINING_TIME_MEAN)^2" | bc -l)
        TESTING_TIME_STD=$(echo "$TESTING_TIME_STD + (${TESTING_TIMES[$i]} - $TESTING_TIME_MEAN)^2" | bc -l)
        AVG_ACCURACY_STD=$(echo "$AVG_ACCURACY_STD + (${AVG_ACCURACIES[$i]} - $AVG_ACCURACY_MEAN)^2" | bc -l)
        OVERALL_ACCURACY_STD=$(echo "$OVERALL_ACCURACY_STD + (${OVERALL_ACCURACIES[$i]} - $OVERALL_ACCURACY_MEAN)^2" | bc -l)
        KAPPA_STD=$(echo "$KAPPA_STD + (${KAPPAS[$i]} - $KAPPA_MEAN)^2" | bc -l)
    done

    TOTAL_TIME_STD=$(echo "sqrt($TOTAL_TIME_STD / $NUM_OF_RUNS)" | bc -l)
    TRAINING_TIME_STD=$(echo "sqrt($TRAINING_TIME_STD / $NUM_OF_RUNS)" | bc -l)
    TESTING_TIME_STD=$(echo "sqrt($TESTING_TIME_STD / $NUM_OF_RUNS)" | bc -l)
    AVG_ACCURACY_STD=$(echo "sqrt($AVG_ACCURACY_STD / $NUM_OF_RUNS)" | bc -l)
    OVERALL_ACCURACY_STD=$(echo "sqrt($OVERALL_ACCURACY_STD / $NUM_OF_RUNS)" | bc -l)
    KAPPA_STD=$(echo "sqrt($KAPPA_STD / $NUM_OF_RUNS)" | bc -l)

    # append the mean and standard deviation to the data file
    echo "mean,$AVG_ACCURACY_MEAN,$OVERALL_ACCURACY_MEAN,$KAPPA_MEAN,$TRAINING_TIME_MEAN,$TESTING_TIME_MEAN,$TOTAL_TIME_MEAN" >> $DATA_FILE
    echo "std dev.,$AVG_ACCURACY_STD,$OVERALL_ACCURACY_STD,$KAPPA_STD,$TRAINING_TIME_STD,$TESTING_TIME_STD,$TOTAL_TIME_STD" >> $DATA_FILE
    echo ",$AVG_ACCURACY_MEAN +- $AVG_ACCURACY_STD,$OVERALL_ACCURACY_MEAN +- $OVERALL_ACCURACY_STD,$KAPPA_MEAN +- $KAPPA_STD,$TRAINING_TIME_MEAN +- $TRAINING_TIME_STD,$TESTING_TIME_MEAN +- $TESTING_TIME_STD,$TOTAL_TIME_MEAN +- $TOTAL_TIME_STD" >> $DATA_FILE


    # add a new line to the data file    
    echo " " >> $DATA_FILE
    echo " " >> $DATA_FILE
done
