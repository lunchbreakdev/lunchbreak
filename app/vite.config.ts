import path from 'path'

import react from '@vitejs/plugin-react'
import { defineConfig } from 'vite'

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [react()],
  resolve: {
    alias: [
      {
        find: /^@lunchbreak\/(.*)$/,
        replacement: `${path.resolve('..')}/packages/$1/src`,
      },
    ],
  },
})
