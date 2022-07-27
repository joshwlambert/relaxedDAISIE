#!/bin/bash
#SBATCH --time=72:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --job-name=New_Caledonia
#SBATCH --output=logs/New_Caledonia.log
#SBATCH --mem=5GB
#SBATCH --partition=gelifes

sbatch --job-name=ml_New_Caledonia DAISIEutils/bash/submit_run_daisie_ml_long.sh New_Caledonia cr_dd relaxedDAISIE 5

sleep 5

sbatch --job-name=ml_New_Caledonia DAISIEutils/bash/submit_run_daisie_ml_long.sh New_Caledonia rr_lac_dd relaxedDAISIE 5

sleep 5

sbatch --job-name=ml_New_Caledonia DAISIEutils/bash/submit_run_daisie_ml_long.sh New_Caledonia rr_mu_dd relaxedDAISIE 5

sleep 5

sbatch --job-name=ml_New_Caledonia DAISIEutils/bash/submit_run_daisie_ml_long.sh New_Caledonia rr_k relaxedDAISIE 5

sleep 5

sbatch --job-name=ml_New_Caledonia DAISIEutils/bash/submit_run_daisie_ml_long.sh New_Caledonia rr_immig_dd relaxedDAISIE 5

sleep 5

sbatch --job-name=ml_New_Caledonia DAISIEutils/bash/submit_run_daisie_ml_long.sh New_Caledonia rr_laa_dd relaxedDAISIE 5
