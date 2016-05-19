#! /bin/bash

# A script for setting the contents of a directory and creating the init files for package installers

#NOTE(adam): variable definitions for grouped, single point editing
read -d '' GITIGNORE <<"EOF"
.DS_Store
node_modules
bower_components
EOF

#TODO(adam): better method of building HTML?
read -d '' INDEX_START <<"EOF"
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title></title>
    <link rel="stylesheet" href="">
  </head>
  <body>

EOF

read -d '' INDEX_JQUERY <<"EOF"
  <script src="/node_modules/jquery/dist/jquery.min.js" type="text/javascript"></script>
EOF

read -d '' INDEX_END <<"EOF"
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

#TODO(adam): README.md with passed in title

GITINIT=false
JASMINEINSTALL=false
GULPINSTALL=false
JSHINTINSTALL=false
JQUERYINSTALL=false

#NOTE(adam): handle install options
#NOTE(sule): with -j switch, install the jasmine testing functionality
while getopts :Aghijq opt; do
  case $opt in
    A) GITINIT=true
       JASMINEINSTALL=true
       GULPINSTALL=true
       JSHINTINSTALL=true
       JQUERYINSTALL=true
       ;;
    g) GULPINSTALL=true;;
    h) GULPINSTALL=true; JSHINTINSTALL=true;;
    i) GITINIT=true;;
    j) JASMINEINSTALL=true;;
    q) JQUERYINSTALL=true;;
    ?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
  esac
done


#NOTE(adam): start of install
echo "Writing .gitignore..."
echo "$GITIGNORE" > .gitignore

if [ $GITINIT = true ]; then
  echo "Initializing repo..."
  git init
fi

echo "Running npm init..."
npm init -y

#NOTE(adam): create index.html if doesnt exist
if [ ! -f "index.html" ]; then
  echo "Writing standard index.html..."
  echo "$INDEX_START" >> index.html

  if [ $JQUERYINSTALL ]; then
    echo "$INDEX_JQUERY" >> index.html
  fi

  echo "$INDEX_END" >> index.html
else
  echo "index.html exists, skipping creation."
fi

if [ $JASMINEINSTALL = true ]; then
  echo "Installing jasmine..."
  npm install jasmine-core --save-dev
  echo "Making tests spec directory..."
  mkdir -p ./spec/

  #NOTE(adam): create tests.html if doesnt exist
  if [ ! -f "tests.html" ]; then
    echo "Writing standard tests.html..."
    echo "$TESTS" > tests.html
  else
    echo "tests.html exists, skipping creation."
  fi
fi

if [ $GULPINSTALL = true ]; then
  echo "Installing gulp..."
  npm install gulp --save-dev
fi

if [ $JSHINTINSTALL = true ]; then
  echo "Installing jshint..."
  npm install jshint gulp-jshint jshint-stylish gulp-watch --save-dev

  echo "Writing .jshintrc..."
  echo "$JSHINT" > .jshintrc

  echo "Writing gulpfile.js..."
  echo "$GULP" > gulpfile.js
fi

if [ $JQUERYINSTALL = true ]; then
  echo "Installing jQuery..."
  npm install jquery --save
fi

echo "Making standard directories..."
mkdir -p ./javascripts/
mkdir -p ./styles/

#TODO(adam): touch js & css?
#TODO(adam): do first commit?
