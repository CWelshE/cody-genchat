// Primary entrypoint for the application.
import "phoenix_html"

// React deps
import ReactDOM from 'react-dom';

// Styling deps
/** @jsx jsx */
import { css, jsx } from '@emotion/core';

const rootApp = (
  <div 
    css={css`
        margin: 0;
        padding: 0;
        display: grid;
        height: 100vh;
        width: 100vw;
        grid-template-columns: repeat(1fr, 3);
        grid-template-rows: repeat(1fr, 3);
        font-size: 14px;
        background-color: #ffffff;
    `}
  >
  </div>
);

ReactDOM.render(
  rootApp,
  document.getElementsByClassName("root")[0]
)
