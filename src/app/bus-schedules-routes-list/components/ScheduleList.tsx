'use client';
import React, { useState } from 'react';
import Link from 'next/link';
import { Wifi, AirVent, Zap, Toilet, ChevronDown, ChevronUp, ArrowRight, Bus } from 'lucide-react';

const schedules = [
  {
    id: 'trip-001',
    from: 'Prishtina',
    to: 'Pejë',
    departure: '08:00',
    arrival: '09:20',
    duration: '1 orë 20 min',
    price: 7.00,
    seatsTotal: 49,
    seatsTaken: 37,
    busType: 'Setra S 515 HD',
    amenities: ['wifi', 'ac', 'power', 'wc'],
    company: 'RI TRAVEL',
    stops: ['Fushë Kosovë', 'Klinë'],
  },
  {
    id: 'trip-002',
    from: 'Prishtina',
    to: 'Gjakovë',
    departure: '09:30',
    arrival: '11:15',
    duration: '1 orë 45 min',
    price: 8.00,
    seatsTotal: 49,
    seatsTaken: 45,
    busType: 'Mercedes Tourismo',
    amenities: ['wifi', 'ac', 'wc'],
    company: 'RI TRAVEL',
    stops: ['Suharekë'],
  },
  {
    id: 'trip-003',
    from: 'Prishtina',
    to: 'Prizren',
    departure: '10:30',
    arrival: '12:00',
    duration: '1 orë 30 min',
    price: 8.00,
    seatsTotal: 49,
    seatsTaken: 11,
    busType: 'Neoplan Tourliner',
    amenities: ['wifi', 'ac', 'power', 'wc'],
    company: 'RI TRAVEL',
    stops: ['Suharekë', 'Therandë'],
  },
  {
    id: 'trip-004',
    from: 'Prishtina',
    to: 'Mitrovicë',
    departure: '11:00',
    arrival: '11:45',
    duration: '45 min',
    price: 5.00,
    seatsTotal: 49,
    seatsTaken: 27,
    busType: 'Setra S 415 HD',
    amenities: ['ac', 'power'],
    company: 'RI TRAVEL',
    stops: ['Vushtrri'],
  },
  {
    id: 'trip-005',
    from: 'Prishtina',
    to: 'Ferizaj',
    departure: '12:00',
    arrival: '12:35',
    duration: '35 min',
    price: 4.00,
    seatsTotal: 49,
    seatsTaken: 49,
    busType: 'Mercedes Tourismo',
    amenities: ['ac'],
    company: 'RI TRAVEL',
    stops: [],
  },
  {
    id: 'trip-006',
    from: 'Prishtina',
    to: 'Gjilan',
    departure: '13:30',
    arrival: '14:45',
    duration: '1 orë 15 min',
    price: 6.00,
    seatsTotal: 49,
    seatsTaken: 18,
    busType: 'Neoplan Tourliner',
    amenities: ['wifi', 'ac', 'power', 'wc'],
    company: 'RI TRAVEL',
    stops: ['Lipjan', 'Kamenicë'],
  },
  {
    id: 'trip-007',
    from: 'Prishtina',
    to: 'Pejë',
    departure: '14:00',
    arrival: '15:20',
    duration: '1 orë 20 min',
    price: 7.00,
    seatsTotal: 49,
    seatsTaken: 5,
    busType: 'Setra S 515 HD',
    amenities: ['wifi', 'ac', 'power', 'wc'],
    company: 'RI TRAVEL',
    stops: ['Fushë Kosovë', 'Klinë'],
  },
  {
    id: 'trip-008',
    from: 'Prishtina',
    to: 'Prizren',
    departure: '16:00',
    arrival: '17:30',
    duration: '1 orë 30 min',
    price: 8.00,
    seatsTotal: 49,
    seatsTaken: 33,
    busType: 'Mercedes Tourismo',
    amenities: ['wifi', 'ac', 'wc'],
    company: 'RI TRAVEL',
    stops: ['Suharekë'],
  },
];

