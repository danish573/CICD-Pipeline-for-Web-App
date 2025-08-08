from flask import Flask, request, jsonify
app = Flask(__name__)
@app.route("/")
def home():
    return "Welcome to the Flask App!, Hello from CI/CD pipeline with jenkins, Docker, Githu & EC-2"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)
