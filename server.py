"""Veganista Project."""


from __future__ import division

import os

import requests

from jinja2 import StrictUndefined

from flask import Flask, render_template, redirect, request, flash, session, json, url_for


from flask_debugtoolbar import DebugToolbarExtension

from model import connect_to_db, db, User, User_Stats, Input, Recipe

import json

import pprint

from sys import argv

from datetime import datetime, date

from sqlalchemy import func


# useful tip, debugger: import pdb; pdb.set_trace()


app = Flask(__name__, static_url_path='/static')

# Required to use Flask sessions and the debug toolbar
# app.secret_key = "ABC"

app.config['SECRET_KEY'] = os.environ.get("FLASK_SECRET_KEY", "abcdef")

# Normally, if you use an undefined variable in Jinja2, it fails silently.
# This is horrible. Fix this so that, instead, it raises an error.
app.jinja_env.undefined = StrictUndefined


@app.route('/')
def index():
    """Homepage"""

    # if the user is logged into the session, render user page. Otherwise show homepage.
    if session.has_key("user_id"):
        return redirect("/user")
    else:
        return render_template('homepage.html')

@app.route('/sign-up-form')
def sign_up():
    """Sign Up"""

    # Show sign up form.
    return render_template('sign_up.html')


@app.route('/sign-up', methods=['POST'])
def sign_up_process():
    """Sign up processing"""

    # Grab the user's firstname, lastname, username and password from the sign up form and create a user object in the user table.

    firstname = request.form.get("firstname")
    lastname = request.form.get("lastname")
    username = request.form.get("username")
    password = request.form.get("password")

    user = User(first_name=firstname, last_name=lastname,
                    username=username, password=password)

    db.session.add(user)
    db.session.commit()


    flash("Thanks for signing up! Please fill out more information below.")
    return redirect("/login")



@app.route('/login')
def log_in():
    """Show login form"""

    return render_template("login.html")


@app.route("/process-login", methods=["POST"])
def process_user_login():
    """Log in existing users, otherwise redirect to sign up page."""

    username = request.form.get("username")
    password = request.form.get("password")

    # Grab the user object that matches the email and password values.
    user = User.query.filter_by(username=username, password=password).first()

    # If the user object exists, then add the user_id to the session (logged in).
    # Otherwise, redirect to sign up form to create a new user account.
    if user:
        user_id = user.user_id
        session["user_id"] = user_id
        flash("Logged In")
        user_details = "/user"
        return redirect(user_details)
    else:
        flash("Sorry, you're not a registered user. Please sign up.")
        return redirect("/sign-up-form")



@app.route("/user", methods=['GET', 'POST'])
def show_user_page():
    """User homepage."""

    user_id=session["user_id"]

    if user_id != None:
        # If the session is not storing the user id, grab it from the session.
        user = User.query.get(user_id)

        #grab the first name of the user object.
        firstname = user.first_name
    else:
        # if there is no user id in the session, redirect to login.
        return redirect("/login")



    return render_template('user.html', firstname=firstname, user=user)


@app.route("/ajaxautocomplete", methods=['GET', 'POST'])
def ajaxautocomplete():
    """Implementing autocomplete"""

    result = ""
    if request.method == 'POST':
        # The query refers to the user input.
        query = request.form['query']

        try:
            input_names = []
            result = Recipe.query.filter(Recipe.input_name.like('%' + query + '%')).all()
            for r in result:
                input_name = r.input_name
                input_names.append(input_name)
        finally:
            a = 2
        # passing in a list of input names as a value for suggestions, where suggestions is the key.
        # Dictionary used for autocomplete dropdown.
        return json.dumps({"suggestions": input_names})
    else:
        return "oops"


@app.route('/user/input', methods=['GET', 'POST'])
def process_input():
    """Store user inputs as input objects"""

    # creating input objects whenever the user enters a dish name.
    user_id = session["user_id"]
    input_resp = request.args.get('input')


    # if the user input is None, then return the error page.
    # if the user input is not a string, then return the error page.

    if input_resp:
        input_resp = input_resp.lower().strip()
        input_obj = Input(user_id=user_id, eaten_at=date.today(), input_name=input_resp)

        db.session.add(input_obj)
        db.session.commit()

        user = User.query.get(user_id)
        # first_name = user.first_name
        #
        # input_name = input_obj.input_name

        flash('Your dish has been stored.')

        #Setting default to the current date.
        current_date = date.today().strftime('%Y-%m-%d')
        return redirect(url_for('show_recipe_date', date=current_date))
    else:
        flash("Please input a recipe!")
        return redirect(url_for('has_found_error'), input_name=input_resp)



