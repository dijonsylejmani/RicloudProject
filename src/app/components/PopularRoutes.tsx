import React from 'react';
import Link from 'next/link';
import { Clock, ArrowRight, ChevronRight } from 'lucide-react';

const routes = [
  { id: 'route-001', from: 'Prishtina', to: 'Pejë', time: '08:00', duration: '1 orë 20 min', price: '€7.00', seats: 12, key: 'pop-route-001' },
  { id: 'route-002', from: 'Prishtina', to: 'Gjakovë', time: '09:30', duration: '1 orë 45 min', price: '€8.00', seats: 4, key: 'pop-route-002' },
  { id: 'route-003', from: 'Prishtina', to: 'Prizren', time: '10:30', duration: '1 orë 30 min', price: '€8.00', seats: 18, key: 'pop-route-003' },
  { id: 'route-004', from: 'Prishtina', to: 'Mitrovicë', time: '11:00', duration: '45 min', price: '€5.00', seats: 22, key: 'pop-route-004' },
  { id: 'route-005', from: 'Prishtina', to: 'Ferizaj', time: '12:00', duration: '35 min', price: '€4.00', seats: 0, key: 'pop-route-005' },
];

export default function PopularRoutes() {
  return (
    <div>
      <div className="flex items-center justify-between mb-4">
        <h2 className="text-base font-bold" style={{ color: 'var(--foreground)' }}>Linjat më të njohura</h2>
        <Link
          href="/bus-schedules-routes-list"
          className="flex items-center gap-1 text-xs font-semibold transition-colors hover:underline"
          style={{ color: 'var(--primary)' }}
        >
          Shiko të gjitha <ChevronRight size={13} />
        </Link>
      </div>
      <div className="flex flex-col gap-3">
        {routes?.map((route) => (
          <div
            key={route?.key}
            className="rounded-xl p-4 transition-all duration-150 hover:border-primary"
            style={{ backgroundColor: 'var(--card)', border: '1px solid var(--border)' }}
          >
            <div className="flex items-center justify-between">
              <div className="flex-1">
                <div className="flex items-center gap-2 mb-1.5">
                  <span className="text-sm font-bold" style={{ color: 'var(--foreground)' }}>{route?.from}</span>
                  <ArrowRight size={13} style={{ color: 'var(--primary)' }} />
                  <span className="text-sm font-bold" style={{ color: 'var(--foreground)' }}>{route?.to}</span>
                </div>
                <div className="flex items-center gap-3">
                  <span className="flex items-center gap-1 text-xs" style={{ color: 'var(--muted-foreground)' }}>
                    <Clock size={11} /> {route?.time}
                  </span>
                  <span className="flex items-center gap-1 text-xs" style={{ color: 'var(--muted-foreground)' }}>
                    <Clock size={11} /> {route?.duration}
                  </span>
                </div>
              </div>
              <div className="flex items-center gap-3 ml-4">
                <span className="text-base font-extrabold tabular-nums" style={{ color: 'var(--primary)' }}>{route?.price}</span>
                {route?.seats === 0 ? (
                  <span className="badge badge-full text-xs px-2 py-1 rounded-lg">Plot</span>
                ) : (
                  <Link
                    href="/booking-page"
                    className="px-3 py-1.5 rounded-lg text-xs font-semibold transition-all hover:brightness-110 active:scale-95"
                    style={{ backgroundColor: 'var(--primary)', color: 'var(--primary-foreground)' }}
                  >
                    Detajet
                  </Link>
                )}
              </div>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}