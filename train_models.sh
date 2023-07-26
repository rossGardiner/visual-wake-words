
source config.cfg

for((i = 0; i < ${#MODEL_NAMES[@]}; i++)); do
    for((j = 0; j < ${#IMAGE_SIZE[@]}; j++)); do
        for ((k = 0; k < ${#USE_GREYSCALE[@]}; k++)); do

            python /tf/models/research/slim/train_image_classifier.py \
                --train_dir="${TRAINING_DIR}/${TRAINING_NAME}_${MODEL_NAMES[i]}_${IMAGE_SIZES[j]}_${USE_GREYSCALE[k]}" \
                --dataset_name=visualwakewords \
                --dataset_split_name="${TRAINING_NAME}" \
                --dataset_dir="${DATA_DIR}"  \
                --model_name="${MODEL_NAMES[i]}" \
                --train_image_size=${IMAGE_SIZES[j]} \
                --use_grayscale=${USE_GRAYSCALE[k]} \
                --save_summaries_secs=300 \
                --learning_rate=${LEARNING_RATE} \
                --label_smoothing=${LABEL_SMOOTHING} \
                --learning_rate_decay_factor=${LEARNING_RATE_DECAY_FACTOR} \
                --num_epochs_per_decay=${NUM_EPOCHS_PER_DECAY} \
                --moving_average_decay=${MOVING_AVERAGE_DECAY} \
                --batch_size=${BATCH_SIZE} \
                --max_number_of_steps=${MAX_NUMBER_OF_STEPS} > "${TRAINING_NAME}_${MODEL_NAMES[i]}_${IMAGE_SIZES[j]}_${USE_GREYSCALE[k]}_output.log" 2>&1
        done
    done 
done