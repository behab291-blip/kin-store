import "./globals.css";
export const metadata = { title: "KIN — Wear Your Identity", description: "KIN streetwear — printed hoodies and tees." };
export default function RootLayout({children}:{children:React.ReactNode}) {
 return <html lang="en"><body>{children}</body></html>;
}