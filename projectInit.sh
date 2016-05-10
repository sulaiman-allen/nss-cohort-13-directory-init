#! /bin/bash

# A script for setting the contents of a directory and creating the init files for package installers

#this should be changed to a variable 
#sourcePath =~/projectstarter/

echo "Copying .gitignore..."
cp ~/projectstarter/".gitignore" ./

echo "Copying .bowerinit..."
cp ~/projectstarter/"bower.json" ./

echo "Copying .gulpfile.json..."
cp ~/projectstarter/"gulpfile.js" ./

echo "Copy Standard index.html..."
cp ~/projectstarter/"index.html" ./

echo "Installing Gulp and dependencies..."
npm install gulp jshint gulp-jshint jshint-stylish gulp-watch --save-dev 

#echo "Installing JQuery Via Bower"
# bower install jquery --save

echo "Making Javascripts Directory"
mkdir ./Javascripts/

