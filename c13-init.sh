#! /bin/bash

# A script for setting the contents of a directory and creating the init files for package installers

#NOTE(adam): variable definitions for grouped, single point editing
read -d '' GITIGNORE <<"EOF"
.DS_Store
node_modules
bower_components
EOF

read -d '' INDEX <<"EOF"
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title></title>
    <link rel="stylesheet" href="">
  </head>
  <body>

  </body>
</html>
EOF

read -d '' TESTS <<"EOF"
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title></title>
  <link rel="stylesheet" href="/node_modules/jasmine-core/lib/jasmine-core/jasmine.css">
</head>
<body>
  <script type="text/javascript" src="/node_modules/jasmine-core/lib/jasmine-core/jasmine.js"></script>
  <script type="text/javascript" src="/node_modules/jasmine-core/lib/jasmine-core/jasmine-html.js"></script>
  <script type="text/javascript" src="/node_modules/jasmine-core/lib/jasmine-core/boot.js"></script>

  <script type="text/javascript" src="/javascripts/script.js"></script>

  <script type="text/javascript" src="/spec/script.spec.js"></script>
</body>
</html>
EOF

read -d '' JSHINT <<"EOF"
{
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
}
EOF

read -d '' GULP <<"EOF"
"use strict";

var gulp = require('gulp');
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
});
EOF

#TODO(adam): git init as option
#TODO(adam): README.md with passed in title
#TODO(adam): jquery option


#NOTE(adam): start of install
echo "Installing .gitignore..."
echo "$GITIGNORE" > .gitignore

echo "Running npm init..."
npm init -y

#NOTE(adam): create index.html if doesnt exist
if [ ! -f "index.html" ]
then
  echo "Installing standard index.html..."
  echo "$INDEX" > index.html
else
  echo "index.html exists, skipping creation."
fi

#NOTE(sule): if the -j switch is entered, install the jasmine testing functionality
#NOTE(sule): this is still buggy as it will only allow for the testing of one flag being passed in.
if [ $# -eq 1 ]
  then
  if [ $1 == -j ]
  then
    #NOTE(adam): create tests.html if doesnt exist
    if [ ! -f "tests.html" ]
    then
      echo "Installing standard tests.html..."
      echo "$TESTS" > tests.html
      echo "Making directories..."
      mkdir ./spec/
      echo "Installing jasmine, gulp and dependencies..."
      npm install jasmine-core --save-dev
    else
      echo "tests.html exists, skipping creation."
    fi
  fi
fi

echo "Installing gulp and dependencies..."
npm install gulp jshint gulp-jshint jshint-stylish gulp-watch --save-dev

echo "Installing .jshintrc..."
echo "$JSHINT" > .jshintrc

echo "Installing gulpfile.js..."
echo "$GULP" > gulpfile.js

echo "Making standard directories"
mkdir ./javascripts/
mkdir ./styles/
