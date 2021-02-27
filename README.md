# bug-tracker-REST-API

## Project Description

This project is the backend part of the Bug Tracker App. It is a REST API built using ROR.
The frontend part will be found here - [bug-tracker](https://github.com/ershadul1/bug-tracker).


## Built With

- Ruby 2.7.1
- Ruby on Rails 6.0.3.5

## Tested with
- Rspec

## How to run this project on your local machine

### Prerequisites
1. You should have ruby installed.(This project was tested on version `2.7.1`)
1. You should have rails installed.(This project was tested on version `Rails 6.0.3.5`)
1. You should have bundler installed.(This project was tested with Bundler version `2.1.4`)

   
### Steps to follow
1. Clone the repository to your local machine using `git clone https://github.com/ershadul1/bug-tracker-REST-API.git`
1. On your local machine, navigate to the finance-tracker folder using `cd bug-tracker-REST-API` in your terminal
1. Install all the gems for the project by running `bundle install` in your terminal
1. Create the database using this command
`bin/rake db:create`
1. Migrate the database using this command
`bin/rake db:migrate`
1. Start the server by using this command.
`bin/rails server`
1. Now you can interact with the API in the following URL `http://localhost:3000/api/v1`



## Contributions

  There are two ways of contributing to this project:

1.  If you see something wrong or not working, please check [the issue tracker section](https://github.com/ershadul1/bug-tracker-REST-API/issues), if that problem you met is not in already opened issues then open the issue by clicking on `new issue` button.

2.  If you have a solution to that, and you are willing to work on it, follow the below steps to contribute:
    1.  Fork this repository
    1.  Clone it on your local computer by running `git clone https://github.com/ershadul1/bug-tracker-REST-API.git` __Replace *ershadul1* with the username you use on github__
    1.  Open the cloned repository which appears as a folder on your local computer with your favorite code editor
    1.  Create a separate branch off the *master branch*,
    1.  Write your codes which fix the issue you found
    1.  Commit and push the branch you created
    1.  Raise a pull request, comparing your new created branch with our original master branch [here](https://github.com/ershadul1/bug-tracker-REST-API)


## Instructions to Test the Project

* Clone the repository using `git clone https://github.com/ershadul1/bug-tracker-REST-API.git`
* cd in to the cloned directory `cd bug-tracker-REST-API`
* Switch to testing branch by `git checkout REST-API`
* Run `bundle install`
* Run `rspec`

## Authors

👤 **Ershadul Rayhan**

- Github: [@ershadul1](https://github.com/ershadul1)
- Twitter: [@ErshadulRayhan](https://twitter.com/ErshadulRayhan)
- Linkedin: [ErshadulRayhan](https://www.linkedin.com/in/ershadulrayhan/)
- Email:  ershadul.rayhan@gmail.com


## Show your support

Give a ⭐️ if you like this project!

## Acknowledgments
- This project was inspired by the [Microverse](https:www.microverse.org) program