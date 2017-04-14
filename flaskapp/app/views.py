from app import app
#import json
from flask import render_template, redirect, request, flash, g, session, url_for, send_file
from models import *

# don't ask what this is for. i don't remember either.
app.secret_key = "donttellanyonemysecret"

# home page
# see templates directory for what this whole templates thing is about
@app.route('/', methods=["GET", "POST"])
@app.route('/index', methods=["GET", "POST"])

# left the username/password code in just in case
def index():
    if 'username' in session:
        return render_template("index.html",username =session['username'])
    else:
        return render_template("index.html")

@app.route('/search_results', methods=["GET", "POST"])
def search_results():
    #TODO: Get submitted data
    return render_template("search_results.html")

# keep these since we might want to use css/images/js in our stuff
@app.route("/css/<css>")
def style_render(css):
    return render_template("css/%s"%css)

@app.route("/images/<image>")
def image_render(image):
    filename = ('templates/images/%s'%image)
    return send_file(filename,mimetype='image/jpeg')

@app.route("/js/<js>")
def js_render(js):
    return render_template("js/%s"%js)

# don't know what this is so it's probably important
@app.route("/js/moment-develop/moment.js")
def moment_js_render():
    return render_template("/js/moment-develop/moment.js")

# bootstrap stuff
@app.route("/bootstrap/js/<js>")
def bootstrap_js_render(js):
    return render_template("/bootstrap/js/%s"%js)

@app.route("/bootstrap/dist/bootstrap.min.js")
def bootstrapminjs():
    return render_template("bootstrap/dist/js/bootstrap.min.js")

@app.route("/bootstrap-datetimepicker.min.js")
def timepickerjs():
    return render_template("bootstrap-datetimepicker.min.js")

# left these for reference since they seem kinda useful
@app.route("/doRSVPJSON", methods=["GET", "POST"])
def doRSVPJSON():
    uid = request.args.get('uid', 0, type=int)
    eid = request.args.get('eid', 0, type=int)

    set_going(uid, eid)
    return "RSVPed"

@app.route("/unRSVP", methods = ["GET", "POST"])
def unRSVP():
    uid = request.args.get('uid', 0, type=int)
    eid = request.args.get('eid', 0, type=int)

    set_not_going(uid, eid)
    return "unRSVPed"
    

# Example of how we'd present a page
@app.route("/checkattendance", methods=["GET", "POST"])
def checkattendance():
    if 'username' in session:
        return render_template("checkattendance.html",username=session['username'])
    return render_template("checkattendance.html")


# example signup
@app.route("/signup", methods=["GET", "POST"])
def signup():
    if 'username' in session:
        return render_template("signup.html",username=session['username'])
    return render_template("signup.html")

# page handling form information
@app.route("/signedup", methods=["GET", "POST"])
def signedup():
    username = request.form['username']
    password = request.form['password']
    session['username'] = username
    session['logged_in'] = True
    session['id'] = getIDFromUsername(username)
    add_user(username, password)
    return render_template("signedup.html",username=session['username'])

# signing out
@app.route("/signedout", methods=["GET","POST"])
def signedout():
    if 'username' in session:
        signoutname = session['username']
        session.pop('username',None)
        session.pop('id', None)
        return render_template("signedout.html",username=signoutname)
    else:
        return render_template("signedout.html",error="Not signed in")


@app.route("/login", methods=["GET","POST"])
def login():
    if 'username' in session:
        return render_template("login.html",username=session['username'])
    else:
        return render_template("login.html")

# after user fills in login form on login page, this page is presented with the result
@app.route("/loggedin", methods=["GET","POST"])
def loggedin():
    logUser = request.form['username']
    logPass = request.form['password']
    loginStatus = True
    # see models.py for all these little utility functions
    loginStatus = confirmUserPass(logUser,logPass)
    if loginStatus:
        session['username'] = logUser
        session['id'] = getIDFromUsername(logUser)
        return render_template("loggedin.html",username=logUser)
    else:
        return render_template("loggedin.html",error="Bad user or password")


@app.route("/getattend", methods=["GET", "POST"])
def getattend():
    uid = request.form['uid']
    eid = request.form['eid']
    return str(is_going(uid, eid))

# left this here in case we need a json dump
# note the lack of methods. users shouldn't normally be able to access this page
# but it's useful for webscraping 
@app.route("/getallmeetups")
def getallmeetups():
    return json.dumps(get_all_meetups())

@app.route("/listmeetups")
def listmeetups():
    meetups = get_all_meetups()
    for m in meetups:
        m['coordinator'] = getUsernameFromUID(m['createdby'])
        
    return render_template("listmeetups.html", meetups = meetups)

@app.route("/contact", methods = ["GET","POST"])
def contact():
    return render_template("contact.html")