@app.route('/user-log/input_name')
def show_user_log():
    """Show option to change date for users. """

    # Grab user information from session and user table to display name.
    user_id=session["user_id"]
    user = User.query.get(user_id)
    firstname = user.first_name

    return render_template("user_log.html", user=user, firstname=firstname)



@app.route('/dish-directory')
def show_dishes_directory():
    """Show dishes directory page"""

    # Grab user information from session and user table to get list of dishes that particular user entered into account.
    user_id=session["user_id"]
    user = User.query.get(user_id)
    firstname = user.first_name

    # Creating dictionary to grab unique dish names that the user entered to display in their dish directory.
    input_users = Input.query.filter(Input.user_id == user_id).all()

    input_name_dictionary= {}

    for input_obj in input_users:
        if input_obj.input_name not in input_name_dictionary:
            input_name_dictionary[input_obj.input_name] = 1
        else:
            input_name_dictionary[input_obj.input_name] += 1

    input_names_list = sorted(input_name_dictionary.keys())


    return render_template("dishes_directory.html", input_names_list=input_names_list, user=user, firstname=firstname)

@app.route('/show_recipes_date/date/', methods=['GET','POST'])
def show_recipe_date():
    """Show recipes for each date selected"""

    user_id = session["user_id"]
    #Grab the date from the url, which is a unicode string, convert it into a datetime date object.
    recipe_date = request.args.get("date")
    recipe_date = datetime.strptime(recipe_date, "%Y-%m-%d")
    recipe_date = recipe_date.date()

    #Query input database for dishes stored during that date.
    recipe_inputs = Input.query.filter_by(eaten_at = recipe_date, user_id=user_id).all()

    #Convert the date into a string month/date format
    new_recipe_date = recipe_date.strftime('%b %d')

    #Grab user information from session and user table.
    user_id=session["user_id"]
    user = User.query.get(user_id)
    firstname = user.first_name


    return render_template("dynamic_user_log.html", recipe_inputs=recipe_inputs, user=user, firstname=firstname, new_recipe_date=new_recipe_date, recipe_date=recipe_date)


@app.route('/calculate-recipe-totals')
def calculate_recipe_totals():
    """Pass list of x-axis labels and lists of total percentages of fat, protein and carbs into a chartJS line graph object."""

    ###################### Overview #########################
    # divide up the dishes based on time
    # calculate each total based on macronutrient in question
    #########################################################

    user_id = session["user_id"]

    input_users = Input.query.filter(Input.user_id == user_id).all()

    date_dictionary_first = {} # A dictionary to group dates

    # Creating a dictionary with the keys as the dates during which the user inputted dishes.
    for input_obj in input_users:
        if input_obj.eaten_at not in date_dictionary_first:
            date_dictionary_first[input_obj.eaten_at] = 1
        else:
            date_dictionary_first[input_obj.eaten_at] += 1

    # Created a sorted list of the dates during which the user inputted dishes.
    date_list = sorted(date_dictionary_first.keys())

    # Creating the x axis for the line graph with the dates formatted properly 'mm/dd'
    new_date_list = []
    for item in date_list:
        item = item.strftime('%b %d')
        new_date_list.append(item)

    # Creating a dictionary with the key being the datetime date, and the value being the list of dish objects inputted during that date.
    date_dictionary = {}
    for i in range(len(date_list)):
      date_dictionary[date_list[i]] = Input.query.filter(Input.eaten_at == date_list[i], Input.user_id == user_id).all()

    # Creating a dictionary with the key being the date during which the dish was consumed and the values being the total percentage of fat, percentage of carbs and percentage of protein consumed during that date.
    total_percentages = {}
    for key, value in date_dictionary.items():
        total_t_fat = 0
        total_t_protein = 0
        total_t_carbs = 0


        for recipe in value:
            recipe_obj = Recipe.query.filter_by(input_name = recipe.input_name).first()
            if recipe_obj == None:
                 return redirect(url_for('has_found_error', input_name=recipe.input_name))

            else:
                total_t_fat += recipe_obj.percentage_of_fat
                total_t_carbs += recipe_obj.percentage_of_carbs
                total_t_protein += recipe_obj.percentage_of_protein


        key = key.strftime('%b %d')
        # create a function out of this.
        total_fat = "{0:.2f}".format(total_t_fat)
        total_carbs = "{0:.2f}".format(total_t_carbs)
        total_protein = "{0:.2f}".format(total_t_protein)


        total_percentages[key] = {"total fat" : total_fat, "total protein" : total_protein, "total carbs" : total_carbs}


    # Creating three lists which will be passed into each dataset of the line chart: for percentage of protein, fat and carbs.
    # Lists will contain info in the order of sorted dates, so that data goes in order of dates.
    d_total_fat = []
    d_total_carbs = []
    d_total_protein = []


    for i in new_date_list:
        d_total_fat.append(total_percentages[i]["total fat"])
        d_total_carbs.append(total_percentages[i]["total carbs"])
        d_total_protein.append(total_percentages[i]["total protein"])


    total_percentages = json.dumps("total_percentages")

    # converting into json string.
    date_list = json.dumps(new_date_list)


    return render_template("show_progress.html", date_list=date_list, total_percentages=total_percentages, d_total_fat=d_total_fat, d_total_carbs=d_total_carbs, d_total_protein=d_total_protein)



