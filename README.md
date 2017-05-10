# Dabi
Databases Group Project (Namtrak)

Install `flask` by running:

`pip install flask`

Install `pip` if you haven't since it's pretty useful anyway.

Go into the `dabi_app` directory, run:

`python2 run.py`

Go to http://localhost:5000/ (or http://127.0.0.1:5000/) in your web browser and you'll get the index page. Alternatively, add a page e.g. http://localhost:5000/search_results.html to go directly to it.

Remember your browser has a cache, so any changes you make while the server is up and running might not be immediately visible. For best results, refresh using CTRL-\<F5\> so the cache is ignored.

The directories are organized as such:

* the root directory contains this file, the `requirements.txt` file which outlines the packages required to run `flask`, as well as the required versions, and the `new_schema.sql` file, which was used to initialize our database with the correct tables and some sample data. Within the root directory we also have the following directories:

    * `report` directory: Contains TEX file and resulting PDF file for the report submitted earlier in the semester.

    * `dabi_app` contains our code. In it, we have:
    
        * The `database.db` file contains our SQLite database. We are currently in the process of shifting away from SQLite and towards MySQL.

        * The `__init__.py` file defines the location of files containing code necessary for `flask` to properly display pages and respond to requests.

        * The `create_seats_free.py` file is used to generate the `create_seats_free.sql` file, which in turn was used to populate the `free_seats` table of our database. We elected to automate this process due to the sheer number of entries that `free_seats` would require. For reference, the python script is only 253 bytes in size, while the SQL file generated is over 700 kilobytes. Even the `new_schema.sql` file, used to initialize the database, is less than a tenth of that size, at 51.2 kilobytes.

        * The `app` directory contains the following:
        
            * `__init__.py` is required for `flask` to run properly.
            
            * `models.py` contains various utility functions called on to interface with the database as well as to resolve variables used to render templates.

            * `views.py` is where the functions used to render templates are defined. Defining a new page is done by first creating a template for it in the `templates` directory, and adding a route in `views.py` to have the desired page requested render the template we created. For example, accessing the `check_schedule` page on the website will run the `check_schedule` function in `views.py`, which runs the `get_all_stations` function from `models.py` and assigns the return value to a variable, which is then passed into the `render_template` function to render the template defined, which will be looked for inside the `templates` directory. Instances of `all_stations` in the specified template will be replaced with the value passed into the `return_template` function.

            * The `static` directory contains the CSS and JavaScript files used to control how the pages look.

            * The `templates` directory contains all the templates used. Most of them extend `layout.html`, since that is the page which contains everything we'd like to include in the majority of pages on our website, such as script and style declarations, as well as the navigation bar at the top of the pages. The other template should be quite self-explanatory, as they consist of mostly unspectacular HTML. The text in between curly braces is used by the template rendering engine to determine how the templates are to be rendered. For example, in `confirmation.html`, we have the text "Thank you! Ticket number for Passender {{ passenger_id }} is {{ticket_num}}". On calling `render_template`, we must also pass in the variables we would like to use for `passenger_id` and `ticket_num`. These are obtained by calling functions from `models.py`. The template rendering engine will then replace {{ passenger_id }} and {{ticket_num}} with the values provided when returning a complete HTML page to be displayed in a browser.
