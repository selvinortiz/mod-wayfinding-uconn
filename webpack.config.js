const path = require('path');
const sync = require('browser-sync-webpack-plugin');

const { VueLoaderPlugin } = require('vue-loader');

process.traceDeprecation = true;

// Define webpack plugins and their configs
const plugins = [new VueLoaderPlugin()];

// Use browser sync in specific environments
if (process.env.CRAFT_HOST_URL) {
  plugins.push(
    new sync({
      files: ['templates/**/*', 'lib/modules/**/**', 'lib/plugins/**/**'],
      proxy: process.env.CRAFT_HOST_URL
    })
  );
}

module.exports = {
  entry: {
    app: ['./src/js/app.js', './src/scss/app.scss']
  },
  output: {
    filename: '[name].js',
    path: path.resolve(__dirname, 'web/js'),
    publicPath: '/js/'
  },
  module: {
    rules: [
      {
        test: /\.scss$/,
        use: [
          {
            loader: 'file-loader',
            options: {
              name: '[name].css',
              outputPath: '../css/'
            }
          },
          {
            loader: 'extract-loader'
          },
          {
            loader: 'css-loader'
          },
          {
            loader: 'postcss-loader'
          },
          {
            loader: 'sass-loader',
            options: {
              includePaths: [path.resolve(__dirname, 'node_modules')]
            }
          }
        ]
      },
      {
        test: /\.css$/,
        use: ['vue-style-loader', 'css-loader']
      },
      {
        test: /\.vue$/,
        loader: 'vue-loader',
        options: {
          loaders: {
            css: [
              'vue-style-loader',
              {
                loader: 'css-loader'
              }
            ],
            js: ['babel-loader']
          },
          cacheBusting: true
        }
      },
      {
        test: /\.js$/,
        exclude: /node_modules/,
        use: 'babel-loader'
      },
      {
        test: /\.svg$/,
        loader: 'vue-svg-loader'
      }
    ]
  },
  resolve: {
    alias: {
      vue: 'vue/dist/vue.js'
    }
  },
  performance: {
    hints: false
  },
  plugins
};
