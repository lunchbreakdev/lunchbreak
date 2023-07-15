module.exports = (api) => {
  api.cache(true)

  return {
    presets: [
      [
        '@babel/preset-env',
        {
          useBuiltIns: 'usage',
          corejs: 3,
          targets: {
            browsers: '>0.3%, not dead',
            node: 'current',
          },
        },
      ],
      [
        '@babel/preset-react',
        {
          development: process.env.BABEL_ENV !== 'build',
        },
      ],
      '@babel/preset-typescript',
    ],
    env: {
      build: {
        ignore: ['**/*.test.tsx', '**/*.test.ts'],
      },
    },
    minified: true,
    ignore: ['node_modules'],
  }
}
