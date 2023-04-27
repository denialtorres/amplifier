// stimulus configuration
import { Application } from "@hotwired/stimulus"
import { definitionsFromContext } from "stimulus/webpack-helpers";
// load controllers one by one
import AmplifierController from "../controllers/amplifier_controller";

const application = Application.start();

// register controller
application.register("amplifier", AmplifierController);

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application
