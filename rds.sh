TIMESTAMP=$(date "+%Y-%m-%d_%H-%M-%S")
CSV_FILENAME="cpu_utilization_${TIMESTAMP}.csv"

START_TIME=$(date -u -d "15 minutes ago" "+%Y-%m-%dT%H:%M:%S")
END_TIME=$(date -u "+%Y-%m-%dT%H:%M:%S")
RDS_INSTANCE_IDENTIFIER="database-1" # Replace with your RDS instance identifier

aws cloudwatch get-metric-statistics \
--namespace AWS/RDS \
--metric-name CPUUtilization \
--dimensions Name=DBInstanceIdentifier,Value=$RDS_INSTANCE_IDENTIFIER \
--statistics Average \
--start-time "$START_TIME" \
--end-time "$END_TIME" \
--period 60 \
--region us-east-1 > "/home/vikas/scripts/$CSV_FILENAME"

S3_BUCKET="s3://cloudwatch-10" # Replace with your desired S3 bucket
LOCAL_DIRECTORY="/home/vikas/scripts"

# Assuming you want to upload the file to S3 after capturing the metrics
aws s3 cp "$LOCAL_DIRECTORY/$CSV_FILENAME" "$S3_BUCKET"

