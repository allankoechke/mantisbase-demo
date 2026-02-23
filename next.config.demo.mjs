/**
 * Wrapper Next.js config for building the mb UI without editing the mb submodule.
 * Adds webpack alias so @/ resolves. Used by copying this file into the build
 * directory as next.config.mjs so __dirname is the project root.
 */
import path from 'path';
import { fileURLToPath } from 'url';
const __dirname = path.dirname(fileURLToPath(import.meta.url));

// When this file is copied to mb/ (or a copy of mb) as next.config.mjs,
// we need the mb config. Use createRequire so we load from the same directory.
import { createRequire } from 'module';
const require = createRequire(import.meta.url);
const { version } = require('./package.json');

/** @type {import('next').NextConfig} */
const nextConfig = {
  basePath: typeof process.env.NEXT_PUBLIC_BASE_PATH !== "undefined"
    ? process.env.NEXT_PUBLIC_BASE_PATH
    : process.env.NODE_ENV === "production"
      ? "/mb"
      : "",
  env: { MANTIS_ADMIN_VERSION: version },
  eslint: { ignoreDuringBuilds: true },
  typescript: { ignoreBuildErrors: true },
  images: { unoptimized: true },
  ...(process.env.NODE_ENV === 'production' && { output: 'export' }),
  trailingSlash: true,
  webpack(config) {
    config.resolve.alias = {
      ...config.resolve.alias,
      '@': path.resolve(__dirname, '.'),
    };
    return config;
  },
};

export default nextConfig;
