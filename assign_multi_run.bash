DATASETS=("BOT" "IP" "PC" "SA" "PU" "KSC" "IP_my_test" "PU_09" "IP_09" "SA_09" "PU_my_test" "SA_my_test")

for DATASET in "${DATASETS[@]}"
do
    echo "Running dataset $DATASET"
    sbatch multi_run.bash $DATASET
done