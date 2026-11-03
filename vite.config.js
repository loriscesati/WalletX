import { defineConfig } from 'vite';
export default defineConfig({
  server: {
    host: true,
    port: 3000
  },
  build: {
    outDir: 'dist'
  },
  resolve: {
    alias: [
      { find: 'firebase/app', replacement: './node_modules/firebase/app/dist/esm/index.esm.js' },
      { find: 'firebase/auth', replacement: './node_modules/firebase/auth/dist/esm/index.esm.js' },
      { find: 'firebase/firestore', replacement: './node_modules/firebase/firestore/dist/esm/index.esm.js' }
    ]
  }
});