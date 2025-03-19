GPUS=0

array=( $@ )
len=${#array[@]}
EXTRA_ARGS=${array[@]:1:$len}
EXTRA_ARGS_SLUG=${EXTRA_ARGS// /_}

source ~/miniconda3/bin/activate robosyn

CUDA_VISIBLE_DEVICES=${GPUS} \
python ./isaacgymenvs/train_distillation.py headless=True \
task.env.legacy_obs=False distill.bc_training=warmup \
task.env.objSet=C task.env.is_distillation=True \
task=AllegroArmMOAR task.env.numEnvs=64 \
task.env.axis=z \
train.params.config.minibatch_size=1024 \
train.params.config.central_value_config.minibatch_size=1024 \
task.env.observationType=full_stack_pointcloud \
distill.ablation_mode=multi-modality-plus \
task.env.ablation_mode=multi-modality-plus \
distill.teacher_data_dir=demonstration-z \
distill.student_logdir=runs/student/bc-z \
train.params.config.user_prefix=bc-z \
experiment=bc-z wandb_activate=True \
${EXTRA_ARGS}