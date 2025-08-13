import { NextResponse } from 'next/server';
import type { NextRequest } from 'next/server';
import { jwtDecode } from 'jwt-decode';

interface TokenPayload {
  role: string;
  // Tambah sesuai isi token lainnya jika perlu
}

export function middleware(req: NextRequest) {
  const token = req.cookies.get('access_token')?.value;

const protectedPaths = ['/', '/dashboard', '/admin'];

  const pathIsProtected = protectedPaths.some((path) =>
    req.nextUrl.pathname.startsWith(path)
  );

  // Jika route tidak perlu proteksi, lanjutkan
  if (!pathIsProtected) {
    return NextResponse.next();
  }

  // Jika tidak ada token, redirect ke login
  if (!token) {
    return NextResponse.redirect(new URL('/auth/sign-in', req.url));
  }

  try {
    const decoded = jwtDecode<TokenPayload>(token);

    // Blokir mahasiswa
    if (decoded.role === 'mahasiswa') {
      return NextResponse.redirect(new URL('/unauthorized', req.url));
    }

    // Role selain mahasiswa boleh lanjut
    return NextResponse.next();
  } catch (err) {
    console.error('Invalid token:', err);
    return NextResponse.redirect(new URL('/auth/sign-in', req.url));
  }
}
