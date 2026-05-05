import React from 'react';
import { MapPin, Navigation } from 'lucide-react';

export default function LiveTrackTeaser() {
  return (
    <div>
      <div className="flex items-center justify-between mb-4">
        <h2 className="text-base font-bold" style={{ color: 'var(--foreground)' }}>Ndiq autobusin tënd live</h2>
        <button className="flex items-center gap-1 text-xs font-semibold" style={{ color: 'var(--primary)' }}>
          Shiko më shumë →
        </button>
      </div>
      {/* Mock map */}
      <div
        className="relative rounded-xl overflow-hidden mb-3"
        style={{ height: '180px', backgroundColor: '#1e2d40', border: '1px solid var(--border)' }}
      >
        {/* Fake map grid */}
        <div className="absolute inset-0 opacity-20">
          {Array.from({ length: 6 })?.map((_, i) => (
            <div
              key={`hline-${i + 1}`}
              className="absolute w-full border-t"
              style={{ top: `${(i + 1) * 16.6}%`, borderColor: 'rgba(255,255,255,0.3)' }}
            />
          ))}
          {Array.from({ length: 8 })?.map((_, i) => (
            <div
              key={`vline-${i + 1}`}
              className="absolute h-full border-l"
              style={{ left: `${(i + 1) * 12.5}%`, borderColor: 'rgba(255,255,255,0.3)' }}
            />
          ))}
        </div>

        {/* Route line */}
        <svg className="absolute inset-0 w-full h-full" viewBox="0 0 400 180" preserveAspectRatio="none">
          <path d="M 40 130 Q 120 80 200 100 Q 280 120 360 60" stroke="#22c55e" strokeWidth="3" fill="none" strokeDasharray="6 3" />
        </svg>

        {/* City labels */}
        <div
          className="absolute px-2 py-1 rounded text-xs font-semibold"
          style={{ left: '6%', top: '60%', backgroundColor: 'rgba(26,32,53,0.9)', color: 'var(--foreground)', border: '1px solid var(--border)' }}
        >
          Prishtina
        </div>
        <div
          className="absolute px-2 py-1 rounded text-xs font-semibold"
          style={{ right: '6%', top: '20%', backgroundColor: 'rgba(26,32,53,0.9)', color: 'var(--foreground)', border: '1px solid var(--border)' }}
        >
          Rrugore
        </div>

        {/* Bus dot */}
        <div
          className="absolute w-6 h-6 rounded-full flex items-center justify-center"
          style={{ left: '48%', top: '48%', backgroundColor: '#22c55e', transform: 'translate(-50%,-50%)' }}
        >
          <Navigation size={12} color="white" />
        </div>

        {/* Start pin */}
        <div
          className="absolute w-4 h-4 rounded-full"
          style={{ left: '8%', top: '65%', backgroundColor: 'var(--primary)', transform: 'translate(-50%,-50%)' }}
        />
      </div>
      {/* Bus info strip */}
      <div
        className="rounded-xl p-3 flex flex-wrap gap-4"
        style={{ backgroundColor: 'var(--secondary)', border: '1px solid var(--border)' }}
      >
        <div className="flex items-center gap-2">
          <div
            className="w-8 h-8 rounded-lg flex items-center justify-center"
            style={{ backgroundColor: 'rgba(245,166,35,0.12)' }}
          >
            <MapPin size={14} style={{ color: 'var(--primary)' }} />
          </div>
          <div>
            <p className="text-xs" style={{ color: 'var(--muted-foreground)' }}>Pozicioni aktual</p>
            <p className="text-xs font-bold" style={{ color: 'var(--foreground)' }}>Autobusi është 20 minuta larg</p>
          </div>
        </div>
        <div>
          <p className="text-xs" style={{ color: 'var(--muted-foreground)' }}>Shpejtësia</p>
          <p className="text-sm font-bold tabular-nums" style={{ color: 'var(--foreground)' }}>80 km/h</p>
        </div>
        <div>
          <p className="text-xs" style={{ color: 'var(--muted-foreground)' }}>Mbërritja e parashikuar</p>
          <p className="text-sm font-bold tabular-nums" style={{ color: 'var(--foreground)' }}>11:30</p>
        </div>
      </div>
    </div>
  );
}