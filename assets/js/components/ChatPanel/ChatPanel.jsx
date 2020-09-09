// Author: Cody Welsh <codyw at protonmail dot com>
// For a Genity project, with some extra "spice" added

// Main React deps
import React from "react";

// Styling deps
/** @jsx jsx */
import { css, jsx } from "@emotion/core";
import colorScheme from "../../constants";
import "fontsource-fira-mono";

// Panels inside the main view
import UsersList from "../UsersList/UsersList.jsx";
import MsgList from "../MsgList/MsgList.jsx";

const chatStyles = `
  display: grid;
  grid-row: 2/3;
  grid-column: 2/3;
  grid-template-columns: 1fr 2fr;
  width: 100%;
  height: 100%;
  background-color: ${colorScheme.secondary};
`;

// The main panel representing the chat room (or private chat session).
// Contains the interactable elements of the application.
class ChatPanel extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      users: [],
      currentUser: {},
      chatHistory: [],
    };
    this.clickUser = this.clickUser.bind(this);
  }

  clickUser(e, user) {
    this.setState({
      currentUser: user
    });
  }

  componentDidUpdate() {
    console.log("update:", this.state.currentUser);
  }

  render() {
    return (
      <div css={css`${chatStyles}`}>
        <UsersList
          clickUser={this.clickUser}
          users={this.state.users}/>
        <MsgList
          messages={this.state.messages}
          currentUser={this.state.currentUser}/>
      </div>
    );
  }
}

export default ChatPanel;
