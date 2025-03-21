GPUS=0

array=( $@ )
len=${#array[@]}
EXTRA_ARGS=${array[@]:1:$len}
EXTRA_ARGS_SLUG=${EXTRA_ARGS// /_}

source ~/miniconda3/bin/activate robosyn

CUDA_VISIBLE_DEVICES=${GPUS} \
python -m debugpy --listen 5679 --wait-for-client ./isaacgymenvs/train.py headless=True \
task.env.objSet=C task=AllegroArmMOAR task.env.axis=z \
task.env.numEnvs=8192 train.params.config.minibatch_size=16384 \
train.params.config.central_value_config.minibatch_size=16384 \
task.env.observationType=full_stack_pointcloud task.env.legacy_obs=True \
task.env.ablation_mode=no-pc experiment=z-axis \
train.params.config.user_prefix=z-axis wandb_activate=True \
${EXTRA_ARGS}