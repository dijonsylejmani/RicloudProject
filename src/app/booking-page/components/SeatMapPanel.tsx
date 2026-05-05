'use client';
import React, { useState } from 'react';
import { Eye } from 'lucide-react';

// Seats 1-48, occupied seats
const occupiedSeats = new Set([3, 7, 11, 19, 20, 24, 32, 43, 44, 48]);

interface SeatMapPanelProps {
  selectedSeat: number | null;
  onSelectSeat: (seat: number | null) => void;
}

export default function SeatMapPanel({ selectedSeat, onSelectSeat }: SeatMapPanelProps) {
  const handleSeatClick = (seatNum: number) => {
    if (occupiedSeats.has(seatNum)) return;
    if (selectedSeat === seatNum) {
      onSelectSeat(null);
    } else {
      onSelectSeat(seatNum);
    }
  };

  const getSeatClass = (seatNum: number) => {
    if (occupiedSeats.has(seatNum)) return 'seat-occupied';
    if (selectedSeat === seatNum) return 'seat-selected';
    return 'seat-free';
  };

  // Rows: 12 rows of 4 seats each = 48 seats
  // Layout: [col1, col2] aisle [col3, col4]
  const rows = Array.from({ length: 12 }, (_, i) => {
    const base = i * 4;
    return [base + 1, base + 2, base + 3, base + 4];
  });

  return (
    <div
      className="rounded-2xl p-5"
      style={{ backgroundColor: 'var(--card)', border: '1px solid var(--border)' }}
    >
      <div className="flex items-center justify-between mb-4">
        <h3 className="text-sm font-bold" style={{ color: 'var(--foreground)' }}>Zgjidhni ulësen tënde</h3>
        <div className="flex items-center gap-3 text-xs" style={{ color: 'var(--muted-foreground)' }}>
          <span className="flex items-center gap-1.5">
            <span className="w-4 h-4 rounded border-2 border-green-500 inline-block" />
            E lirë
          </span>
          <span className="flex items-center gap-1.5">
            <span className="w-4 h-4 rounded inline-block" style={{ backgroundColor: '#4b5563', border: '2px solid #6b7280' }} />
            E zënë
          </span>
          <span className="flex items-center gap-1.5">
            <span className="w-4 h-4 rounded inline-block" style={{ backgroundColor: 'var(--primary)', border: '2px solid var(--primary)' }} />
            E zgjedhur
          </span>
        </div>
      </div>

      {/* Bus body */}
      <div
        className="rounded-2xl p-4 mx-auto"
        style={{
          maxWidth: '320px',
          backgroundColor: 'var(--background)',
          border: '2px solid var(--border)',
          borderRadius: '2rem',
        }}
      >
        {/* Driver area */}
        <div className="flex items-center justify-between mb-4 px-2">
          <div className="flex gap-2">
            <div className="w-9 h-9 rounded-lg seat-driver flex items-center justify-center text-xs font-bold" />
            <div className="w-9 h-9 rounded-lg seat-driver flex items-center justify-center text-xs font-bold" />
          </div>
          <div
            className="w-10 h-10 rounded-full border-4 flex items-center justify-center"
            style={{ borderColor: 'var(--muted)', backgroundColor: 'var(--muted)' }}
          >
            <span className="text-xs" style={{ color: 'var(--muted-foreground)' }}>🚌</span>
          </div>
        </div>

        {/* Seat rows */}
        <div className="flex flex-col gap-1.5">
          {rows.map((row, rowIdx) => (
            <div key={`seat-row-${rowIdx + 1}`} className="flex items-center gap-1.5">
              {/* Row number */}
              <span className="w-4 text-xs text-center flex-shrink-0" style={{ color: 'var(--muted-foreground)' }}>
                {rowIdx + 1}
              </span>
              {/* Left pair */}
              <button
                onClick={() => handleSeatClick(row[0])}
                className={`w-9 h-9 rounded-lg text-xs font-bold transition-all duration-150 ${getSeatClass(row[0])}`}
                disabled={occupiedSeats.has(row[0])}
                title={`Ulësja ${row[0]}`}
              >
                {row[0]}
              </button>
              <button
                onClick={() => handleSeatClick(row[1])}
                className={`w-9 h-9 rounded-lg text-xs font-bold transition-all duration-150 ${getSeatClass(row[1])}`}
                disabled={occupiedSeats.has(row[1])}
                title={`Ulësja ${row[1]}`}
              >
                {row[1]}
              </button>
              {/* Aisle */}
              <div className="w-4" />
              {/* Right pair */}
              <button
                onClick={() => handleSeatClick(row[2])}
                className={`w-9 h-9 rounded-lg text-xs font-bold transition-all duration-150 ${getSeatClass(row[2])}`}
                disabled={occupiedSeats.has(row[2])}
                title={`Ulësja ${row[2]}`}
              >
                {row[2]}
              </button>
              <button
                onClick={() => handleSeatClick(row[3])}
                className={`w-9 h-9 rounded-lg text-xs font-bold transition-all duration-150 ${getSeatClass(row[3])}`}
                disabled={occupiedSeats.has(row[3])}
                title={`Ulësja ${row[3]}`}
              >
                {row[3]}
              </button>
            </div>
          ))}
        </div>
      </div>

      {/* View toggle */}
      <div className="flex justify-center mt-4">
        <button
          className="flex items-center gap-2 px-4 py-2 rounded-xl text-sm font-medium transition-colors hover:bg-white/10"
          style={{ border: '1px solid var(--border)', color: 'var(--muted-foreground)' }}
        >
          <Eye size={15} />
          Pamje tjetër
        </button>
      </div>
    </div>
  );
}