'use client';
import React, { useState } from 'react';
import Link from 'next/link';
import AppImage from '@/components/ui/AppImage';
import { Search, MapPin, ArrowLeftRight, Clock, CreditCard, Smartphone } from 'lucide-react';

const destinations = ['Pejë', 'Gjakovë', 'Prizren', 'Mitrovicë', 'Ferizaj', 'Gjilan', 'Vushtrri', 'Skenderaj'];

export default function HeroSection() {
  const [tripType, setTripType] = useState<'one-way' | 'round-trip'>('one-way');
  const [from, setFrom] = useState('Prishtina');
  const [to, setTo] = useState('');
  const [date, setDate] = useState('2025-05-25');

  const handleSwap = () => {
    const tmp = from;
    setFrom(to);
    setTo(tmp);
  };

  return (
    <section className="relative min-h-[560px] flex items-center overflow-hidden" style={{ backgroundColor: 'var(--secondary)' }}>
      {/* Background image */}
      <div className="absolute inset-0 z-0">
        <AppImage
          src="/assets/images/RiTravel-1778014045288.png"
          alt="Ri Travel bus driving through scenic Kosovo mountain road at sunset"
          fill
          priority
          className="object-cover object-center opacity-30"
          sizes="100vw"
        />
        <div
          className="absolute inset-0"
          style={{
            background: 'linear-gradient(to right, rgba(26,32,53,0.97) 45%, rgba(26,32,53,0.5) 70%, rgba(26,32,53,0.15) 100%)',
          }}
        />
      </div>
      <div className="relative z-10 max-w-screen-2xl mx-auto px-4 lg:px-8 xl:px-10 2xl:px-16 w-full py-16">
        <div className="grid grid-cols-1 lg:grid-cols-2 gap-10 items-center">
          {/* Left: Text + Search */}
          <div>
            <h1 className="text-4xl xl:text-5xl font-extrabold leading-tight mb-4" style={{ color: 'var(--foreground)' }}>
              Udhëto më mirë,{' '}
              <span style={{ color: 'var(--primary)' }}>rezervo</span> më lehtë.
            </h1>
            <p className="text-base mb-8 leading-relaxed" style={{ color: 'var(--muted-foreground)' }}>
              Rezervo biletën tënde online për çdo destinacion<br />
              në <span style={{ color: 'var(--primary)' }}>Kosovë</span> dhe më gjerë.
            </p>

            {/* Search Card */}
            <div
              className="rounded-2xl p-5"
              style={{ backgroundColor: 'rgba(15,21,32,0.92)', border: '1px solid var(--border)' }}
            >
              {/* Tabs */}
              <div className="flex gap-1 mb-5 border-b" style={{ borderColor: 'var(--border)' }}>
                <button
                  onClick={() => setTripType('one-way')}
                  className={`flex items-center gap-2 px-4 py-2.5 text-sm font-semibold transition-colors border-b-2 -mb-px ${
                    tripType === 'one-way' ? 'border-primary text-primary' : 'border-transparent'
                  }`}
                  style={{ color: tripType === 'one-way' ? 'var(--primary)' : 'var(--muted-foreground)' }}
                >
                  <MapPin size={14} />
                  Biletë një drejtim
                </button>
                <button
                  onClick={() => setTripType('round-trip')}
                  className={`flex items-center gap-2 px-4 py-2.5 text-sm font-semibold transition-colors border-b-2 -mb-px ${
                    tripType === 'round-trip' ? 'border-primary text-primary' : 'border-transparent'
                  }`}
                  style={{ color: tripType === 'round-trip' ? 'var(--primary)' : 'var(--muted-foreground)' }}
                >
                  <ArrowLeftRight size={14} />
                  Biletë vajtje-ardhje
                </button>
              </div>

              {/* Fields */}
              <div className="grid grid-cols-1 sm:grid-cols-3 gap-3 mb-4">
                <div className="relative">
                  <label className="block text-xs font-medium mb-1.5" style={{ color: 'var(--muted-foreground)' }}>Nga</label>
                  <div className="relative">
                    <input
                      type="text"
                      value={from}
                      onChange={(e) => setFrom(e?.target?.value)}
                      className="search-input pr-10"
                      placeholder="Qyteti i nisjes"
                    />
                    <MapPin size={15} className="absolute right-3 top-1/2 -translate-y-1/2" style={{ color: 'var(--muted-foreground)' }} />
                  </div>
                </div>

                <div className="relative">
                  <label className="block text-xs font-medium mb-1.5" style={{ color: 'var(--muted-foreground)' }}>Ku</label>
                  <div className="relative">
                    <select
                      value={to}
                      onChange={(e) => setTo(e?.target?.value)}
                      className="search-input pr-10 appearance-none"
                    >
                      <option value="">Zgjidhni destinacionin</option>
                      {destinations?.map((d) => (
                        <option key={`dest-${d}`} value={d} style={{ backgroundColor: 'var(--card)' }}>
                          {d}
                        </option>
                      ))}
                    </select>
                    <MapPin size={15} className="absolute right-3 top-1/2 -translate-y-1/2 pointer-events-none" style={{ color: 'var(--muted-foreground)' }} />
                  </div>
                </div>

                <div>
                  <label className="block text-xs font-medium mb-1.5" style={{ color: 'var(--muted-foreground)' }}>Data e udhëtimit</label>
                  <div className="relative">
                    <input
                      type="date"
                      value={date}
                      onChange={(e) => setDate(e?.target?.value)}
                      className="search-input"
                      style={{ colorScheme: 'dark' }}
                    />
                  </div>
                </div>
              </div>

              <Link
                href="/bus-schedules-routes-list"
                className="w-full flex items-center justify-center gap-2 py-3.5 rounded-xl text-sm font-bold transition-all hover:brightness-110 active:scale-95"
                style={{ backgroundColor: 'var(--primary)', color: 'var(--primary-foreground)' }}
              >
                <Search size={17} />
                Kërko Linja
              </Link>

              {/* Trust badges */}
              <div className="flex flex-wrap items-center gap-4 mt-4">
                <span className="flex items-center gap-1.5 text-xs" style={{ color: 'var(--muted-foreground)' }}>
                  <Clock size={13} style={{ color: 'var(--primary)' }} />
                  Rezervim i shpejtë
                </span>
                <span className="flex items-center gap-1.5 text-xs" style={{ color: 'var(--muted-foreground)' }}>
                  <CreditCard size={13} style={{ color: 'var(--primary)' }} />
                  Pagesë e sigurt
                </span>
                <span className="flex items-center gap-1.5 text-xs" style={{ color: 'var(--muted-foreground)' }}>
                  <Smartphone size={13} style={{ color: 'var(--primary)' }} />
                  Bileta elektronike
                </span>
              </div>
            </div>
          </div>

          {/* Right: Bus image visible on large screens */}
          <div className="hidden lg:block" />
        </div>
      </div>
    </section>
  );
}