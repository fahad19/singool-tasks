# routers
TasksRouter = require 'tasks/config/router'
window.tasksRouter = new TasksRouter

# inject Link in main nav
$('header .navbar ul.nav').append '<li><a href="#!/tasks">Tasks</a></li>'