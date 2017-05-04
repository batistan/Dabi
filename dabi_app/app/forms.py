from flask_wtf import FlaskForm
from wtforms import StringField, SubmitField, DateField

class FindReservation(FlaskForm):
    passengerID = StringField('PassengerID')
    submit = SubmitField('Check Reservations')

