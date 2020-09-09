# app.py
from flask import Flask

#app = Flask(__name__)

def create_app():
    app=Flask(__name__)
    return app
app=create_app()

app = Flask(__name__)
app.config.from_object(__name__)

@app.route('/')
def hello_world():
    return '<h1 align=center>Hello, Welcome to the my nginx-pythonflask-webserver</h1>'

if __name__ == '__main__':
    app.run(host='127.0.0.1',port=5000,debug=True)



