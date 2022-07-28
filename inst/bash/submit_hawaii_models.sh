#!/bin/bash
#SBATCH --time=72:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --job-name=Hawaii
#SBATCH --output=logs/Hawaii.log
#SBATCH --mem=5GB
#SBATCH --partition=gelifes

sbatch --job-name=ml_Hawaii DAISIEutils/bash/submit_run_daisie_ml_long.sh \
  Hawaii \
  cr_dd \
  relaxedDAISIE \
  5 \
  NULL \
  lsodes \
  simplex \
  FALSE \
  NULL \
  100 \

sleep 5

sbatch --job-name=ml_Hawaii DAISIEutils/bash/submit_run_daisie_ml_long.sh \
  Hawaii \
  rr_lac_dd \
  relaxedDAISIE \
  5 \
  NULL \
  lsodes \
  simplex \
  FALSE \
  NULL \
  100 \

sleep 5

sbatch --job-name=ml_Hawaii DAISIEutils/bash/submit_run_daisie_ml_long.sh \
  Hawaii \
  rr_mu_dd \
  relaxedDAISIE \
  5 \
  NULL \
  lsodes \
  simplex \
  FALSE \
  NULL \
  100 \

sleep 5

sbatch --job-name=ml_Hawaii DAISIEutils/bash/submit_run_daisie_ml_long.sh \
  Hawaii \
  rr_k \
  relaxedDAISIE \
  5 \
  NULL \
  lsodes \
  simplex \
  FALSE \
  NULL \
  100 \

sleep 5

sbatch --job-name=ml_Hawaii DAISIEutils/bash/submit_run_daisie_ml_long.sh \
  Hawaii \
  rr_gam_dd \
  relaxedDAISIE \
  5 \
  NULL \
  lsodes \
  simplex \
  FALSE \
  NULL \
  100 \

sleep 5

sbatch --job-name=ml_Hawaii DAISIEutils/bash/submit_run_daisie_ml_long.sh \
  Hawaii \
  rr_ana_dd \
  relaxedDAISIE \
  5 \
  NULL \
  lsodes \
  simplex \
  FALSE \
  NULL \
  100 \
