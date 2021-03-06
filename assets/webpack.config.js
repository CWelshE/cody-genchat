const path = require("path");
const glob = require("glob");
const HardSourceWebpackPlugin = require("hard-source-webpack-plugin");

// It turns out this serves a dual purpose - Phoenix by default will use
// /priv for assets, so this moves and overwrites files at that location
// with the processed WebPack version(s).
const MiniCssExtractPlugin = require("mini-css-extract-plugin");

const TerserPlugin = require("terser-webpack-plugin");
const OptimizeCSSAssetsPlugin = require("optimize-css-assets-webpack-plugin");
const CopyWebpackPlugin = require("copy-webpack-plugin");

module.exports = (env, options) => {
  const devMode = options.mode !== "production";

  return {
    optimization: {
      minimizer: [
        new TerserPlugin({ cache: true, parallel: true, sourceMap: devMode }),
        new OptimizeCSSAssetsPlugin({})
      ]
    },
    entry: {
      app: glob.sync("./vendor/**/*.js").concat(["./js/app.jsx"])
    },
    output: {
      filename: "[name].js",
      path: path.resolve(__dirname, "../priv/static/js"),
      publicPath: "/js/"
    },
    devtool: devMode ? "eval-cheap-module-source-map" : undefined,
    module: {
      rules: [
        {
          test: /\.(jsx|js|tsx)$/,
          exclude: /node_modules/,
          use: {
            loader: "babel-loader"
          }
        },
        {
          test: /\.[s]?css$/,
          use: [MiniCssExtractPlugin.loader, "css-loader"]
        },
        {
          test: /\.(woff|woff2|ttf|otf)$/,
          use: "file-loader"
        }
      ]
    },
    plugins: [
      new CopyWebpackPlugin([{ from: "static/", to: "../" }]),
      new MiniCssExtractPlugin({ filename: "../css/global.css" })
    ].concat(devMode ? [new HardSourceWebpackPlugin()] : [])
  };
};
