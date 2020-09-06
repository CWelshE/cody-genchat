// Author: Cody Welsh <codyw at protonmail dot com>
// For a Genity project, with some extra "spice" added

// Main React deps
import React from "react";

// Styling deps
/** @jsx jsx */
import { css, jsx } from "@emotion/core";
import colorScheme from "../../constants";

// Styles relevant to the Users List
const usersStyles = css`
  display: flex;
  flex-direction: column;
  list-style: none;
  padding: 1rem;
  margin: 0;
  background-color: ${colorScheme.tertiary};
`;

// Maps user objects to list items
const mappedUsers = (users) => {
  return users.length
    ? users.map(user => <li key={user.id}>{user.name}</li>)
    : null;
};

// The user list commonly found on the left side of chat-type apps.
// Users are planned to include:
// users { username: "name", online: bool, isSecured: bool}
// Depending on how difficult it is, I may implement a "Secure this
// conversation" button, or just have it occur by default.
class UsersList extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      users: this.props.users || []
    };
  }
  render() {
    return (
      <div css={css` ${usersStyles};`}>
        {mappedUsers(this.state.users)}
      </div>
    );
  }
}

export default UsersList;
