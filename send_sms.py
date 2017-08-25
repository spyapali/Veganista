import os

from twilio.rest import Client


account_sid = os.environ["USER_ACCOUNT_SID"]
account_token = os.environ["USER_AUTH_TOKEN"]


client = Client(account_sid, account_token)

client.messages.create(
    to=os.environ["MY_NUMBER"],
    from_=os.environ["TWILIO_NUMBER"],
    body="Good morning! Hope you are ready to log in dishes for the day."

)