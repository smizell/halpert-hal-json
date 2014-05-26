require('coffee-script/register');

var gulp = require('gulp'),
    watch = require('gulp-watch'),
    mocha = require('gulp-mocha'),
    coffee = require('gulp-coffee'),
    gutil = require('gulp-util'),
    grep = require('gulp-grep-stream'),
    plumber = require('gulp-plumber');

gulp.task('build', function() {
  gulp.src('./src/**/*.coffee')
    .pipe(coffee({bare: true}).on('error', gutil.log))
    .pipe(gulp.dest('./lib/'))
});

gulp.task('mocha', function() {
  gulp.src(['./index.js', './src/**/*.coffee', './test/**/*.coffee'], { read: false })
    .pipe(watch({ emit: 'all' }, function(files) {
      files
        .pipe(grep('**/test/**/*.coffee'))
        .pipe(mocha({
          ui: "bdd",
          reporter: "list",
          compilers: "coffee:coffee-script"
        }))
        .on('error', function(err) {
          if (!/tests? failed/.test(err.stack)) {
              console.log(err.stack);
          }
        })
    }));
});
