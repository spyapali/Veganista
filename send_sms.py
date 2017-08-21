import os

from twilio.rest import Client


account_sid = os.environ["TWILIO_ACCOUNT_SID"]
account_token = os.environ["TWILIO_AUTH_TOKEN"]


client = Client(account_SID)

client.messages.create(
    to=os.environ["USER_PHONE_NUMBER"],
    from_="+14087419974",
    body="Good morning! Hope you are ready to log in dishes for the day."

)