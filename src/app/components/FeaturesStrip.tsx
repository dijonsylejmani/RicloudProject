import React from 'react';
import { Armchair, CreditCard, Bell, ShieldCheck } from 'lucide-react';
import Icon from '@/components/ui/AppIcon';



const features = [
  {
    key: 'feat-seat',
    icon: Armchair,
    title: 'Zgjidh ulaen tënde',
    desc: 'Zgjidhni vendin e preferuar në hartën e autobusit në mënyrë të lehtë.',
  },
  {
    key: 'feat-pay',
    icon: CreditCard,
    title: 'Pagesë fleksibile',
    desc: 'Paguaj online me kartë ose cash në ndalesë.',
  },
  {
    key: 'feat-notif',
    icon: Bell,
    title: 'Njoftime në kohë reale',
    desc: 'Merr njoftimet për udhëtimin tënd dhe pozicionin e autobusit.',
  },
  {
    key: 'feat-safe',
    icon: ShieldCheck,
    title: 'Udhëtim i sigurt',
    desc: 'Autobusë modernë, shoferë profesionalë dhe udhëtim i sigurt.',
  },
];

export default function FeaturesStrip() {
  return (
    <div style={{ backgroundColor: 'var(--secondary)', borderTop: '1px solid var(--border)' }}>
      <div className="max-w-screen-2xl mx-auto px-4 lg:px-8 xl:px-10 2xl:px-16 py-10">
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-8">
          {features?.map(({ key, icon: Icon, title, desc }) => (
            <div key={key} className="flex items-start gap-4">
              <div
                className="w-11 h-11 rounded-xl flex items-center justify-center flex-shrink-0"
                style={{ backgroundColor: 'rgba(245,166,35,0.12)', border: '1px solid rgba(245,166,35,0.25)' }}
              >
                <Icon size={20} style={{ color: 'var(--primary)' }} />
              </div>
              <div>
                <p className="text-sm font-bold mb-1" style={{ color: 'var(--foreground)' }}>{title}</p>
                <p className="text-xs leading-relaxed" style={{ color: 'var(--muted-foreground)' }}>{desc}</p>
              </div>
            </div>
          ))}
        </div>
      </div>
    </div>
  );
}