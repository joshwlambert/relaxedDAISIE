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
  Inf \

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
  Inf \

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
  1 \

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
  100 \

sbatch --job-name=ml_Marquesas DAISIEutils/bash/submit_run_daisie_2type_ml_long.sh \
  Marquesas_2type \
  cr_dd_2type_lac \
  relaxedDAISIE \
  6 \
  NULL \
  lsodes \
  simplex \
  FALSE \
  NULL \
  100 \
  0.1 \

sbatch --job-name=ml_Marquesas DAISIEutils/bash/submit_run_daisie_2type_ml_long.sh \
  Marquesas_2type \
  cr_dd_2type_mu \
  relaxedDAISIE \
  6 \
  NULL \
  lsodes \
  simplex \
  FALSE \
  NULL \
  100 \
  0.1 \

sbatch --job-name=ml_Marquesas DAISIEutils/bash/submit_run_daisie_2type_ml_long.sh \
  Marquesas_2type \
  cr_dd_2type_k \
  relaxedDAISIE \
  6 \
  NULL \
  lsodes \
  simplex \
  FALSE \
  NULL \
  100 \
  0.1 \

sbatch --job-name=ml_Marquesas DAISIEutils/bash/submit_run_daisie_2type_ml_long.sh \
  Marquesas_2type \
  cr_dd_2type_lac_mu \
  relaxedDAISIE \
  6 \
  NULL \
  lsodes \
  simplex \
  FALSE \
  NULL \
  100 \
  0.1 \

sbatch --job-name=ml_Marquesas DAISIEutils/bash/submit_run_daisie_2type_ml_long.sh \
  Marquesas_2type \
  cr_dd_2type_lac_k \
  relaxedDAISIE \
  6 \
  NULL \
  lsodes \
  simplex \
  FALSE \
  NULL \
  100 \
  0.1 \

sbatch --job-name=ml_Marquesas DAISIEutils/bash/submit_run_daisie_2type_ml_long.sh \
  Marquesas_2type \
  cr_dd_2type_mu_k \
  relaxedDAISIE \
  6 \
  NULL \
  lsodes \
  simplex \
  FALSE \
  NULL \
  100 \
  0.1 \

sbatch --job-name=ml_Marquesas DAISIEutils/bash/submit_run_daisie_2type_ml_long.sh \
  Marquesas_2type \
  cr_dd_2type_lac_mu_k \
  relaxedDAISIE \
  6 \
  NULL \
  lsodes \
  simplex \
  FALSE \
  NULL \
  100 \
  0.1 \

