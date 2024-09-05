# ###################################
# # THIS IS FOR CDE BASH SUBMISSION #
# ###################################s

# #First Question

# # Set environment variables
# CSV_URL="https://www.stats.govt.nz/assets/Uploads/Annual-enterprise-survey/Annual-enterprise-survey-2023-financial-year-provisional/Download-data/annual-enterprise-survey-2023-financial-year-provisional.csv"
# RAW_DIR="./raw"
# TRANSFORMED_DIR="./transformed"
# GOLD_DIR="./gold"
# TRANSFORMED_FILE="2023_year_finance.csv"

# # Extract: Download the CSV file and save it into the raw folder
# echo "Starting extraction process..."
# mkdir -p $RAW_DIR
# curl -s $CSV_URL -o $RAW_DIR/raw_file.csv

# if [ -f "$RAW_DIR/raw_file.csv" ]; then
#     echo "File successfully downloaded and saved to $RAW_DIR."
# else
#     echo "File download failed."
#     exit 1
# fi

# # Transform: Rename the column and select specific columns
# echo "Starting transformation process..."
# mkdir -p $TRANSFORMED_DIR

# awk -F',' 'NR==1 {for (i=1; i<=NF; i++) if ($i=="Variable_code") $i="variable_code";} 
#              NR==1 || ($1!="year" && $3!="Value" && $4!="Units" && $5!="variable_code") 
#              {print $1","$2","$3","$4}' $RAW_DIR/raw_file.csv > $TRANSFORMED_DIR/$TRANSFORMED_FILE

# if [ -f "$TRANSFORMED_DIR/$TRANSFORMED_FILE" ]; then
#     echo "Transformation completed and file saved to $TRANSFORMED_DIR."
# else
#     echo "Transformation failed."
#     exit 1
# fi

# # Load: Move the transformed file to the gold directory
# echo "Starting load process..."
# mkdir -p $GOLD_DIR
# mv $TRANSFORMED_DIR/$TRANSFORMED_FILE $GOLD_DIR/

# if [ -f "$GOLD_DIR/$TRANSFORMED_FILE" ]; then
#     echo "File successfully loaded into $GOLD_DIR."
# else
#     echo "Load process failed."
#     exit 1
# fi

# echo "ETL process completed successfully."

#--------------------------------------------------------------#
# #Second Submission
#--------------------------------------------------------------#

# # Directories
# SOURCE_DIR="./source_folder"
# DEST_DIR="./json_and_CSV"

# mkdir $SOURCE_DIR
# mkdir $DEST_DIR

# # create csv and json files and save in the source directory
# code $SOURCE_DIR/mycsv.csv $SOURCE_DIR/myjson.json

# # Move all CSV and JSON files
# mv $SOURCE_DIR/*.csv $SOURCE_DIR/*.json $DEST_DIR/

# # Confirm the files have been moved
# test -f ./json_and_CSV/*.csv ./json_and_CSV/*.json && echo "Moved all CSV and JSON files to $DEST_DIR || echo "No"

#--------------------------------------------------------------#
# #Second Submission
#--------------------------------------------------------------#

DB_NAME="posey"
CSV_DIR="./csv_files"
TABLE_NAME="posey_data"

# Loop over each CSV file in the directory
for csv_file in $CSV_DIR/*.csv; do
    # Import CSV into PostgreSQL
    psql -d $DB_NAME -c "\copy $TABLE_NAME FROM '$csv_file' WITH CSV HEADER;"
    echo "$csv_file has been loaded into the $TABLE_NAME table."
done
