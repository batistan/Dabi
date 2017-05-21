from . import app
from .models import *
import datetime as dt
#import json
from flask import render_template, redirect, request, flash, g, session, url_for, send_file

app.secret_key = "xsjnfeDSWID8erawv"


# home page
# see templates directory for what this whole templates thing is about
@app.route('/', methods=["GET", "POST"])
@app.route('/index', methods=["GET", "POST"])
def index():
    all_stations = get_all_stations()
    return render_template("index.html", all_stations=all_stations)


@app.route('/check_schedule', methods=["GET","POST"])
def check_schedule():
    all_stations = get_all_stations()
    return render_template("check_schedule.html", all_stations=all_stations)


@app.route('/check_db')
def check_db():
    return render_template("check_db.html")


@app.route('/check_tickets')
def check_tickets():
    tickets = get_all_tickets()
    return render_template("check_tickets.html", tickets=tickets)


@app.route('/check_passengers')
def check_passengers():
    passengers = get_all_passengers()
    return render_template("check_passengers.html", passengers=passengers)

#working
#initiate the delay functions on click
@app.route('/train_status')
def train_status():
    create_temp_stops_at()
    #shoud rewrite this to delay by random minutes
    rand_t = delay_random_train(45)
    affected_trains = update_all_trains(rand_t[0],rand_t[1],rand_t[2])
    trains = get_all_trains()
    return render_template("train_status.html", trains=trains, root_train=rand_t[2], affected_trains=affected_trains)


@app.route('/show_status', methods = ["POST"])
def show_status():
    train_num = request.form["trainnum"]
    stopsat = get_train_status(train_num)
    return render_template("show_status.html", train_num=train_num, stopsat=stopsat)

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
    # TODO: should be working now, need to test
    free_trains = []
    for t in all_trains:
        #will create a free seats record if first passenger for the trip
        if check_free_seats(start_station, end_station, t['train_num'], trip_date):
            free_trains.append(t)

    ##Change to return only free trains
    return render_template("search_results.html",all_trains=free_trains, trip_date=trip_date, trip_time_of_day=trip_time_of_day, start_station = session['start_station_name'], end_station = session['end_station_name'],fare=session['fare'] )


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


# re-render search results for the return trip
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
                               session['trip_train'], trip_date_time, p_id, session['fare'], session['return_booking'], session['return_train'], return_date_time,)
    return render_template("confirmation.html", passenger_id=p_id, ticket_num =ticket_num)


@app.route('/reservation', methods=['POST'])
def reservation():
    current_date = datetime.today()
    pid = request.form['passengerID']
    result = get_passenger_reservation(pid)
    return render_template('/reservation/reservation_list.html',
                           result=result,
                           current_date=current_date)


@app.route('/reservation/cancel/<int:ticketID>', methods=['GET', 'POST'])
def cancel_reservation(ticketID):
    t_info = get_ticket_record(ticketID)
    cancel_ticket(ticketID)
    update_free_seats(t_info[1],t_info[2],t_info[3],pydate_only(t_info[4]),1)
    if(t_info[6]): 
        update_free_seats(t_info[2],t_info[1],t_info[7],t_info[8],1)
    return render_template('reservation/confirmation_cancel.html', ticketID=ticketID)


# This rebook part just need to
@app.route('/reservation/rebook/<int:ticketID>', methods=['GET', 'POST'])
def rebook_reservation(ticketID):
    record = get_ticket_record(ticketID)
    round_trip = record[6]
    if round_trip:
        if is_seats_available(record[1], record[2], record[3], record[4]) \
                and is_seats_available(record[1], record[2], record[7], record[8]):
            rebook_ticket(ticketID)

            update_free_seats(record[1],record[2],record[3],pydate_only(record[4]))

            update_free_seats(record[2],record[1],record[7],pydate_only(record[8]))

            return render_template('reservation/confirmation_rebook.html', ticketID=ticketID, success=True)
        else:
            return render_template('reservation/confirmation_rebook.html', ticketID=ticketID, success=False)
    else:
        if is_seats_available(record[1], record[2], record[3], record[4]):
            rebook_ticket(ticketID)
            update_free_seats(record[1],record[2],record[3],pydate_only(record[4]))

            return render_template('reservation/confirmation_rebook.html', ticketID=ticketID, success=True)
        else:
            return render_template('reservation/confirmation_rebook.html', ticketID=ticketID, success=False)

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


@app.template_filter('strftime')
def pydate_only(date):
    formatstring = "%Y-%m-%d %H:%M:%S"
    # takes string and converts to datetime object for use in python functions
    return datetime.strptime(date, formatstring)
