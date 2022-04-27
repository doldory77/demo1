const path = require("path");
const URL_PATH = process.env.NODE_ENV === "production" ? "/" : "/dist";

module.exports = {
  runtimeCompiler: true,
  devServer: {
    proxy: {
      "/api": {
        target: "http://localhost:8080",
        changeOrigin: true,
        // cookieDomainRewrite: { "localhost:8080": "localhost:8888" },
        logLevel: "debug",
      },
    },
    port: 8888,
  },
  configureWebpack: {
    devtool: "source-map",
  },
  outputDir: path.join(__dirname, URL_PATH),
  publicPath: URL_PATH,
};
