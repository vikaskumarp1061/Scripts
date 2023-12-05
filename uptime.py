import subprocess
import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart

# Function to get system uptime in hours
def get_system_uptime():
    try:
        # Run the command to get uptime in seconds
        uptime_output = subprocess.check_output(['cat', '/proc/uptime']).split()[0]
        uptime_seconds = float(uptime_output)
        # Calculate uptime in hours
        uptime_hours = uptime_seconds / 3600
        return uptime_hours
    except Exception as e:
        print(f"Error occurred while getting system uptime: {str(e)}")
        return None

# Function to send email
def send_email(subject, body):
    email_sender = 'vikaskumar.sglc@gmail.com'
    email_receiver = 'vikaskumar.sglc@gmail.com'
    smtp_server = 'smtp.gmail.com'
    smtp_port = 587  # Change this if your SMTP server uses a different port (e.g., 465 for SSL)
    smtp_username = 'vikaskumar.sglc@gmail.com'
    smtp_password = 'bbch lafx twuc tagi'

    email_message = MIMEMultipart()
    email_message['From'] = email_sender
    email_message['To'] = email_receiver
    email_message['Subject'] = subject
    email_message.attach(MIMEText(body, 'plain'))

    try:
        smtp_connection = smtplib.SMTP(smtp_server, smtp_port)
        smtp_connection.starttls()
        smtp_connection.login(smtp_username, smtp_password)
        smtp_connection.send_message(email_message)
        smtp_connection.quit()
        print("Email sent successfully!")
    except Exception as e:
        print(f"Failed to send email. Error: {str(e)}")

if __name__ == "__main__":
    threshold = 1  # Define the threshold in hours

    # Get system uptime
    uptime = get_system_uptime()

    if uptime is not None:
        # Read the previous uptime from a file
        try:
            with open('previous_uptime.txt', 'r') as file:
                previous_uptime = float(file.read().strip())
                print(f"Previous Uptime: {previous_uptime}")
        except FileNotFoundError:
            previous_uptime = uptime
            print("Previous Uptime file not found. Creating a new file.")

        # Calculate the total running time since the last check
        total_running_time = uptime - previous_uptime
        print(f"Total Running Time: {total_running_time}")

        # Update the previous uptime value in the file
        with open('previous_uptime.txt', 'w') as file:
            file.write(str(uptime))

        if total_running_time >= threshold:
            # Send email if the total running time exceeds the threshold
            subject = 'EC2 Running Time Alert'
            body = f"EC2 instance has been running for more than {threshold} hours. Total running time: {total_running_time:.2f} hours."
            send_email(subject, body)