const amenityIcons: Record<string, React.ReactNode> = {
  wifi: <Wifi size={13} />,
  ac: <AirVent size={13} />,
  power: <Zap size={13} />,
  wc: <Toilet size={13} />,
};
const amenityLabels: Record<string, string> = {
  wifi: 'Wi-Fi',
  ac: 'AC',
  power: 'Prizë',
  wc: 'WC',
};

function getSeatStatus(taken: number, total: number) {
  const free = total - taken;
  if (free === 0) return { label: 'Plot', cls: 'badge-full' };
  if (free <= 5) return { label: `${free} ulëse`, cls: 'badge-limited' };
  return { label: `${free} ulëse`, cls: 'badge-free' };
}

export default function ScheduleList() {
  const [expanded, setExpanded] = useState<string | null>(null);

  return (
    <div>
      <div className="flex items-center justify-between mb-4">
        <p className="text-sm font-medium" style={{ color: 'var(--muted-foreground)' }}>
          <span className="font-bold" style={{ color: 'var(--foreground)' }}>{schedules.length}</span> linja të gjetura
        </p>
      </div>

      <div className="flex flex-col gap-3">
        {schedules.map((trip) => {
          const freeSeats = trip.seatsTotal - trip.seatsTaken;
          const status = getSeatStatus(trip.seatsTaken, trip.seatsTotal);
          const isExpanded = expanded === trip.id;
          const isFull = freeSeats === 0;

          return (
            <div
              key={trip.id}
              className="rounded-2xl overflow-hidden transition-all duration-200"
              style={{ backgroundColor: 'var(--card)', border: `1px solid ${isExpanded ? 'var(--primary)' : 'var(--border)'}` }}
            >
              <div className="p-4 sm:p-5">
                <div className="flex flex-wrap items-center gap-4">
                  {/* Route info */}
                  <div className="flex items-center gap-3 flex-1 min-w-[200px]">
                    <div
                      className="w-10 h-10 rounded-xl flex items-center justify-center flex-shrink-0"
                      style={{ backgroundColor: 'rgba(245,166,35,0.1)' }}
                    >
                      <Bus size={18} style={{ color: 'var(--primary)' }} />
                    </div>
                    <div>
                      <div className="flex items-center gap-2 mb-0.5">
                        <span className="text-base font-extrabold" style={{ color: 'var(--foreground)' }}>{trip.from}</span>
                        <ArrowRight size={14} style={{ color: 'var(--primary)' }} />
                        <span className="text-base font-extrabold" style={{ color: 'var(--foreground)' }}>{trip.to}</span>
                      </div>
                      <p className="text-xs" style={{ color: 'var(--muted-foreground)' }}>{trip.busType}</p>
                    </div>
                  </div>

                  {/* Times */}
                  <div className="flex items-center gap-6">
                    <div className="text-center">
                      <p className="text-xl font-extrabold tabular-nums" style={{ color: 'var(--foreground)' }}>{trip.departure}</p>
                      <p className="text-xs" style={{ color: 'var(--muted-foreground)' }}>Nisja</p>
                    </div>
                    <div className="flex flex-col items-center gap-1">
                      <p className="text-xs tabular-nums" style={{ color: 'var(--muted-foreground)' }}>{trip.duration}</p>
                      <div className="flex items-center gap-1">
                        <div className="w-2 h-2 rounded-full" style={{ backgroundColor: 'var(--primary)' }} />
                        <div className="w-12 h-0.5" style={{ backgroundColor: 'var(--border)' }} />
                        <div className="w-2 h-2 rounded-full" style={{ backgroundColor: 'var(--muted-foreground)' }} />
                      </div>
                    </div>
                    <div className="text-center">
                      <p className="text-xl font-extrabold tabular-nums" style={{ color: 'var(--foreground)' }}>{trip.arrival}</p>
                      <p className="text-xs" style={{ color: 'var(--muted-foreground)' }}>Mbërritja</p>
                    </div>
                  </div>

                  {/* Amenities */}
                  <div className="hidden sm:flex items-center gap-2">
                    {trip.amenities.map((a) => (
                      <span
                        key={`${trip.id}-amenity-${a}`}
                        className="flex items-center gap-1 px-2 py-1 rounded-lg text-xs"
                        style={{ backgroundColor: 'var(--muted)', color: 'var(--muted-foreground)' }}
                        title={amenityLabels[a]}
                      >
                        {amenityIcons[a]}
                        <span className="hidden lg:inline">{amenityLabels[a]}</span>
                      </span>
                    ))}
                  </div>

                  {/* Seats */}
                  <span className={`badge ${status.cls} px-3 py-1.5 rounded-xl text-xs font-bold`}>
                    {status.label}
                  </span>

                  {/* Price + Action */}
                  <div className="flex items-center gap-3 ml-auto">
                    <div className="text-right">
                      <p className="text-xl font-extrabold tabular-nums" style={{ color: 'var(--primary)' }}>
                        €{trip.price.toFixed(2)}
                      </p>
                      <p className="text-xs" style={{ color: 'var(--muted-foreground)' }}>/ ulëse</p>
                    </div>
                    {isFull ? (
                      <span
                        className="px-4 py-2.5 rounded-xl text-sm font-bold opacity-50 cursor-not-allowed"
                        style={{ backgroundColor: 'var(--muted)', color: 'var(--muted-foreground)' }}
                      >
                        Plot
                      </span>
                    ) : (
                      <Link
                        href="/booking-page"
                        className="px-4 py-2.5 rounded-xl text-sm font-bold transition-all hover:brightness-110 active:scale-95"
                        style={{ backgroundColor: 'var(--primary)', color: 'var(--primary-foreground)' }}
                      >
                        Rezervo
                      </Link>
                    )}
                    <button
                      onClick={() => setExpanded(isExpanded ? null : trip.id)}
                      className="p-2 rounded-xl transition-colors hover:bg-white/10"
                      style={{ color: 'var(--muted-foreground)' }}
                      aria-label="Shfaq detajet"
                    >
                      {isExpanded ? <ChevronUp size={18} /> : <ChevronDown size={18} />}
                    </button>
                  </div>
                </div>
              </div>

              {/* Expanded details */}
              {isExpanded && (
                <div
                  className="px-5 pb-5 pt-0"
                  style={{ borderTop: '1px solid var(--border)' }}
                >
                  <div className="pt-4 grid grid-cols-1 sm:grid-cols-3 gap-4">
                    <div>
                      <p className="text-xs font-semibold mb-2" style={{ color: 'var(--muted-foreground)' }}>Kompania</p>
                      <p className="text-sm font-bold" style={{ color: 'var(--foreground)' }}>{trip.company}</p>
                    </div>
                    <div>
                      <p className="text-xs font-semibold mb-2" style={{ color: 'var(--muted-foreground)' }}>Ndalesa</p>
                      {trip.stops.length === 0 ? (
                        <p className="text-sm" style={{ color: 'var(--muted-foreground)' }}>Drejtpërdrejt</p>
                      ) : (
                        <div className="flex flex-wrap gap-1.5">
                          {trip.stops.map((stop) => (
                            <span
                              key={`${trip.id}-stop-${stop}`}
                              className="px-2 py-0.5 rounded-full text-xs"
                              style={{ backgroundColor: 'var(--muted)', color: 'var(--muted-foreground)' }}
                            >
                              {stop}
                            </span>
                          ))}
                        </div>
                      )}
                    </div>
                    <div>
                      <p className="text-xs font-semibold mb-2" style={{ color: 'var(--muted-foreground)' }}>Facilitetat</p>
                      <div className="flex flex-wrap gap-2">
                        {trip.amenities.map((a) => (
                          <span
                            key={`${trip.id}-fac-${a}`}
                            className="flex items-center gap-1 px-2 py-1 rounded-lg text-xs"
                            style={{ backgroundColor: 'var(--muted)', color: 'var(--muted-foreground)' }}
                          >
                            {amenityIcons[a]} {amenityLabels[a]}
                          </span>
                        ))}
                      </div>
                    </div>
                  </div>
                </div>
              )}
            </div>
          );
        })}
      </div>
    </div>
  );
}