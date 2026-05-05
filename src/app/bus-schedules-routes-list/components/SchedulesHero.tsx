import React from 'react';
import AppImage from '@/components/ui/AppImage';

export default function SchedulesHero() {
  return (
    <section
      className="relative py-14 overflow-hidden"
      style={{ backgroundColor: 'var(--secondary)' }}
    >
      <div className="absolute inset-0 z-0">
        <AppImage
          src="/assets/images/RiTravel-1778014045288.png"
          alt="Ri Travel modern bus on Kosovo highway surrounded by mountains"
          fill
          priority
          className="object-cover object-center opacity-20"
          sizes="100vw"
        />
        <div
          className="absolute inset-0"
          style={{ background: 'linear-gradient(to right, rgba(26,32,53,0.95) 50%, rgba(26,32,53,0.6) 100%)' }}
        />
      </div>
      <div className="relative z-10 max-w-screen-2xl mx-auto px-4 lg:px-8 xl:px-10 2xl:px-16">
        <h1 className="text-3xl xl:text-4xl font-extrabold mb-2" style={{ color: 'var(--foreground)' }}>
          Linjat e <span style={{ color: 'var(--primary)' }}>autobusëve</span>
        </h1>
        <p className="text-sm" style={{ color: 'var(--muted-foreground)' }}>
          Gjeni oraret, çmimet dhe linjat e disponueshme për destinacionin tuaj.
        </p>
      </div>
    </section>
  );
}