#!/bin/bash
cleanup() {
    echo "Stopping the script and cleaning up..."
    exit 1
}

trap cleanup SIGINT

source config.cfg


#function to map model names to preprocessing names
mapped_values=()

for value in "${MODEL_NAMES[@]}"; do
    case "$value" in
        mobilenet_v1*) mapped_values+=("mobilenet_v1") ;;
        mobilenet_v2*) mapped_values+=("mobilenet_v2") ;;
        mobilenet_v3*) mapped_values+=("mobilenet_v3") ;;
        *) mapped_values+=("$value") ;;
    esac
done

export TF_FORCE_GPU_ALLOW_GROWTH="true"


for((i = 0; i < ${#MODEL_NAMES[@]}; i++)); do
    for((j = 0; j < ${#IMAGE_SIZES[@]}; j++)); do
        for ((k = 0; k < ${#USE_GRAYSCALE[@]}; k++)); do

            python /tf/models/research/slim/train_image_classifier.py \
                --train_dir="${TRAINING_DIR}/${TRAINING_NAME}_${MODEL_NAMES[i]}_${IMAGE_SIZES[j]}_${USE_GRAYSCALE[k]}" \
                --dataset_name=visualwakewords \
                --dataset_split_name="${TRAINING_NAME}" \
                --dataset_dir="${DATA_DIR}"  \
                --model_name="${MODEL_NAMES[i]}" \
                --preprocessing_name=${mapped_values[i]} \
                --train_image_size=${IMAGE_SIZES[j]} \
                --use_grayscale=${USE_GRAYSCALE[k]} \
                --save_summaries_secs=300 \
                --learning_rate=${LEARNING_RATE} \
                --label_smoothing=${LABEL_SMOOTHING} \
                --learning_rate_decay_factor=${LEARNING_RATE_DECAY_FACTOR} \
                --num_epochs_per_decay=${NUM_EPOCHS_PER_DECAY} \
                --moving_average_decay=${MOVING_AVERAGE_DECAY} \
                --batch_size=${BATCH_SIZE} \
                --max_number_of_steps=${MAX_NUMBER_OF_STEPS} > "${TRAINING_DIR}/${TRAINING_NAME}_${MODEL_NAMES[i]}_${IMAGE_SIZES[j]}_${USE_GRAYSCALE[k]}_output.log" 2>&1
        done
    done 
done