@app.route('/redirect-calculate-recipes/date', methods=['GET'])
def redirect_calculate_recipes():
    """Redirect to creating new daily value graph"""

    # rendering daily value percentages bar chart for changing the date.
    recipe_date = request.args.get("date")
    recipe_date = datetime.strptime(recipe_date, "%Y-%m-%d") # coverted into datetime object.
    recipe_date = recipe_date.date()

    return redirect(url_for('calculate_recipes', recipe_date=recipe_date))

@app.route('/calculate-recipes/<recipe_date>', methods=['GET', 'POST'])
def calculate_recipes(recipe_date):
    """Pass dictionary of total percentages of fat, protein and carbs into a ChartJS bar chart object."""

    # Filter out each recipe based on input name in the Caching Database
    # Grab nutritional data from each recipe
    # Add all of them up.
    user_id = session["user_id"]
    total_t_fat = 0
    total_t_carbs = 0
    total_t_protein = 0

    # Want to calculate the total percentages of fat, carbs and protein
    recipe_inputs = Input.query.filter_by(eaten_at = recipe_date, user_id = user_id).all()

    recipe_date = datetime.strptime(recipe_date, '%Y-%m-%d')
    new_recipe_date = recipe_date.strftime('%b %d')

    #Storing dish total calculations for a specific date.
    for recipe in recipe_inputs:
        recipe_pot = Recipe.query.filter(Recipe.input_name == recipe.input_name).first()
        if recipe_pot == None:
            return redirect(url_for('has_found_error', input_name=recipe.input_name))
        else:

            total_t_fat += recipe_pot.percentage_of_fat
            total_t_carbs += recipe_pot.percentage_of_carbs
            total_t_protein += recipe_pot.percentage_of_protein

    #Creating dictionary that will be used to retrieve data for bar chart.
    recipe_totals = {}
    total_t_fat = "{0:.2f}".format(total_t_fat)
    recipe_totals['total_fat'] = total_t_fat
    total_t_carbs = "{0:.2f}".format(total_t_carbs)
    recipe_totals['total_carbs'] = total_t_carbs
    total_t_protein = "{0:.2f}".format(total_t_protein)
    recipe_totals['total_protein'] = total_t_protein



    # converting into json string.
    recipe_totals = json.dumps(recipe_totals)




    return render_template("recipes_date.html", new_recipe_date=new_recipe_date, recipe_date=recipe_date, total_fat=total_t_fat, total_carbs=total_t_carbs,
                                             total_protein=total_t_protein, recipe_totals=recipe_totals)



@app.route("/error")
def error():
    raise Exception("Error!")



