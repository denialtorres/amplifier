import _ from 'lodash';

// loading controllers as well
import "./stimulus_setup";

document.addEventListener('turbo:load', () => {
  console.log("amplifier loaded");
  const amplifierTitleInput = document.getElementById('amplifier-title');
  const amplifierForm = document.getElementById('amplifier-form');
  const amplifierTitleSaved = document.getElementById('amplifier-title-saved');

  if (amplifierTitleInput && amplifierForm && amplifierTitleSaved) {
    const saveAmplifier = _.debounce(() => {
      amplifierForm.submit();
      amplifierTitleSaved.classList.add('show');

      setTimeout(() => {
        amplifierTitleSaved.classList.remove('show'); // Remove the "show" class after 1 second to fade out the message
      }, 1000);
    }, 1000);

    amplifierTitleInput.addEventListener('input', saveAmplifier);
  }
});
