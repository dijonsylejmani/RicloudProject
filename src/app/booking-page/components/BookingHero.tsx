import React from 'react';
import AppImage from '@/components/ui/AppImage';

export default function BookingHero() {
  return (
    <section className="relative py-12 overflow-hidden" style={{ backgroundColor: 'var(--secondary)' }}>
      <div className="absolute inset-0 z-0">
        <AppImage
          src="/assets/images/RiTravel-1778014045288.png"
          alt="Ri Travel bus on scenic Kosovo mountain route for booking"
          fill
          priority
          className="object-cover object-right opacity-25"
          sizes="100vw"
        />
        <div
          className="absolute inset-0"
          style={{ background: 'linear-gradient(to right, rgba(26,32,53,0.97) 40%, rgba(26,32,53,0.5) 80%, transparent)' }}
        />
      </div>
      <div className="relative z-10 max-w-screen-2xl mx-auto px-4 lg:px-8 xl:px-10 2xl:px-16">
        <h1 className="text-3xl xl:text-4xl font-extrabold mb-2" style={{ color: 'var(--foreground)' }}>
          Rezervo <span style={{ color: 'var(--primary)' }}>udhëtimin tënd</span>
        </h1>
        <p className="text-sm" style={{ color: 'var(--muted-foreground)' }}>
          Zgjidhni linjën, ulësen dhe përfundo rezervimin në pak hapa të thjeshtë.
        </p>
      </div>
    </section>
  );
}