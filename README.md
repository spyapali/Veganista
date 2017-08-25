# Veganista

Veganista is a vegan nutrition tracker that allows users to be aware of whether they are satisfying their daily nutritional requirements. 

### Tech

* Flask 
* PostgreSQL 
* ChartJS 
* AutocompleteJS  
* JQUERY 
* Javascript/HTML/CSS

Veganista is open source on Github.

### Features

* Enter in dishes: Users enter in dishes they have eaten. As the user enters in the dish, flask runs an autocomplete function which accesses all the dishes in the database that contain the characters entered. This is achieved through autocompleteJS. 

* Dish Nutrition: A dish entry, when clicked on, queries the dish table (by input name) for daily percentages of carbohydrates, protein and fat that the user satisfies through eating the meal. This information gets passed through a chart object in ChartJS and renders on an HTML page as a Polar Area Chart. 

<img src="/Gifs/search.gif" alt="search">

* Dish Directory: Users can click on the dish directory button, which routes to a function that grabs all the dishes from the dish table which the user has entered and passes it into an HTML template using jinja. As a result, users can see a list of all the dishes they have eaten. 

* Dishes by Day: Users can view dishes they have eaten on a particular day, by selecting a date on the drop down calendar menu and pressing submit. This routes to a function which grabs all the dishes eaten on a particular date in the dish table (using SQL Alchemy) and then passes it into an HTML template using jinja. 

* Daily nutritional progress: When users decide to view their daily nutritional progress, they have an option to click on the "view daily progress" button which routes to a function that:
  * uses SQLAlchemy to grab all the dishes on a certain date
  * query for those dish names in the dish nutrition table
  * get all the respective nutritional percentages of protein, fat and carbohydrates and add them up by macronutrient
  * pass the macronutrient name and total percentage as a key, value pair into a javascript object
  * pass the javascript object into a chart object using ChartJS.
  * As a result, users van view a bar chart that shows them the total percentages of fat, protein and carbohydrates they have consumed for the day, giving them an estimate of how much more they need to consume, or whether they have exceeded their daily recommendations. 

* Overall nutritional progress: When users click on "Show Overall Progress", with SQLAlchemy, all the dishes in the database corresponding to that user get grouped by date, and get stored into a python dictionary, with the key being the date, and the value being the list of dishes corresponding to that date. The dish names stored in the dictionary get queried in the dish nutrition table, and the nutritional information passed back gets summed up by macronutrient and is stored into three separate lists in order of date: one for protein, fat and carbs. These three lists get passed as javascript objects into a chartJS object. What the user eventually sees is a line chart showing them their daily totals of fat, carbohydrates and protein percentages day by day over time, so that they can gauge whether they are improving their nutritional intake or not. 


### Version 2.0
* Send users daily reminders through text to intake daily supplements of Vitamin B-12 and Nutritional Yeast through the Twilio API. 
* Use React to make graphs more dynamic and allow users to view their past progress over a week or month. 
* Allow users to add in their number of servings along with each meal.
