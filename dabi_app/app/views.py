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


def index():
    all_stations = get_all_stations()
    return render_template("index.html", all_stations=all_stations)

@app.route('/check_schedule',methods=["GET","POST"])
def check_schedule():
    all_stations = get_all_stations()
    return render_template("check_schedule.html", all_stations=all_stations)

@app.route('/train_status')
def train_status():
    return "Pulling train data..."

@app.route('/train_seats')
def check_seats():
    trains = get_all_trains()
    return render_template("check_seats.html", trains=trains)

@app.route("/train_seats", methods = ["POST"])
def show_seats():
    train_num = request.form["trainnum"]
    t_date = request.form["tdate"]
    seats = get_train_seats(train_num,t_date)
    return render_template("show_seats.html", seats=seats, train_num=train_num)

@app.route('/schedule_result', methods=["GET","POST"])
def schedule_result():
    trip_time_of_day = request.form['triptime']
    trip_date = request.form['tripdate']
    start_station_code = request.form['startstation']
    end_station_code = request.form['endstation']
    start_station = get_station_id(start_station_code)
    end_station = get_station_id(end_station_code)

    all_trains = get_trains_from_station(start_station,end_station,trip_date,trip_time_of_day)

    return render_template("schedule_result.html",all_trains=all_trains, trip_date=trip_date, trip_time_of_day=trip_time_of_day, start_station = start_station_code, end_station = end_station_code, )



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
        #initialize these values to None to avoid index error
        session['return_train'] = session['return_time'] = None
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
    session['fare'] = abs(start_station - end_station)*2 
 

    #to handle getting search results for return trips - can also be a separate view but whatever
    if(session['return_booking']):
        start_station=session['return_start_station']
        end_station=session['return_end_station']
        trip_date = session['return_date']
        trip_time_of_day = session['return_time_of_day']
        session['fare']*=2


    #dictionary (train number and train time) for all trains running from station     
    all_trains = get_trains_from_station(start_station,end_station,trip_date,trip_time_of_day)
    ## doesn't work yet, no data on free seats
    free_trains=[]
    for t in all_trains:
        if(check_free_seats(start_station,end_station,t['train_num'],trip_date)):
            free_trains.append(t)

    ##Change to return only free trains
    return render_template("search_results.html",all_trains=free_trains, trip_date=trip_date, trip_time_of_day=trip_time_of_day, start_station = session['start_station_name'], end_station = session['end_station_name'], )

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
        return choosereturn()
    else:
        return render_template("passenger_trip.html", start_station=session['start_station_name'],end_station=session['end_station_name']);



## re render search results for the return trip
@app.route("/returntrip/<return_time_of_day>/<return_date>")
def choosereturn():
    session['return_booking'] = True
    session['return_start_station'] = session['end_station']
    session['return_end_station'] = session['start_station']
    return search_results()


'''
this will be the thank you page
decrement free seats for segments
create new passenger from form if needed
create a ticket from the passenger id returned from the booking page.  - 
some of the needed methods are already in models, might need testing though
render page that shows trip info and passenger id
'''
@app.route('/confirmation', methods=["POST"])
def confirm_book():
    result = request.form
    #check if new user or returning
    if('passenger_id' not in result):
        p_id = create_passenger(result['lname'],result['fname'],result['email'],result['address'])
    else:
        p_id = result['passenger_id']
    #update free seats for both trips
    update_free_seats(session['start_station'],session['end_station'],session['trip_train'],session['trip_date'])

    trip_date_time = ("%s %s" % (session['trip_date'], session['trip_time']))

    #update values for return trip
    if(session['return_booking']):
        update_free_seats(session['end_station'],session['start_station'],session['return_train'],session['return_date'])
        return_date_time = ("%s %s" % (session['return_date'], session['return_time']))
    else: return_date_time = None

    #create ticket for user
    ticket_num = create_ticket(session['start_station'],session['end_station'],
        session['trip_train'],trip_date_time,p_id,session['fare'],session['return_booking'],session['return_train'],return_date_time,)
    return render_template("confirmation.html",passenger_id=p_id,ticket_num =ticket_num)


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




@app.route("/login", methods=["GET","POST"])
def login():
    if 'username' in session:
        return render_template("login.html",username=session['username'])
    else:
        return render_template("login.html")

