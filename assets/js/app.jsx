// Primary entrypoint for the application.
import "phoenix_html";
import "../css/global.css";

// React deps
import ReactDOM from "react-dom";

// Styling deps
/** @jsx jsx */
import { css, jsx } from "@emotion/core";

const rootBase = 0;
const gridTemplates = "repeat(3, 1fr)";
const rootApp = (
  <div
    css={css`
      margin: ${rootBase};
      padding: ${rootBase};
      display: grid;
      grid-template-columns: ${gridTemplates};
      grid-template-rows: ${gridTemplates};
      font-size: 14px;
      background-color: #ffffff;
      border: 10px solid red;
    `}
  />
);

ReactDOM.render(rootApp, document.getElementsByClassName("root")[0]);
