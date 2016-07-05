"""Models and database functions for Rating  ss project."""

from flask_sqlalchemy import SQLAlchemy
from datetime import date 

# This is the connection to the PostgreSQL database; we're getting this through
# the Flask-SQLAlchemy helper library. On this, we can find the `session`
# object, where we do most of our interactions (like committing, etc.)

db = SQLAlchemy()


##############################################################################
# Model definitions

class User(db.Model):
    """User of Veganista website."""

    __tablename__ = "users"

    user_id = db.Column(db.Integer, autoincrement=True, primary_key=True)
    first_name = db.Column(db.String(64), nullable=False)
    last_name = db.Column(db.String(64), nullable=False)
    username = db.Column(db.String(64), nullable=False)
    password = db.Column(db.String(64), nullable=False)
   
    # build a relationship between user and inputs
    # type ahead JQUERY. 
    # APPLY EARLIER THAN LATER (HAVE IT IN OUR SYSTEM), APPLY TO THE WEBSITE. 
    def __repr__(self):
        """Provide helpful representation when printed."""

        return "<User user_id=%d username=%s>" % (self.user_id, self.username)




class User_Stats(db.Model):
    """User Stats including their weight, height, activity level, gender and age"""

    __tablename__ = "stats"

    # a new table that takes into account user status. 

    stats_id = db.Column(db.Integer, autoincrement=True, primary_key=True)
    height = db.Column(db.Integer)
    weight = db.Column(db.Integer)
    activity_level = db.Column(db.String(64))
    gender = db.Column(db.String(64))
    age = db.Column(db.Integer)
    user_id = db.Column(db.Integer, db.ForeignKey("users.user_id"))

    user = db.relationship("User", backref=db.backref("stats", order_by=stats_id))


    def __repr__(self):
        """Provide helpful representation when printed."""

        return "<User_Stats stats_id=%d username=%s>" % (self.stats_id, self.user.username)



class Input(db.Model):
    """Recipe User enters."""

    __tablename__ = "inputs"


    input_id = db.Column(db.Integer, autoincrement=True, primary_key=True)
    input_name = db.Column(db.String(200))
    user_id = db.Column(db.Integer, db.ForeignKey("users.user_id"))
    eaten_at = db.Column(db.Date)
    

    user = db.relationship("User", backref=db.backref("inputs", order_by=input_name))

    def __repr__(self):
        """Provide helpful representation when printed."""

        return "<Input input_name=%s>" % (self.input_name)



class Recipe(db.Model):
    """Json responses for recipes stored when making an API call."""

    __tablename__ = "recipes"

    recipe_id = db.Column(db.Integer, autoincrement=True, primary_key=True)
    input_name = db.Column(db.String(200))
    percentage_of_carbs = db.Column(db.Float)
    percentage_of_fat = db.Column(db.Float)
    percentage_of_protein = db.Column(db.Float)
    # input_id = db.Column(db.Integer, db.ForeignKey)

    # inputs = db.relationship("Input", backref=db.backref("recipe", order_by=input_name))

    def __repr__(self):
        """Provide helpful representation when printed."""

        return "<Recipe recipe_id=%d input_name=%s>" % (self.recipe_id, self.input_name)




# Supplement reminders through text will be a nice-to-have feature
class Supplements(db.Model):
    """Supplements taken"""

    __tablename__ = "supplements"

    unique_id = db.Column(db.Integer, autoincrement=True, primary_key=True)
    supplement_id = db.Column(db.String(64), nullable=False)
    supplement_taken_at = db.Column(db.DateTime, nullable=False)



##############################################################################
# Helper functions



def connect_to_db(app, db_uri='postgresql:///nutrition'):
    """Connect the database to our Flask app."""

    # Configure to use our PstgreSQL database
    app.config['SQLALCHEMY_DATABASE_URI'] = db_uri
    app.config['SQLALCHEMY_ECHO'] = False
    app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
    db.app = app
    db.init_app(app)


if __name__ == "__main__":
    # As a convenience, if we run this module interactively, it will leave
    # you in a state of being able to work with the database directly.

    from server import app
    connect_to_db(app)
    db.create_all()
    print "Connected to DB."
    
