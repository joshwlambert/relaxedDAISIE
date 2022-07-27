#!/bin/bash
#SBATCH --time=72:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --job-name=Comoros
#SBATCH --output=logs/Comoros.log
#SBATCH --mem=5GB
#SBATCH --partition=gelifes

sbatch --job-name=ml_Comoros DAISIEutils/bash/submit_run_daisie_ml_long.sh Comoros cr_dd relaxedDAISIE 5

sleep 5

sbatch --job-name=ml_Comoros DAISIEutils/bash/submit_run_daisie_ml_long.sh Comoros rr_lac_dd relaxedDAISIE 5

sleep 5

sbatch --job-name=ml_Comoros DAISIEutils/bash/submit_run_daisie_ml_long.sh Comoros rr_mu_dd relaxedDAISIE 5

sleep 5

sbatch --job-name=ml_Comoros DAISIEutils/bash/submit_run_daisie_ml_long.sh Comoros rr_k relaxedDAISIE 5

sleep 5

sbatch --job-name=ml_Comoros DAISIEutils/bash/submit_run_daisie_ml_long.sh Comoros rr_immig_dd relaxedDAISIE 5

sleep 5

sbatch --job-name=ml_Comoros DAISIEutils/bash/submit_run_daisie_ml_long.sh Comoros rr_laa_dd relaxedDAISIE 5
