'use client';
import React, { useState } from 'react';
import { Search, MapPin } from 'lucide-react';

export default function ScheduleFilters() {
  const [from, setFrom] = useState('Prishtina');
  const [to, setTo] = useState('');
  const [date, setDate] = useState('2025-05-25');
  const [sortBy, setSortBy] = useState('departure');

  return (
    <div
      className="rounded-2xl p-5 mb-6"
      style={{ backgroundColor: 'var(--card)', border: '1px solid var(--border)' }}
    >
      <div className="flex flex-wrap gap-3 items-end">
        <div className="flex-1 min-w-[160px]">
          <label className="block text-xs font-medium mb-1.5" style={{ color: 'var(--muted-foreground)' }}>Nga</label>
          <div className="relative">
            <input
              type="text"
              value={from}
              onChange={(e) => setFrom(e?.target?.value)}
              className="search-input pr-9"
              placeholder="Qyteti i nisjes"
            />
            <MapPin size={14} className="absolute right-3 top-1/2 -translate-y-1/2" style={{ color: 'var(--muted-foreground)' }} />
          </div>
        </div>

        <div className="flex-1 min-w-[160px]">
          <label className="block text-xs font-medium mb-1.5" style={{ color: 'var(--muted-foreground)' }}>Ku</label>
          <div className="relative">
            <input
              type="text"
              value={to}
              onChange={(e) => setTo(e?.target?.value)}
              className="search-input pr-9"
              placeholder="Destinacioni"
            />
            <MapPin size={14} className="absolute right-3 top-1/2 -translate-y-1/2" style={{ color: 'var(--muted-foreground)' }} />
          </div>
        </div>

        <div className="flex-1 min-w-[160px]">
          <label className="block text-xs font-medium mb-1.5" style={{ color: 'var(--muted-foreground)' }}>Data</label>
          <input
            type="date"
            value={date}
            onChange={(e) => setDate(e?.target?.value)}
            className="search-input"
            style={{ colorScheme: 'dark' }}
          />
        </div>

        <div className="flex-1 min-w-[160px]">
          <label className="block text-xs font-medium mb-1.5" style={{ color: 'var(--muted-foreground)' }}>Renditje</label>
          <select
            value={sortBy}
            onChange={(e) => setSortBy(e?.target?.value)}
            className="search-input appearance-none"
          >
            <option value="departure" style={{ backgroundColor: 'var(--card)' }}>Orari i nisjes</option>
            <option value="price" style={{ backgroundColor: 'var(--card)' }}>Çmimi</option>
            <option value="duration" style={{ backgroundColor: 'var(--card)' }}>Kohëzgjatja</option>
            <option value="seats" style={{ backgroundColor: 'var(--card)' }}>Ulëse të lira</option>
          </select>
        </div>

        <button
          className="flex items-center gap-2 px-5 py-3 rounded-xl text-sm font-bold transition-all hover:brightness-110 active:scale-95"
          style={{ backgroundColor: 'var(--primary)', color: 'var(--primary-foreground)' }}
        >
          <Search size={15} />
          Kërko
        </button>
      </div>
    </div>
  );
}