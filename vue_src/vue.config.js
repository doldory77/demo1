const path = require("path");

module.exports = {
  runtimeCompiler: true,
  devServer: {
    proxy: {
      "/api": {
        target: "http://localhost:8080",
        ws: true,
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
  outputDir: path.join(__dirname, "/dist"),
  publicPath: process.env.NODE_ENV === "production" ? "/" : "/dist",
};