#
# @app.route('/recipe/recipe-nutrition/<input_name>')
# def recipe_nutrition(input_name):
#     """If dish isn't in caching database, call edamam api and create new recipe object with info from the returned json string"""
#
#     input_name = str(input_name)
#
#     json_string = requests.get("https://api.edamam.com/search?q="+input_name+"&app_id=22a5c077&app_key=9e70212d2e504688b4f44ee2651a7769&health=vegan")
#
#
#     json_dict = json_string.json() # converting this into a python dictionary.
#
#
#     if json_dict['hits']:
#
#         json_recipe = json_dict['hits'][0]
#
#         recipe = json_recipe['recipe']
#
#
#         # grabbing serving of the recipe from json object.
#         serving = recipe['yield']
#
#         # grabbing name of the recipe from json object.
#         recipe_name = recipe['label'].lower()
#
#         # grabbing fat percentage of the recipe from the json object.
#         try:
#             total_fat = recipe['totalDaily']['FAT']
#             percentage_of_fat = total_fat['quantity']
#             percentage_of_fat = float(percentage_of_fat)/float(serving)
#
#         except KeyError:
#             percentage_of_fat = 0
#
#
#         # grabbing carbs percentage of the recipe from the json object.
#         try:
#             total_carbs = recipe['totalDaily']['CHOCDF']
#             percentage_of_carbs = total_carbs['quantity']
#             percentage_of_carbs = float(percentage_of_carbs)/float(serving)
#
#         except KeyError:
#             percentage_of_carbs = 0
#
#
#         # grabbing protein percentage of the recipe from the json object.
#         try:
#             total_protein = recipe['totalDaily']['PROCNT']
#             percentage_of_protein = total_protein['quantity']
#             percentage_of_protein = float(percentage_of_protein)/float(serving)
#
#         except KeyError:
#             percentage_of_protein = 0
#
#         # cache the data being called from the api.
#         stored_recipe = Recipe(input_name=input_name, percentage_of_protein=percentage_of_protein,
#                                             percentage_of_fat=percentage_of_fat, percentage_of_carbs=percentage_of_carbs)
#
#         db.session.add(stored_recipe)
#         db.session.commit()
#
#         #create a dictionary for chartJS
#         recipe_data = {}
#         percentage_of_fat = "{0:.2f}".format(percentage_of_fat)
#         recipe_data['percentage_of_fat'] = percentage_of_fat
#         percentage_of_carbs = "{0:.2f}".format(percentage_of_carbs)
#         recipe_data['percentage_of_carbs'] = percentage_of_carbs
#         percentage_of_protein = "{0:.2f}".format(percentage_of_protein)
#         recipe_data['percentage_of_protein'] = percentage_of_protein
#
#         # converting into json string.
#         recipe_data = json.dumps(recipe_data)
#
#
#     else:
#         flash ("Oops...")
#         return redirect(url_for('has_found_error', input_name=input_name))
#
#
#
#     return render_template("recipe.html", input_name=input_name, percentage_of_fat=percentage_of_fat, percentage_of_carbs=percentage_of_carbs,
#                                              percentage_of_protein=percentage_of_protein, data=recipe_data)




@app.route('/error/<input_name>')
def has_found_error(input_name):
    """Return an HTML template saying something went wrong..."""

    # error page will render if Edamam API returns no results, and no dish name is stored in the database.
    input_name = str(input_name)
    input_error = Input.query.filter(Input.input_name == input_name).first()
    db.session.delete(input_error)
    db.session.commit()
    return render_template("error.html")


@app.route('/recipe/input/<input_name>', methods=['GET'])
def process_recipe_info(input_name):
    """Make API call, store stuff for the ingredient."""

    # grab input name and query database for it.
    # search for the term within the database.
    # if not there, call the api and search for the information within the api.
    user_recipe_obj = Recipe.query.filter_by(input_name=input_name).first()
    if (user_recipe_obj is None):
        return redirect(url_for('has_found_error', input_name=input_name))


    input_name = user_recipe_obj.input_name
    percentage_of_fat = user_recipe_obj.percentage_of_fat
    percentage_of_carbs = user_recipe_obj.percentage_of_carbs
    percentage_of_protein = user_recipe_obj.percentage_of_protein

    #create a dictionary for chart.js
    recipe_data = {}
    percentage_of_fat = "{0:.2f}".format(percentage_of_fat)
    recipe_data['percentage_of_fat'] = percentage_of_fat
    percentage_of_carbs = "{0:.2f}".format(percentage_of_carbs)
    recipe_data['percentage_of_carbs'] = percentage_of_carbs
    percentage_of_protein = "{0:.2f}".format(percentage_of_protein)
    recipe_data['percentage_of_protein'] = percentage_of_protein

    # converting into json string.
    recipe_data = json.dumps(recipe_data)

    return render_template("recipe.html", input_name=input_name, percentage_of_fat=percentage_of_fat, percentage_of_carbs=percentage_of_carbs,
                                    percentage_of_protein=percentage_of_protein, data=recipe_data)







@app.route("/logout")
def log_out_user():
    """Logging out user and redirecting to homepage."""

    # Clear out session after the user logs out.
    session.clear()
    flash("Logged out")
    return redirect("/")






if __name__ == "__main__":
    # We have to set debug=True here, since it has to be True at the point
    # that we invoke the DebugToolbarExtension
    # app.debug = True

    connect_to_db(app, os.environ.get("DATABASE_URL"))

    #connect_to_db(app)

    # Use the DebugToolbar
    # DebugToolbarExtension(app)

    DEBUG = "NO_DEBUG" not in os.environ
    PORT = int(os.environ.get("PORT", 5000))

    app.run(host="0.0.0.0", port=PORT, debug=DEBUG)

    # app.run()
