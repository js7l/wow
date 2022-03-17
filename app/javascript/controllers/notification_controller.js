import { Controller } from "stimulus";
import consumer from "../channels/consumer";

export default class extends Controller {
  static targets = ["counter"];
  static values = { userId: Number };

  connect() {
    this.channel = consumer.subscriptions.create(
      { channel: "NotificationChannel", id: this.userIdValue },
      {
        received: (data) => {
          console.log(data);
          this.counterTarget.innerText = data.unread_count;
          this.counterTarget.classList.remove("empty");
          const chatroom = document.getElementById(
            `chatroom-${data.chatroom_id}`
          );

          if (chatroom) {
            const notifContainer = chatroom.querySelector(".notification");
            notifContainer.classList.remove("empty");
            notifContainer.innerText = data.unread_chatroom_count;
            const messageContainer = chatroom.querySelector(
              ".card-message-content"
            );
            messageContainer.innerText = data.message_content;
          }
        },
      }
    );
  }
}
