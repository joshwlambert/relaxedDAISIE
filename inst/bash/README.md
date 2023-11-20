## bash files

This folder contains bash scripts to be executed on the Hábrók High Performance Cluster Computer (HPCC). 

The exception is the `bash_config.sh` file which contains a custom bash function (`extract_log()`) that is uploaded and stored in the `.bashrc` file in the HPCC and is used to extract the relevant information from job log files before the log files are downloaded. A new folder needs to be created in the working directory before calling the `extract_log()` function with the name `n<dir>` (e.g. `nlogs`), then the folder containing the logs (in our case `logs`) is passed as the only argument to the `extract_log()` function and the new slimmed down logs are saved in the new directory, in our case `nlogs`. 
