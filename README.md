# Github Archive Challenge

## Purpose
Create a command-line program that lists the most active repositories for a given time range. It should support the following interface:
```bash
gh_repo_stats [--after DATETIME] [--before DATETIME] [--event EVENT_NAME] [-n COUNT]
```

# Install this gem
This gem has been complied for you already. Follow the below steps to install the gem
1. ```$ cd path/to/gh_repo_stats```
2. ```$ gem install gh_repo_stats-0.0.0.gem```
3. ENJOY!
Note: If you have modified the code, please use the following the command to rebuild the gem ```gem build gh_repo_stats.gemspec```

# Going Further Questions
1. There are 18 published Event Types. How would you manage them? What would you do if GitHub added more Event Types?
A: It will not be an issue in this case. My program will be still able to determine the correct Event Types as long as users input the same format as Github described it as I specified in the help section of this command. However, it would be better if we could use another api or fetch the list of published events to display the pubslished events. We could also write a validator to lower case users' input and strip all spaces and compare it with the pubslished events.

2. What factors impact performance? What would you do to improve them?
The example shows one type of output report. How would you add additional reporting formats?
A: The main factor impacts performance the most is the frequency that we make requests to the API. Github Archive Store archives hourly. On my implemenation, I iteratate through the hourly archive file within the time range, which is a slow implementation. I have tried to minimize requests using the second and third APIs provided by GHA - ```http://data.githubarchive.org/2015-01-01-{0..23}.json.gz``` and ```http://data.githubarchive.org/2015-01-{01..30}-{0..23}.json.gz``` so that I can make request monthly. However, I was not able to get these two API working.
    The ultimate solution is signing up Goolge Big Query to query the number of events directly, which only requires making single request and getting number of events using GROUP BY on SQL.
    I would add more command line options for users to choose from. It depends on what information want to display. If they still want to display informations group by repo name, my current setp can adapt that change easily because @data is a hash with repo name as a key. I can more necessary values to each repo name. Method print_events also needs to accept ouput arguments from the user.

3. If you had to implement this using only one gem, which would it be? Why?
Informally, I only use 'yajl-ruby' gem. However, I did use ruby library including ```zlib, open-uri, date and time```. If you do not consider those ruby library as gems, then I will defienitely want to keep yajl-ruby because it allows me to parse the json easily. On the other hand, if we consider the library as gems, then I would like to keep ```zlib``` because I would save me a lot of time taking care of reading gz file. I can still parse the string manually that is generated by ```zlib```.