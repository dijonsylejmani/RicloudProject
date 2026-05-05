import React from 'react';
import { Search, Armchair, CreditCard } from 'lucide-react';
import Icon from '@/components/ui/AppIcon';


const steps = [
  {
    key: 'step-1',
    number: 1,
    icon: Search,
    title: 'Kërko linjën',
    desc: 'Zgjidhni qytetin e nisjes, destinacionin dhe datën e udhëtimit.',
  },
  {
    key: 'step-2',
    number: 2,
    icon: Armchair,
    title: 'Zgjidhni ulësen tënde',
    desc: 'Zgjidhni ulësen tënde të preferuar në hartën e autobusit.',
  },
  {
    key: 'step-3',
    number: 3,
    icon: CreditCard,
    title: 'Paguaj dhe udhëto',
    desc: 'Paguaj online ose në ndalesë dhe merr biletën tënde elektronike.',
  },
];

export default function HowItWorks() {
  return (
    <div>
      <h2 className="text-base font-bold mb-4" style={{ color: 'var(--foreground)' }}>Si funksionon?</h2>
      <div className="flex flex-col gap-4">
        {steps?.map(({ key, number, icon: Icon, title, desc }) => (
          <div key={key} className="flex items-start gap-4">
            <div className="relative flex-shrink-0">
              <div
                className="w-11 h-11 rounded-full flex items-center justify-center"
                style={{ backgroundColor: 'rgba(245,166,35,0.12)', border: '2px solid rgba(245,166,35,0.3)' }}
              >
                <Icon size={18} style={{ color: 'var(--primary)' }} />
              </div>
              <span
                className="absolute -top-1 -right-1 w-5 h-5 rounded-full flex items-center justify-center text-xs font-extrabold"
                style={{ backgroundColor: 'var(--primary)', color: 'var(--primary-foreground)' }}
              >
                {number}
              </span>
            </div>
            <div>
              <p className="text-sm font-bold mb-1" style={{ color: 'var(--foreground)' }}>{title}</p>
              <p className="text-xs leading-relaxed" style={{ color: 'var(--muted-foreground)' }}>{desc}</p>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}