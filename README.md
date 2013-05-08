# The Stackful.io Python Web Stack.

TODO...

## Stack Components

TODO...

## Quickstart


TODO...


## Git Configuration

Your deployment repository is available at:

    git@X.X.X.X:py-web.git

Where X.X.X.X is really your server's IP address.

Configure the deployment repository as a remote on your local development Git repository with a command like:

    git remote add stackful git@X.X.X.X:py-web.git

And then, when you want to deploy your code to the server, just push to the master branch:

    git push stackful master


## HTTP Configuration

Your web server is listening and has a demo web app configured at:

    http://X.X.X.X

The application will be automatically restarted on every push deployment and your
changes will immediately go live.

## Deploying Your Application to Your Server

The summary above says it all, but let's go through the process together. First you need to add your server's deploy repository as a remote:

    ~/tmp/test-deploy $ git remote add stackful git@X.X.X.X:py-web.git

Then push your current branch:


TODO...

## Database Credentials and Other Configuration Settings

TODO...


## Manual Deployment (sans Git)

TODO...
