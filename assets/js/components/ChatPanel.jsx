// The main panel representing the chat room (or private chat session).

import React from "react";

class ChatPanel extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      users: [],
      chatHistory: [],
      privConvos: [],
    };
  }

  render() {
    return (
      <h2>
        Render result of ChatPanel
      </h2>
    );
  }
}

export default ChatPanel;
