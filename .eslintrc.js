module.exports = {
  root: true,
  env: {
    browser: true,
    es6: true,
    node: true,
  },
  extends: [
    'eslint:recommended',
    'plugin:@typescript-eslint/recommended',
    'plugin:react/recommended',
    'plugin:prettier/recommended',
  ],
  parser: '@typescript-eslint/parser',
  parserOptions: {
    ecmaFeatures: {
      jsx: true,
    },
    ecmaVersion: 'latest',
    sourceType: 'module',
  },
  plugins: ['@typescript-eslint', 'react', 'react-hooks', 'import', 'prettier'],
  settings: { react: { version: 'detect' } },
  overrides: [
    {
      files: ['*.tsx'],
      rules: {
        'react-hooks/rules-of-hooks': 'error',
      },
    },
  ],
  rules: {
    'prettier/prettier': 'error',
    'react/display-name': 'off',
    'react/prop-types': [
      'warn',
      {
        skipUndeclared: true,
        ignore: ['style', 'children', 'className', 'theme'],
      },
    ],
    'react/react-in-jsx-scope': 'off',
    'react-hooks/exhaustive-deps': 'warn',
    'import/order': [
      'error',
      {
        alphabetize: { caseInsensitive: true, order: 'asc' },
        groups: [
          'builtin',
          'external',
          'internal',
          'parent',
          'sibling',
          'index',
        ],
        'newlines-between': 'always',
        pathGroups: [
          { group: 'builtin', pattern: 'react', position: 'after' },
          { group: 'builtin', pattern: '@lunchbreak/*', position: 'after' },
        ],
        pathGroupsExcludedImportTypes: [],
      },
    ],
    camelcase: ['warn', { properties: 'never' }],
    'linebreak-style': ['error', 'unix'],
    'new-cap': ['error', { capIsNew: false }],
    'no-new': 'warn',
    'no-unused-expressions': [
      'error',
      { allowShortCircuit: true, allowTernary: true },
    ],
    'no-unused-vars': [
      'error',
      { argsIgnorePattern: '^_', varsIgnorePattern: '^_' },
    ],
    'no-useless-escape': 'off',
    'prefer-spread': 'warn',
    'prefer-object-spread': 'warn',
  },
}
