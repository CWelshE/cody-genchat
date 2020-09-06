// Author: Cody Welsh <codyw at protonmail dot com>
// For a Genity project, with some extra "spice" added
//
// The main panel representing the chat room (or private chat session).

// Main React deps
import React from "react";

// Styling deps
/** @jsx jsx */
import { css, jsx } from "@emotion/core";
import colorScheme from "../../constants";

// Panels inside the main view
import UsersList from "../UsersList/UsersList.jsx";

const chatStyles = `
  display: grid;
  grid-row: 2/3;
  grid-column: 2/3;
  grid-template-columns: 1fr 2fr;
  width: 100%;
  height: 100%;
  background-color: ${colorScheme.secondary};
`;

// import users list;
// import room view

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
      <div css={css`${chatStyles}`}>
        <UsersList users={this.props.users}/>
        <h2>Chat Panel</h2>
      </div>
    );
  }
}

export default ChatPanel;
