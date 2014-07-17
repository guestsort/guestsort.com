gulp = require "gulp"
util = require "gulp-util"

# Paths
# =====
root = "./src"
paths =
  scripts:
    src: "#{ root }/scripts/*.coffee"
    dest: "./scripts"
  styles:
    src: "#{ root }/styles/main.scss"
    dest: "./styles"
  pages:
    src: "#{ root }/pages/*.jade"
    dest: "./"

# Scripts
# =======
gulp.task "scripts", ->
  coffeelint = require "gulp-coffeelint"
  reporter = require("coffeelint-stylish").reporter
  coffee = require "gulp-coffee"
  uglify = require "gulp-uglify"
  include = require "gulp-include"

  gulp.src paths.scripts.src
    .pipe do coffeelint
    .pipe do coffeelint.reporter
    .pipe do coffee
    .pipe do include
    .pipe do uglify
    .pipe gulp.dest paths.scripts.dest

# Styles
# ======
gulp.task "styles", ->
  sass = require "gulp-sass"
  autoprefixer = require "gulp-autoprefixer"
  minify_css = require "gulp-minify-css"
  css_import = require "gulp-cssimport"

  gulp.src paths.styles.src
    .pipe do sass
    .pipe do autoprefixer
    .pipe do css_import
    .pipe do minify_css
    .pipe gulp.dest paths.styles.dest

# Pages
# =====
gulp.task "pages", ->
  jade = require "gulp-jade"

  gulp.src paths.pages.src
    .pipe jade(
      pretty: true
      locals:
        hash: require("crypto").randomBytes(20).toString("hex")
        year: new Date().getFullYear()
    )
    .pipe gulp.dest paths.pages.dest

# Build
# =====
gulp.task "build", ["scripts", "styles", "pages"], ->
  util.log "✅  Built"

# Default
# =======
gulp.task "default", ["build"], ->
  util.log "👓  Watching..."
  gulp.watch paths.scripts.src, ["scripts"]
  gulp.watch paths.styles.src, ["styles"]
  gulp.watch paths.pages.src, ["pages"]
