export default function AuthLayout({ children }: { children: React.ReactNode }) {
  return (
    <div className="min-h-screen flex items-center justify-center">
      {children}  {/* Layout minimal untuk auth pages */}
    </div>
  );
}