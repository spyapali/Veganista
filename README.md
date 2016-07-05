# Veganista

Veganista is a vegan nutrition tracker that allows users to be aware of whether they are satisfying their daily nutritional requirements. 

### Tech

* Flask 
* PostgreSQL 
* ChartJS 
* Edamam API 
* AutocompleteJS  
* JQUERY 
* Javascript/HTML/CSS

Veganista is open source on Github.

### Features

* Enter in dishes: Users can enter in dishes which they have eaten. A new dish entry not already stored within the database will make a post request to the Edamam API which will return a JSON string including the daily percentages of carbohydrates, protein and fat the user satisfies through eating the meal. 

* Dish Nutrition: Users can click on a dish and view the daily percentages of fat, carbohydrates and protein they have satisfied through eating that dish through a polar area chart.

<img src="/Gifs/search.gif" alt="search">

* Dish Directory: Users can view the list of dishes they have entered into Veganista. 

<img src="/Gifs/dish_directory.png" alt="dish_directory">

* Dishes by Day: Users can view dishes they have eaten on a particular day. 

<img src="/Gifs/viewing_dishes_on_day_rs.gif" alt="dishes_time">

* Daily nutritional progress: Users can view a bar chart that shows them the total percentages of fat, protein and carbohydrates they have consumed for the day, giving them an estimate of how much more they need to consume, or whether they have exceeded their recommendations. 

<img src="/Gifs/bar_chart_rs.gif" alt="daily_time">

* Overall nutritional progress: Users can view a line chart that shows them their totals of fat, carbohydrates and protein percentages over time, so that they can gauge whether they are improving their nutritional intake or not. 

<img src="/Gifs/overall_progress_rs.gif" alt="overall_time">


### Version 2.0
* Send users daily reminders through text to intake daily supplements of Vitamin B-12 and Nutritional Yeast through the Twilio API. 
* Use React to make graphs more dynamic and allow users to view their past progress over a week or month. 
* Allow users to add in their number of servings along with each meal.
