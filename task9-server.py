from http.server import BaseHTTPRequestHandler, HTTPServer

MESSAGE_FILE = "/app/message.txt"

class Handler(BaseHTTPRequestHandler):
    def do_GET(self):
        with open(MESSAGE_FILE, "r") as f:
            message = f.read().strip()

        self.send_response(200)
        self.send_header("Content-type", "text/plain")
        self.end_headers()
        self.wfile.write(message.encode())

server = HTTPServer(("0.0.0.0", 8000), Handler)
print("Server running on port 8000")
server.serve_forever()
