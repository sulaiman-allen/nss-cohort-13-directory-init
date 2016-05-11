#! /bin/bash

# A script for setting the contents of a directory and creating the init files for package installers

echo "Installing .gitignore..."

echo "DS_Store
bower_components
node_modules" > .gitignore

echo "Installing package.json..."

echo '{
  "name": "cohort-13-project-starter",
  "version": "1.0.0",
  "description": "Shell script for the initial setup of a project directory",
  "main": "gulpfile.js",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "author": "Null",
  "license": "MIT"
}' > package.json

echo "Installing standard index.html..."

echo '<!DOCTYPE html>
  <html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title></title>
    <link rel="stylesheet" href="">
  </head>
  <body>
    
  </body>
</html>' > index.html

echo "Installing gulp and dependencies..."

npm install gulp jshint gulp-jshint jshint-stylish gulp-watch --save-dev 

echo "Installing .jshintrc..."

echo '{
  "node": true,
  "browser": true,
  "bitwise": true,
  "camelcase": true,
  "curly": true,
  "eqeqeq": true,
  "immed": true,
  "indent": 2,
  "latedef": true,
  "newcap": true,
  "noarg": true,
  "undef": true,
  "unused": true,
  "trailing": true,
  "smarttabs": true,
  "predef": [ "document", "jQuery", "$", "console" ],
  "esversion": 6,
  "globalstrict": true,
  "globals": {
    "test": false,
    "chatty": true
  }
}' > .jshintrc

echo "Installing gulpfile.js..."

echo "var gulp = require('gulp');
var jshint = require('gulp-jshint');
var watch = require('gulp-watch');

gulp.task('default', ['lint', 'watch']);

gulp.task('watch', function() {
  gulp.watch('./javascripts/**/*.js', ['lint']);
});


gulp.task('lint', function() {
  return gulp.src('./javascripts/**/*.js')
    .pipe(jshint())
    .pipe(jshint.reporter('jshint-stylish'));
});" > gulpfile.js

echo "Making javascripts directory"

mkdir ./javascripts/