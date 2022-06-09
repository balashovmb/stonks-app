// Load all the controllers within this directory and all subdirectories. 
// Controller files must be named *_controller.js.

import { Application } from "@hotwired/stimulus"
import consumer from '../channels/consumer'
import controller from '../controllers/application_controller'

const application = Application.start()
