/** @type {import('tailwindcss').Config} */
export default {
  content: ["src/**/*.{astro,md}"],
  theme: {
    extend: {
      colors: {
        brand: {
          50:  "#eef2ff",
          100: "#e0e7ff",
          400: "#6366f1",
          600: "#4f46e5",
        },
      },
      fontFamily: {
        sans: ["'Noto Sans JP'", "sans-serif"],
      },
    },
  },
  darkMode: "class",
};
