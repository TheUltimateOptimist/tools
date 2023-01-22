import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from src.mailing.credentials import Credentials
class EmailBot:
    def __init__(self, destination_address, subject, message:str) -> None:
        self.sender_address = Credentials.MY_ADDRESS
        self.destination_address = destination_address
        self.subject = subject
        self.text = message

    def send(self):
        # connect to server
        server = smtplib.SMTP(host=Credentials.HOST_ADDRESS, port=Credentials.HOST_PORT)
        server.starttls()
        server.login(Credentials.MY_ADDRESS, Credentials.MY_PASSWORD)

        #creation of MIMEMultipart Object
        message = MIMEMultipart("alternative")
        message["From"] = Credentials.MY_ADDRESS
        message["To"] = self.destination_address
        message["Subject"] = self.subject

        # creation of MIMEText Part
        textPart = MIMEText(self.text, "html")

        # part attachment
        message.attach(textPart)

        # send email and close connection
        server.send_message(message)
        server.quit()