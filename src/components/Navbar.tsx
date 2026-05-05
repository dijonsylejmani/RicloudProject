'use client';
import React, { useState } from 'react';
import Link from 'next/link';
import { usePathname } from 'next/navigation';
import AppLogo from '@/components/ui/AppLogo';
import { Menu, X, Globe, ChevronDown, User, Ticket } from 'lucide-react';

const navLinks = [
  { label: 'Ballina', href: '/' },
  { label: 'Linjat', href: '/bus-schedules-routes-list' },
  { label: 'Rezervo', href: '/booking-page' },
  { label: 'Live Track', href: '#live-track' },
  { label: 'Rreth Nesh', href: '#rreth-nesh' },
  { label: 'Kontakt', href: '#kontakt' },
];

export default function Navbar() {
  const pathname = usePathname();
  const [mobileOpen, setMobileOpen] = useState(false);

  return (
    <nav
      className="sticky top-0 z-50 w-full"
      style={{ backgroundColor: 'var(--secondary)', borderBottom: '1px solid var(--border)' }}
    >
      <div className="max-w-screen-2xl mx-auto px-4 lg:px-8 xl:px-10 2xl:px-16">
        <div className="flex items-center justify-between h-16">
          {/* Logo */}
          <Link href="/" className="flex items-center gap-2 flex-shrink-0">
            <AppLogo
              src="/assets/images/RiTravel-1778014045288.png"
              size={40}
            />
            <span className="font-extrabold text-lg tracking-tight" style={{ color: 'var(--foreground)' }}>
              Ri<span style={{ color: 'var(--primary)' }}>Travel</span>
            </span>
          </Link>

          {/* Desktop Nav */}
          <div className="hidden lg:flex items-center gap-7">
            {navLinks?.map((link) => {
              const isActive = pathname === link?.href;
              return (
                <Link
                  key={`nav-${link?.href}`}
                  href={link?.href}
                  className={`nav-link text-sm font-medium pb-1 ${isActive ? 'active' : ''}`}
                >
                  {link?.label}
                </Link>
              );
            })}
          </div>

          {/* Actions */}
          <div className="hidden lg:flex items-center gap-3">
            <button
              className="flex items-center gap-1 text-sm font-medium transition-colors hover:text-primary"
              style={{ color: 'var(--muted-foreground)' }}
            >
              <Globe size={16} />
              SQ
              <ChevronDown size={14} />
            </button>
            <Link
              href="/booking-page"
              className="flex items-center gap-2 px-4 py-2 rounded-lg text-sm font-semibold transition-all hover:bg-white/10 border"
              style={{ borderColor: 'var(--border)', color: 'var(--foreground)' }}
            >
              <User size={15} />
              Hyr / Regjistrohu
            </Link>
            <Link
              href="/booking-page"
              className="flex items-center gap-2 px-4 py-2 rounded-lg text-sm font-semibold transition-all hover:brightness-110 active:scale-95"
              style={{ backgroundColor: 'var(--primary)', color: 'var(--primary-foreground)' }}
            >
              <Ticket size={15} />
              Rezervo Tani
            </Link>
          </div>

          {/* Mobile hamburger */}
          <button
            className="lg:hidden p-2 rounded-lg transition-colors hover:bg-white/10"
            onClick={() => setMobileOpen(!mobileOpen)}
            aria-label="Toggle menu"
          >
            {mobileOpen ? <X size={22} /> : <Menu size={22} />}
          </button>
        </div>
      </div>
      {/* Mobile Drawer */}
      {mobileOpen && (
        <div
          className="lg:hidden px-4 pb-4 pt-2 flex flex-col gap-2"
          style={{ backgroundColor: 'var(--secondary)', borderTop: '1px solid var(--border)' }}
        >
          {navLinks?.map((link) => (
            <Link
              key={`mobile-nav-${link?.href}`}
              href={link?.href}
              className="py-2 text-sm font-medium transition-colors hover:text-primary"
              style={{ color: 'var(--foreground)' }}
              onClick={() => setMobileOpen(false)}
            >
              {link?.label}
            </Link>
          ))}
          <hr style={{ borderColor: 'var(--border)' }} />
          <Link
            href="/booking-page"
            className="flex items-center justify-center gap-2 py-2.5 rounded-lg text-sm font-semibold"
            style={{ backgroundColor: 'var(--primary)', color: 'var(--primary-foreground)' }}
            onClick={() => setMobileOpen(false)}
          >
            <Ticket size={15} />
            Rezervo Tani
          </Link>
        </div>
      )}
    </nav>
  );
}