const { environment } = require('@rails/webpacker')
const webpack = require('webpack')

environment.plugins.append('Provide', new webpack.ProvidePlugin({
	$: 'jquery',
  jQuery: 'jquery'    
}))

module.exports = environment

environment.loaders.append('expose', {
  test: require.resolve('jquery'),
  use: [
    {
      loader: 'expose-loader',
      options: 'jQuery',
    },
    {
      loader: 'expose-loader',
      options: '$',
    }    
  ],
});








