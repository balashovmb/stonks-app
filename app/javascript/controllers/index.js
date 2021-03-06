// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { Application } from "@hotwired/stimulus"

const application = Application.start()

import CashController from "./cash_controller.js"
application.register("cash", CashController)

import PriceController from "./price_controller.js"
application.register("price", PriceController)

import ChartController from "./chart_controller.js"
application.register("chart", ChartController)
