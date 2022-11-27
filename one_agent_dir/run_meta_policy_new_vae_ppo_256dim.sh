# Using custom env
# Karel custom env: cleanHouse, harvester, fourCorners, randomMaze, stairClimber, topOff
# class ExecEnv_option
# class ProgramEnv_option (task_definition == custom_reward)


# PPO for harvester
#CUDA_VISIBLE_DEVICES="0" python3 pretrain/trainer_option_new_vae_L30.py --configfile pretrain/cfg_option_new_vae.py --datadir placeholder --mdp_type ProgramEnv_option_new_vae_v2  --num_lstm_cell_units 256 --algorithm PPO_option --net.saved_params_path pretrain/output_dir_vae_L30_1m_20epoch/LEAPSL_tanh_epoch20_L30_1m_h256_u256_option_latent_p1_gru-handwritten-123-20220926-232556/best_valid_params.ptp --net.num_rnn_encoder_units 256 --net.num_rnn_decoder_units 256 --net.use_linear False --net.latent_mean_pooling False  --env_task harvester --rl.envs.executable.task_definition custom_reward  --max_program_len 40 --dsl.max_program_len 40 --prefix PPO_option_harvester_L38_step5_dim256_video --seed 123 --PPO.num_processes 16 --PPO.lr 1e-5 --PPO.num_steps 800 --PPO.num_mini_batch 10 --PPO.num_env_steps 20e6 --PPO.entropy_coef 0.05 --PPO.hidden_size 256 --log_interval 1 --save_interval 50 --log_video_interval 25 --outdir pretrain/output_dir_ppo_ablation_L38 --max_episode_steps 5 --input_channel 8

# PPO for cleanHouse
#CUDA_VISIBLE_DEVICES="3" python3 pretrain/trainer_option_new_vae_L30.py --configfile pretrain/cfg_option_new_vae.py --datadir placeholder --mdp_type ProgramEnv_option_new_vae_v2  --num_lstm_cell_units 256 --algorithm PPO_option --net.saved_params_path pretrain/output_dir_vae_L30_1m_20epoch/LEAPSL_tanh_epoch20_L30_1m_h256_u256_option_latent_p1_gru-handwritten-123-20220926-232556/best_valid_params.ptp --net.num_rnn_encoder_units 256 --net.num_rnn_decoder_units 256 --net.use_linear False --net.latent_mean_pooling False  --env_task cleanHouse --rl.envs.executable.task_definition custom_reward  --max_program_len 40 --dsl.max_program_len 40 --prefix PPO_option_cleanHouse_L38_step5_dim256 --seed 123 --PPO.num_processes 16 --PPO.lr 1e-5 --PPO.num_steps 800 --PPO.num_mini_batch 10 --PPO.num_env_steps 20e6 --PPO.entropy_coef 0.05 --PPO.hidden_size 256 --log_interval 1 --save_interval 50 --log_video_interval 200 --outdir pretrain/output_dir_ppo_ablation_L38 --max_episode_steps 5 --input_channel 8 --input_height 14 --input_width 22


# PPO for fourCorners
#CUDA_VISIBLE_DEVICES="4" python3 pretrain/trainer_option_new_vae_L30.py --configfile pretrain/cfg_option_new_vae.py --datadir placeholder --mdp_type ProgramEnv_option_new_vae_v2  --num_lstm_cell_units 256 --algorithm PPO_option --net.saved_params_path pretrain/output_dir_vae_L30_1m_20epoch/LEAPSL_tanh_epoch20_L30_1m_h256_u256_option_latent_p1_gru-handwritten-123-20220926-232556/best_valid_params.ptp --net.num_rnn_encoder_units 256 --net.num_rnn_decoder_units 256 --net.use_linear False --net.latent_mean_pooling False  --env_task fourCorners --rl.envs.executable.task_definition custom_reward  --max_program_len 40 --dsl.max_program_len 40 --prefix PPO_option_fourCorners_L38_step5_dim256 --seed 123 --PPO.num_processes 16 --PPO.lr 1e-5 --PPO.num_steps 800 --PPO.num_mini_batch 10 --PPO.num_env_steps 20e6 --PPO.entropy_coef 0.05 --PPO.hidden_size 256 --log_interval 1 --save_interval 50 --log_video_interval 200 --outdir pretrain/output_dir_ppo_ablation_L38 --max_episode_steps 5 --input_channel 8


