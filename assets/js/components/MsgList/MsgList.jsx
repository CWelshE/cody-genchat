// Author: Cody Welsh <codyw at protonmail dot com>
// For a Genity project, with some extra "spice" added

// Main React deps
import React from "react";

// Styling deps
/** @jsx jsx */
import { css, jsx } from "@emotion/core";
import colorScheme from "../../constants";

// Styles relevant to the Users List
const msgStyles = css`
  display: flex;
  font-family: inherit;
  flex-direction: column;
  list-style: none;
  padding: 1rem;
  margin: 0;
  background-color: ${colorScheme.secondary};
`;

class MsgList extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      messages: this.props.messages || [],
    };
  }

  componentDidUpdate() {
    console.log("MsgList Update", this.state.currentUser);
  }

  render() {
    return (
      <div css={css` ${msgStyles};`}>
        <h3>{this.props.currentUser.name}</h3>
      </div>
    );
  }
}

export default MsgList;
