# nss-cohort-13-directory-init

This is a small script that creates a basic html layout file, creates a .gitignore and fills it with the information needed to block standard files, creates a jshint file for a good amount of errors, makes a javascripts directory, makes a npm file (so you can skip the npm init)and installs the plugins needed for gulp into the local project directory. It essentially does everything laid out in this post from Joe:

```bash
1 create .gitignore Never check in your PM folders to github.
2 bower init
3 npm init
4 Then you can install things that you need
     For example: npm install gulp --save —no-bin-link (For only windows users for all npm and bower )
     and: bower install jquery --save
5 touch gulpfile.js
6 Copy and paste default example
     https://gist.github.com/chortlehoort/552acdb39294d4c105b5
7 Install all the dependencies listed in the link above with --save at the end of the line
8 Create .jshintrc and paste in settings from the link above
```



To Install:

Once inside the directory, copy this to a location in your $PATH)
```bash
sudo cp c13-init.sh /usr/local/bin/
```

This makes the script executable.
``` bash
sudo chmod 775 /usr/local/bin/c13-init.sh 
```

To use, type c13-init.sh in the directory you wish it initialize

Thanks to Adam Oswalt for pointing out the method to condense this down to one file