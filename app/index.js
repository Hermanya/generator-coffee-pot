'use strict';
var util = require('util');
var path = require('path');
var yeoman = require('yeoman-generator');
var yosay = require('yosay');
var chalk = require('chalk');


var CoffeePotGenerator = yeoman.generators.Base.extend({
  init: function () {
    this.pkg = require('../package.json');

    this.on('end', function () {
      if (!this.options['skip-install']) {
        this.installDependencies();
      }
    });
  },

  askFor: function () {
    var done = this.async();

    // Have Yeoman greet the user.
    this.log(yosay('Welcome to the marvelous CoffeePot generator!'));

    var prompts = [{
      type: 'list',
      name: 'CSSpreprocessor',
      message: 'What more would you like?',
      choices: [{
        name: 'Stylus',
        value: 'Stylus'
      },{
        name: 'none',
        value: 'none'
      },{
        name: 'SASS',
        value: 'SASS'
      }],
      default: 'Stylus'
    }];

    this.prompt(prompts, function (props) {
      this.CSSpreprocessor = props.CSSpreprocessor;
      done();
    }.bind(this));
  },

  app: function () {
    this.mkdir('_app/');
    if (this.CSSpreprocessor !== 'none'){
      this.mkdir('_app/stylesheets');
    }
    this.mkdir('app');

    this.template('_package.json', 'package.json');
    this.template('_Gruntfile.coffee', 'Gruntfile.coffee');
    this.template('_bower.json', 'bower.json');
    this.template('coffeelint.json', 'coffeelint.json');
    this.copy('editorconfig', '.editorconfig');
    this.copy('gitignore', '.gitignore');
    this.copy('favicon.ico', 'favicon.ico');
  },

  projectfiles: function () {
    this.copy('app/main.coffee','_app/main.coffee');
    this.template('_index.html','index.html');
    switch(this.CSSpreprocessor){
    case 'SASS':
      this.copy('app/stylesheets/style.scss','_app/stylesheets/main.scss');
      break;
    case 'none':
      this.copy('app/stylesheets/style.css','app/style.css');
    default:
      this.copy('app/stylesheets/style.styl','_app/stylesheets/main.styl');
    }
  }
});

module.exports = CoffeePotGenerator;
