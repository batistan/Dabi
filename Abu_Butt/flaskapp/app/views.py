from app import app
import datetime as dt
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
    if(request.method=='POST'):
        session['trip_time_of_day'] = request.form['triptime']
        session['start_station_name'] = request.form["startstation"]
        session['start_station']=get_station_id(session['start_station_name'])
        session['end_station_name'] = request.form["endstation"]
        session['end_station']=get_station_id(session['end_station_name'])
        session['trip_date'] = request.form["tripdate"]
        session['trip_type'] = request.form['roundtrip']
        session['return_booking'] = False
        ##to retrieve across pages

        if(session['trip_type']=="round"):
            session['return_time_of_day'] = request.form['returntime']
            session['return_date'] = request.form['returndate']
            return_time_of_day = session['return_time_of_day'] 
            return_date = session['return_date'] 

    trip_time_of_day = session['trip_time_of_day'] 
    start_station = session['start_station'] 
    end_station = session['end_station'] 
    trip_date = session['trip_date'] 
    trip_type = session['trip_type'] 

    #to handle getting search results for return trips - can also be a separate view but whatever
    if(session['return_booking']):
        start_station=session['return_start_station']
        end_station=session['return_end_station']
        trip_date = session['return_date']
        trip_time_of_day = session['return_time_of_day']

    #dictionary (train number and train time) for all trains running from station     
    all_trains = get_trains_from_station(start_station,end_station,trip_date,trip_time_of_day)
    ## doesn't work yet, no data on free seats
    free_trains=[]
    for t in all_trains:
        if(check_free_seats(start_station,end_station,t['train_num'],trip_date)):
            free_trains.append(t)

    ##Change to return only free trains
    return render_template("search_results.html",all_trains=all_trains, trip_date=trip_date, trip_time_of_day=trip_time_of_day, start_station = start_station, end_station = end_station, )

## get user (or new user) info and send to confirmation through the form.
@app.route("/book/<int:train_num>/<train_time>")
def booktrip(train_num,train_time):
    if(session['return_booking']):
        session['return_train'] = train_num
        session['return_time'] = train_time
    else:
        session['trip_train']=train_num
        session['trip_time'] = train_time
    ## the user is coming from search results check if they still need to choose return trip
    if(session['trip_type'] == "round" and not session['return_booking']):
        #call choose return to get return booking
        choosereturn()
    else:
        return render_template("passenger_trip.html", start_station=session['start_station_name'],end_station=session['end_station_name']);



## re render search results for the return trip
@app.route("/returntrip/<return_time_of_day>/<return_date>")
def choosereturn():
    session['return_booking'] = True
    session['return_start_station'] = session['end_station']
    session['return_end_station'] = session['start_station']
    search_results()


'''
this will be the thank you page
decrement free seats for segments
create new passenger from form if needed
create a ticket from the passenger id returned from the booking page.  - 
some of the needed methods are already in models, might need testing though
render page that shows trip info and passenger id
'''
@app.route('/confirmation')
def confirm_book():
    pass

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
