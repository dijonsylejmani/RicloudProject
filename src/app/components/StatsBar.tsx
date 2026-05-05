import React from 'react';
import { Bus, Route, Users, ShieldCheck } from 'lucide-react';
import Icon from '@/components/ui/AppIcon';



const stats = [
  { icon: Bus, value: '120+', label: 'Autobusë modernë', key: 'stat-buses' },
  { icon: Route, value: '250+', label: 'Linja të disponueshme', key: 'stat-routes' },
  { icon: Users, value: '50K+', label: 'Udhëtarë të kënaqur', key: 'stat-travelers' },
  { icon: ShieldCheck, value: '100%', label: 'Udhëtim i sigurt', key: 'stat-safety' },
];

export default function StatsBar() {
  return (
    <div style={{ backgroundColor: 'var(--card)', borderBottom: '1px solid var(--border)' }}>
      <div className="max-w-screen-2xl mx-auto px-4 lg:px-8 xl:px-10 2xl:px-16 py-6">
        <div className="grid grid-cols-2 lg:grid-cols-4 gap-6">
          {stats?.map(({ icon: Icon, value, label, key }) => (
            <div key={key} className="flex items-center gap-4">
              <div
                className="w-12 h-12 rounded-xl flex items-center justify-center flex-shrink-0"
                style={{ backgroundColor: 'rgba(245,166,35,0.12)' }}
              >
                <Icon size={22} style={{ color: 'var(--primary)' }} />
              </div>
              <div>
                <p className="text-2xl font-extrabold tabular-nums" style={{ color: 'var(--foreground)' }}>{value}</p>
                <p className="text-xs font-medium" style={{ color: 'var(--muted-foreground)' }}>{label}</p>
              </div>
            </div>
          ))}
        </div>
      </div>
    </div>
  );
}