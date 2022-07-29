#!/bin/bash
#SBATCH --time=72:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --job-name=Marquesas
#SBATCH --output=logs/Marquesas.log
#SBATCH --mem=5GB
#SBATCH --partition=gelifes

sbatch --job-name=ml_Marquesas DAISIEutils/bash/submit_run_daisie_ml_long.sh \
  Marquesas \
  cr_dd \
  relaxedDAISIE \
  6 \
  NULL \
  lsodes \
  simplex \
  FALSE \
  NULL \
  100 \

sleep 5

sbatch --job-name=ml_Marquesas DAISIEutils/bash/submit_run_daisie_ml_long.sh \
  Marquesas \
  rr_lac_dd \
  relaxedDAISIE \
  6 \
  NULL \
  lsodes \
  simplex \
  FALSE \
  NULL \
  100 \

sleep 5

sbatch --job-name=ml_Marquesas DAISIEutils/bash/submit_run_daisie_ml_long.sh \
  Marquesas \
  rr_mu_dd \
  relaxedDAISIE \
  6 \
  NULL \
  lsodes \
  simplex \
  FALSE \
  NULL \
  100 \

sleep 5

sbatch --job-name=ml_Marquesas DAISIEutils/bash/submit_run_daisie_ml_long.sh \
  Marquesas \
  rr_k \
  relaxedDAISIE \
  6 \
  NULL \
  lsodes \
  simplex \
  FALSE \
  NULL \
  100 \

sleep 5

sbatch --job-name=ml_Marquesas DAISIEutils/bash/submit_run_daisie_ml_long.sh \
  Marquesas \
  rr_gam_dd \
  relaxedDAISIE \
  6 \
  NULL \
  lsodes \
  simplex \
  FALSE \
  NULL \
  100 \

sleep 5

sbatch --job-name=ml_Marquesas DAISIEutils/bash/submit_run_daisie_ml_long.sh \
  Marquesas \
  rr_laa_dd \
  relaxedDAISIE \
  6 \
  NULL \
  lsodes \
  simplex \
  FALSE \
  NULL \
  100 \
