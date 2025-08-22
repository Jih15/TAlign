/** @type {import("next").NextConfig} */
const nextConfig = {
  images: {
    remotePatterns: [
      {
        protocol: "https",
        hostname: "cdn.sanity.io",
      },
      {
        protocol: "https",
        hostname: "lh3.googleusercontent.com",
      },
      {
        protocol: "https",
        hostname: "avatars.githubusercontent.com",
      },
      {
        protocol: "https",
        hostname: "pub-b7fd9c30cdbf439183b75041f5f71b92.r2.dev",
      },
      {
        protocol: "https",
        hostname: "static.vecteezy.com",
        pathname: "/system/resources/thumbnails/**",
      },

      // 🔹 Tambahin backend FastAPI lokal
      {
        protocol: "http",
        hostname: "127.0.0.1",
        port: "8000",
        pathname: "/static/**",
      },
      {
        protocol: "http",
        hostname: "localhost",
        port: "8000",
        pathname: "/static/**",
      },
    ],
  },
};

export default nextConfig;
