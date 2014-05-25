require('coffee-script/register');

var gulp = require('gulp'),
    watch = require('gulp-watch'),
    mocha = require('gulp-mocha');

gulp.task('mocha', function() {

  var mocha_opts = {};

  try {
    var opts = fs.readFileSync('test/mocha.opts', 'utf8')
      .trim()
      .split(/\s+/);

    opts.forEach(function(val, indx, arry) {
      if (/^-.+?/.test(val)) {
        val = val.replace(/^-+(.+?)/, "$1");
        mocha_opts[val] = arry[indx + 1];
      }
    });

  } catch (err) {
    // ignore
  }

  return watch({ glob: 'test/**/*.coffee', read:false }, function(files) {
    files
      .pipe(mocha(mocha_opts))
      .on('error', function(err) {
        if (!/tests? failed/.test(err.stack)) {
          console.log(err.stack);
        }
      });
  });
});