# PPO for randomMaze
#CUDA_VISIBLE_DEVICES="3" python3 pretrain/trainer_option_new_vae_L30.py --configfile pretrain/cfg_option_new_vae.py --datadir placeholder --mdp_type ProgramEnv_option_new_vae_v2  --num_lstm_cell_units 256 --algorithm PPO_option --net.saved_params_path pretrain/output_dir_vae_L30_1m_20epoch/LEAPSL_tanh_epoch20_L30_1m_h256_u256_option_latent_p1_gru-handwritten-123-20220926-232556/best_valid_params.ptp --net.num_rnn_encoder_units 256 --net.num_rnn_decoder_units 256 --net.use_linear False --net.latent_mean_pooling False  --env_task randomMaze --rl.envs.executable.task_definition custom_reward  --max_program_len 40 --dsl.max_program_len 40 --prefix PPO_option_randomMaze_L38_step5_dim256 --seed 123 --PPO.num_processes 16 --PPO.lr 1e-5 --PPO.num_steps 800 --PPO.num_mini_batch 10 --PPO.num_env_steps 20e6 --PPO.entropy_coef 0.05 --PPO.hidden_size 256 --log_interval 1 --save_interval 50 --log_video_interval 200 --outdir pretrain/output_dir_ppo_ablation_L38 --max_episode_steps 5 --input_channel 8

# PPO for stairClimber_sparse
#CUDA_VISIBLE_DEVICES="0" python3 pretrain/trainer_option_new_vae_L30.py --configfile pretrain/cfg_option_new_vae.py --datadir placeholder --mdp_type ProgramEnv_option_new_vae_v2  --num_lstm_cell_units 256 --algorithm PPO_option --net.saved_params_path pretrain/output_dir_vae_L30_1m_20epoch/LEAPSL_tanh_epoch20_L30_1m_h256_u256_option_latent_p1_gru-handwritten-123-20220926-232556/best_valid_params.ptp --net.num_rnn_encoder_units 256 --net.num_rnn_decoder_units 256 --net.use_linear False --net.latent_mean_pooling False  --env_task stairClimber_sparse --rl.envs.executable.task_definition custom_reward  --max_program_len 40 --dsl.max_program_len 40 --prefix PPO_option_stairClimber_sparse_L38_step5_dim256 --seed 123 --PPO.num_processes 16 --PPO.lr 1e-5 --PPO.num_steps 800 --PPO.num_mini_batch 10 --PPO.num_env_steps 20e6 --PPO.entropy_coef 0.05 --PPO.hidden_size 256 --log_interval 1 --save_interval 50 --log_video_interval 200 --outdir pretrain/output_dir_ppo_ablation_L38 --max_episode_steps 5 --input_channel 8


# PPO for topOff_sparse
#CUDA_VISIBLE_DEVICES="0" python3 pretrain/trainer_option_new_vae_L30.py --configfile pretrain/cfg_option_new_vae.py --datadir placeholder --mdp_type ProgramEnv_option_new_vae_v2  --num_lstm_cell_units 256 --algorithm PPO_option --net.saved_params_path pretrain/output_dir_vae_L30_1m_20epoch/LEAPSL_tanh_epoch20_L30_1m_h256_u256_option_latent_p1_gru-handwritten-123-20220926-232556/best_valid_params.ptp --net.num_rnn_encoder_units 256 --net.num_rnn_decoder_units 256 --net.use_linear False --net.latent_mean_pooling False  --env_task topOff_sparse --rl.envs.executable.task_definition custom_reward  --max_program_len 40 --dsl.max_program_len 40 --prefix PPO_option_topOff_sparse_L38_step5_dim256 --seed 123 --PPO.num_processes 16 --PPO.lr 1e-5 --PPO.num_steps 800 --PPO.num_mini_batch 10 --PPO.num_env_steps 20e6 --PPO.entropy_coef 0.05 --PPO.hidden_size 256 --log_interval 1 --save_interval 50 --log_video_interval 200 --outdir pretrain/output_dir_ppo_ablation_L38 --max_episode_steps 5 --input_channel 8

