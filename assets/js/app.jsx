// Primary entrypoint for the application.
import "../css/global.css";
import "phoenix_html";

// React deps
import ReactDOM from "react-dom";
import React from "react";

// Styling deps
/** @jsx jsx */
import { css, jsx } from "@emotion/core";
import colorScheme from "./constants";

const rootBase = 0;
const gridTemplates = "1fr 3fr 1fr";

// A 3x3 grid that wraps around all the children elements
// (The middle is 3x of the outside rows/columns)
const RootWrapper = () => {
  return (
    <div
      css={css`
        display: grid;
        grid-template-columns: ${gridTemplates};
        grid-template-rows: ${gridTemplates};
        height: 100%;
        width: 100%;
        margin: ${rootBase};
        padding: ${rootBase};
        font-size: 14px;
        background-color: ${colorScheme.primary};
      `}
    >
    </div>
  );
};

class AppRoot extends React.Component {
  constructor(props) {
    super(props);
  }
  render() {
    return (
      <RootWrapper>
        {this.props.children}
      </RootWrapper>
    );
  }
}

ReactDOM.render(<AppRoot/>, document.getElementsByTagName("main")[0]);
