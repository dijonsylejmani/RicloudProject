import React from 'react';
import AppImage from '@/components/ui/AppImage';
import { Calendar, Clock, ArrowRight, Bus, Wifi, AirVent, Zap, Toilet } from 'lucide-react';


export default function TripDetailsPanel() {
  return (
    <div
      className="rounded-2xl p-5"
      style={{ backgroundColor: 'var(--card)', border: '1px solid var(--border)' }}
    >
      <h3 className="text-sm font-bold mb-4" style={{ color: 'var(--foreground)' }}>Detajet e linjës</h3>
      {/* Route */}
      <div className="flex items-center gap-2 mb-4">
        <span className="text-lg font-extrabold" style={{ color: 'var(--foreground)' }}>Prishtinë</span>
        <ArrowRight size={16} style={{ color: 'var(--primary)' }} />
        <span className="text-lg font-extrabold" style={{ color: 'var(--foreground)' }}>Prizren</span>
      </div>
      {/* Meta */}
      <div className="flex flex-col gap-2 mb-4">
        <div className="flex items-center gap-2 text-sm" style={{ color: 'var(--muted-foreground)' }}>
          <Calendar size={14} style={{ color: 'var(--primary)' }} />
          25 Maj 2025
        </div>
        <div className="flex items-center gap-2 text-sm" style={{ color: 'var(--muted-foreground)' }}>
          <Clock size={14} style={{ color: 'var(--primary)' }} />
          08:00
        </div>
        <div className="flex items-center gap-2 text-sm" style={{ color: 'var(--muted-foreground)' }}>
          <Clock size={14} style={{ color: 'var(--primary)' }} />
          1 orë 30 min
        </div>
      </div>
      {/* City image */}
      <div className="rounded-xl overflow-hidden mb-4" style={{ height: '130px' }}>
        <AppImage
          src="/assets/images/RiTravel-1778014045288.png"
          alt="Scenic view of Prizren city with mosque and bridge in Kosovo"
          width={300}
          height={130}
          className="w-full h-full object-cover"
        />
      </div>
      {/* Bus info */}
      <div style={{ borderTop: '1px solid var(--border)', paddingTop: '1rem' }}>
        <p className="text-xs font-semibold mb-3" style={{ color: 'var(--muted-foreground)' }}>Informacion i autobusit</p>
        <div className="flex flex-col gap-2">
          <div>
            <p className="text-xs" style={{ color: 'var(--muted-foreground)' }}>Kompania</p>
            <p className="text-sm font-bold" style={{ color: 'var(--foreground)' }}>RI TRAVEL</p>
          </div>
          <div>
            <p className="text-xs" style={{ color: 'var(--muted-foreground)' }}>Lloji i autobusit</p>
            <p className="text-sm font-bold" style={{ color: 'var(--foreground)' }}>Setra S 515 HD</p>
          </div>
          <div>
            <p className="text-xs" style={{ color: 'var(--muted-foreground)' }}>Kapaciteti</p>
            <p className="text-sm font-bold" style={{ color: 'var(--foreground)' }}>49 ulëse</p>
          </div>
          <div>
            <p className="text-xs mb-2" style={{ color: 'var(--muted-foreground)' }}>Facilitetat</p>
            <div className="flex items-center gap-2 flex-wrap">
              {[
                { icon: Wifi, label: 'Wi-Fi' },
                { icon: AirVent, label: 'AC' },
                { icon: Zap, label: 'Prizë' },
                { icon: Toilet, label: 'WC' },
              ]?.map(({ icon: FacilityIcon, label }: { icon: React.ElementType; label: string }) => (
                <span
                  key={`facility-${label}`}
                  className="flex items-center gap-1 px-2 py-1 rounded-lg text-xs"
                  style={{ backgroundColor: 'var(--muted)', color: 'var(--muted-foreground)' }}
                  title={label}
                >
                  {React.createElement(FacilityIcon, { size: 12 })} {label}
                </span>
              ))}
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}