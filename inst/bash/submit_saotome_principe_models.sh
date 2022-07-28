#!/bin/bash
#SBATCH --time=72:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --job-name=SaoTome_Principe
#SBATCH --output=logs/SaoTome_Principe.log
#SBATCH --mem=5GB
#SBATCH --partition=gelifes

sbatch --job-name=ml_SaoTome_Principe DAISIEutils/bash/submit_run_daisie_ml_long.sh SaoTome_Principe cr_dd relaxedDAISIE 5

sleep 5

sbatch --job-name=ml_SaoTome_Principe DAISIEutils/bash/submit_run_daisie_ml_long.sh SaoTome_Principe rr_lac_dd relaxedDAISIE 5

sleep 5

sbatch --job-name=ml_SaoTome_Principe DAISIEutils/bash/submit_run_daisie_ml_long.sh SaoTome_Principe rr_mu_dd relaxedDAISIE 5

sleep 5

sbatch --job-name=ml_SaoTome_Principe DAISIEutils/bash/submit_run_daisie_ml_long.sh SaoTome_Principe rr_k relaxedDAISIE 5

sleep 5

sbatch --job-name=ml_SaoTome_Principe DAISIEutils/bash/submit_run_daisie_ml_long.sh SaoTome_Principe rr_gam_dd relaxedDAISIE 5

sleep 5

sbatch --job-name=ml_SaoTome_Principe DAISIEutils/bash/submit_run_daisie_ml_long.sh SaoTome_Principe rr_laa_dd relaxedDAISIE 5
