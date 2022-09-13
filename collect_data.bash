# this will collect all the numbers and report them to seperate files
# for each dataset
# the output file will be csv format in the following format:
# avg_accuracy, overall_accuracy, kappa, training_time, testing_time, total_time


DATASETS=("BOT" "IP" "PC" "SA" "PU" "KSC" "IP_my_test" "PU_09" "IP_09" "SA_09" "PU_my_test" "SA_my_test")
PARENT_DIR="all_results"
NUM_OF_RUNS=30

DATA_FILE="${PARENT_DIR}/data.txt"
#  make sure the data file is empty
> $DATA_FILE
# place the header
echo "avg_accuracy,overall_accuracy,kappa,training_time,testing_time,total_time" >> $DATA_FILE
for DATASET in "${DATASETS[@]}"
do
    echo "$DATASET\n" >> $DATA_FILE
    # create the output folder for this dataset
    OUTPUT_DIR="${PARENT_DIR}/${DATASET}"

    

    # for each run, collect the data
    for ((i=1; i<= $NUM_OF_RUNS; i++)) do
        # the output file will be named 'result.txt'
        OUTPUT_FILE="${OUTPUT_DIR}/${i}/result.txt"

        if [ -f "$OUTPUT_FILE" ]; then
            echo "$OUTPUT_FILE exists."
            # collect the data
            TOTAL_TIME=$(grep "Total time" -io -e "[+-]?[0-9]+([.][0-9]+)?" $OUTPUT_FILE)
            TRAINING_TIME=$(grep "Training time" -io -e "[+-]?[0-9]+([.][0-9]+)?" $OUTPUT_FILE)
            OVERALL_ACCURACY=$(grep "Overall accuracy" -io -e "[+-]?[0-9]+([.][0-9]+)?" $OUTPUT_FILE)
            AVG_ACCURACY=$(grep "Average accuracy" -io -e "[+-]?[0-9]+([.][0-9]+)?" $OUTPUT_FILE)
            KAPPA=$(grep "Kappa accuracy" -io -e "[+-]?[0-9]+([.][0-9]+)?" $OUTPUT_FILE)
            TESTING_TIME=$(grep "Testing time" -io -e "[+-]?[0-9]+([.][0-9]+)?" $OUTPUT_FILE)

            # append the data to the data file
            echo ",$AVG_ACCURACY,$OVERALL_ACCURACY,$KAPPA,$TRAINING_TIME,$TESTING_TIME,$TOTAL_TIME" >> $DATA_FILE

        fi
    done

    # add a new line to the data file
    echo " " >> $DATA_FILE
    echo " " >> $DATA_FILE
    echo " " >> $DATA_FILE
    echo " " >> $DATA_FILE

done

# myNumbers="0.556
# 1.456
# 45.111
# 7.812
# 5.001"

# standardDeviation=$(
#     echo "$myNumbers" |
#         awk '{sum+=$1; sumsq+=$1*$1}END{print sqrt(sumsq/NR - (sum/NR)**2)}'
# )
# echo $standardDeviation