# PPO for randomMaze key2door
#CUDA_VISIBLE_DEVICES="2" python3 pretrain/trainer_option_new_vae_L30.py --configfile pretrain/cfg_option_new_vae.py --datadir placeholder --mdp_type ProgramEnv_option_new_vae_v2_key2door  --num_lstm_cell_units 256 --algorithm PPO_option --net.saved_params_path pretrain/output_dir_vae_L30_1m_20epoch/LEAPSL_tanh_epoch20_L30_1m_h256_u256_option_latent_p1_gru-handwritten-123-20220926-232556/best_valid_params.ptp --net.num_rnn_encoder_units 256 --net.num_rnn_decoder_units 256 --net.use_linear False --net.latent_mean_pooling False  --env_task randomMaze_key2door --rl.envs.executable.task_definition custom_reward  --max_program_len 40 --dsl.max_program_len 40 --prefix PPO_option_key2door_fixedMap_nonStopNonStageFlexReward_penalty0p1_L38_step5_dim256_recurrent --seed 123 --PPO.num_processes 16 --PPO.lr 1e-5 --PPO.num_steps 800 --PPO.num_mini_batch 10 --PPO.num_env_steps 20e6 --PPO.entropy_coef 0.05 --PPO.hidden_size 256 --log_interval 1 --save_interval 50 --log_video_interval 50 --outdir pretrain/output_dir_ppo_karel_hard_L38 --max_episode_steps 5 --input_channel 8 --logging.wandb False --PPO.recurrent_policy True #--fixed_input True

# PPO for oneStroke
#CUDA_VISIBLE_DEVICES="2" python3 pretrain/trainer_option_new_vae_L30.py --configfile pretrain/cfg_option_new_vae.py --datadir placeholder --mdp_type ProgramEnv_option_new_vae_v2_key2door  --num_lstm_cell_units 256 --algorithm PPO_option --net.saved_params_path pretrain/output_dir_vae_L30_1m_20epoch/LEAPSL_tanh_epoch20_L30_1m_h256_u256_option_latent_p1_gru-handwritten-123-20220926-232556/best_valid_params.ptp --net.num_rnn_encoder_units 256 --net.num_rnn_decoder_units 256 --net.use_linear False --net.latent_mean_pooling False  --env_task oneStroke --rl.envs.executable.task_definition custom_reward  --max_program_len 40 --dsl.max_program_len 40 --prefix PPO_option_oneStroke_randomInitPos_penalty0p1_L38_step5_dim256_recurrent --seed 123 --PPO.num_processes 16 --PPO.lr 1e-5 --PPO.num_steps 800 --PPO.num_mini_batch 10 --PPO.num_env_steps 20e6 --PPO.entropy_coef 0.05 --PPO.hidden_size 256 --log_interval 1 --save_interval 50 --log_video_interval 50 --outdir pretrain/output_dir_ppo_karel_hard_L38 --max_episode_steps 5 --input_channel 8 --logging.wandb False --PPO.recurrent_policy True #--fixed_input True

