import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  connect() {
    console.log("Connected Amplifier Controller")
  }

  uploadAttachment(event) {
    const input = event.target;
    const file = input.files[0];

    if (file) {
      const formData = new FormData();
      formData.append("attachment[file]", file);

      const amplifierConversationIdInput = document.querySelector("input[name='amplifier_conversation_id']");
      if (amplifierConversationIdInput) {
        formData.append("amplifier_conversation_id", amplifierConversationIdInput.value);
      }


      fetch("/amplifiers/attachments", {
        method: "POST",
        body: formData,
        headers: {
          "X-CSRF-Token": document.querySelector("meta[name=csrf-token]").content,
        },
        credentials: "same-origin",
      })
        .then((response) => response.json())
        .then((data) => {
          if (data.success) {
            // Handle success, e.g. show success message, add attachment to the list, etc.
            const newFile = document.createElement("li");
            newFile.innerHTML = `${data.attachment.filename} <small class="text-warning">${_.startCase(data.attachment.state)}</small>`;
            const fileList = this.element.querySelector("#attachment-list");
            fileList.appendChild(newFile);
          } else {
            // Handle failure, e.g. show error message, etc.
          }
        })
        .catch((error) => {
          // Handle network error, e.g. show error message, etc.
        });
    }
  }
}