# PPO for doorkey
#CUDA_VISIBLE_DEVICES="2" python3 pretrain/trainer_option_new_vae_L30.py --configfile pretrain/cfg_option_new_vae.py --datadir placeholder --mdp_type ProgramEnv_option_new_vae_v2_key2door_fixed  --num_lstm_cell_units 256 --algorithm PPO_option --net.saved_params_path pretrain/output_dir_vae_L30_1m_20epoch/LEAPSL_tanh_epoch20_L30_1m_h256_u256_option_latent_p1_gru-handwritten-123-20220926-232556/best_valid_params.ptp --net.num_rnn_encoder_units 256 --net.num_rnn_decoder_units 256 --net.use_linear False --net.latent_mean_pooling False  --env_task doorkey --rl.envs.executable.task_definition custom_reward  --max_program_len 40 --dsl.max_program_len 40 --prefix PPO_option_doorkey_fixInitPos_penalty0p1_L38_step5_dim256_recurrent_fixedInput --seed 123 --PPO.num_processes 16 --PPO.lr 1e-5 --PPO.num_steps 800 --PPO.num_mini_batch 10 --PPO.num_env_steps 20e6 --PPO.entropy_coef 0.05 --PPO.hidden_size 256 --log_interval 1 --save_interval 50 --log_video_interval 50 --outdir pretrain/output_dir_ppo_karel_hard_L38 --max_episode_steps 5 --input_channel 8 --logging.wandb False --PPO.recurrent_policy True #--fixed_input True

# PPO for oneStroke
#CUDA_VISIBLE_DEVICES="4" python3 pretrain/trainer_option_new_vae_L30.py --configfile pretrain/cfg_option_new_vae.py --datadir placeholder --mdp_type ProgramEnv_option_new_vae_v2_key2door_fixed  --num_lstm_cell_units 256 --algorithm PPO_option --net.saved_params_path pretrain/output_dir_vae_L30_1m_20epoch/LEAPSL_tanh_epoch20_L30_1m_h256_u256_option_latent_p1_gru-handwritten-123-20220926-232556/best_valid_params.ptp --net.num_rnn_encoder_units 256 --net.num_rnn_decoder_units 256 --net.use_linear False --net.latent_mean_pooling False  --env_task oneStroke --rl.envs.executable.task_definition custom_reward  --max_program_len 40 --dsl.max_program_len 40 --prefix PPO_option_oneStroke_randomInitPos_penalty0p1_L38_step5_dim256_recurrent_fixedInput --seed 123 --PPO.num_processes 16 --PPO.lr 1e-5 --PPO.num_steps 800 --PPO.num_mini_batch 10 --PPO.num_env_steps 20e6 --PPO.entropy_coef 0.05 --PPO.hidden_size 256 --log_interval 1 --save_interval 50 --log_video_interval 50 --outdir pretrain/output_dir_ppo_karel_hard_L38 --max_episode_steps 5 --input_channel 8 --logging.wandb False --PPO.recurrent_policy True #--fixed_input True

# PPO for oneStroke
CUDA_VISIBLE_DEVICES="5" python3 pretrain/trainer_option_new_vae_L30.py --configfile pretrain/cfg_option_new_vae.py --datadir placeholder --mdp_type ProgramEnv_option_new_vae_v2_key2door_fixed  --num_lstm_cell_units 256 --algorithm PPO_option --net.saved_params_path pretrain/output_dir_vae_L30_1m_20epoch/LEAPSL_tanh_epoch20_L30_1m_h256_u256_option_latent_p1_gru-handwritten-123-20220926-232556/best_valid_params.ptp --net.num_rnn_encoder_units 256 --net.num_rnn_decoder_units 256 --net.use_linear False --net.latent_mean_pooling False  --env_task randomMaze_key2doorSpace --rl.envs.executable.task_definition custom_reward  --max_program_len 40 --dsl.max_program_len 40 --prefix PPO_option_randomMaze_key2doorSpace_fixedInitPos_penalty0p1_L38_step5_dim256_recurrent_fixedInput --seed 123 --PPO.num_processes 16 --PPO.lr 1e-5 --PPO.num_steps 800 --PPO.num_mini_batch 10 --PPO.num_env_steps 20e6 --PPO.entropy_coef 0.05 --PPO.hidden_size 256 --log_interval 1 --save_interval 50 --log_video_interval 50 --outdir pretrain/output_dir_ppo_karel_hard_L38 --max_episode_steps 5 --input_channel 8 --logging.wandb False --PPO.recurrent_policy True #--fixed_input True


