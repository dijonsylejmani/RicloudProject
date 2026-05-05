import React from 'react';
import Link from 'next/link';
import AppLogo from '@/components/ui/AppLogo';
import { Phone, Mail, MapPin, Share2, Camera, Play, Users } from 'lucide-react';
import Icon from '@/components/ui/AppIcon';





export default function Footer() {
  return (
    <footer style={{ backgroundColor: 'var(--secondary)', borderTop: '1px solid var(--border)' }}>
      <div className="max-w-screen-2xl mx-auto px-4 lg:px-8 xl:px-10 2xl:px-16 py-14">
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-5 gap-10">
          {/* Brand */}
          <div className="lg:col-span-1">
            <div className="flex items-center gap-2 mb-4">
              <AppLogo src="/assets/images/RiTravel-1778014045288.png" size={36} />
              <span className="font-extrabold text-lg" style={{ color: 'var(--foreground)' }}>
                Ri<span style={{ color: 'var(--primary)' }}>Travel</span>
              </span>
            </div>
            <p className="text-sm leading-relaxed mb-5" style={{ color: 'var(--muted-foreground)' }}>
              RI TRAVEL është kompania juaj e besueshme për udhëtime të sigurta, komode dhe të paharrueshme në gjithë Kosovën.
            </p>
            <div className="flex items-center gap-3">
              {[
                { icon: Share2, label: 'Facebook' },
                { icon: Camera, label: 'Instagram' },
                { icon: Play, label: 'YouTube' },
                { icon: Users, label: 'LinkedIn' },
              ]?.map(({ icon: Icon, label }) => (
                <button
                  key={`social-${label}`}
                  className="w-8 h-8 rounded-lg flex items-center justify-center transition-all hover:bg-primary hover:text-primary-foreground"
                  style={{ backgroundColor: 'var(--muted)', color: 'var(--muted-foreground)' }}
                  aria-label={label}
                >
                  <Icon size={15} />
                </button>
              ))}
            </div>
          </div>

          {/* Linqe të shpejta */}
          <div>
            <h4 className="text-sm font-semibold mb-4" style={{ color: 'var(--foreground)' }}>Linqe të shpejta</h4>
            <ul className="flex flex-col gap-2.5">
              {['Ballina', 'Linjat', 'Rezervo', 'Ndiq Live', 'Rreth Nesh', 'Kontakt']?.map((item) => (
                <li key={`footer-link-${item}`}>
                  <Link href="#" className="text-sm transition-colors hover:text-primary" style={{ color: 'var(--muted-foreground)' }}>
                    {item}
                  </Link>
                </li>
              ))}
            </ul>
          </div>

          {/* Shërbimet tona */}
          <div>
            <h4 className="text-sm font-semibold mb-4" style={{ color: 'var(--foreground)' }}>Shërbimet tona</h4>
            <ul className="flex flex-col gap-2.5">
              {['Rezervim online', 'Ndiq autobusin live', 'Pagese të sigurta', 'Mbështetje 24/7', 'Udhëtime të sigurta']?.map((item) => (
                <li key={`footer-service-${item}`}>
                  <Link href="#" className="text-sm transition-colors hover:text-primary" style={{ color: 'var(--muted-foreground)' }}>
                    {item}
                  </Link>
                </li>
              ))}
            </ul>
          </div>

          {/* Mbështetje */}
          <div>
            <h4 className="text-sm font-semibold mb-4" style={{ color: 'var(--foreground)' }}>Mbështetje</h4>
            <ul className="flex flex-col gap-2.5">
              {['Pyetje të shpeshta', 'Kushtet e përdorimit', 'Politika e privatësisë', 'Rimbursimet']?.map((item) => (
                <li key={`footer-support-${item}`}>
                  <Link href="#" className="text-sm transition-colors hover:text-primary" style={{ color: 'var(--muted-foreground)' }}>
                    {item}
                  </Link>
                </li>
              ))}
            </ul>
          </div>

          {/* Na kontaktoni */}
          <div>
            <h4 className="text-sm font-semibold mb-4" style={{ color: 'var(--foreground)' }}>Na kontaktoni</h4>
            <ul className="flex flex-col gap-3">
              <li className="flex items-start gap-2.5">
                <Phone size={15} className="mt-0.5 flex-shrink-0" style={{ color: 'var(--primary)' }} />
                <span className="text-sm" style={{ color: 'var(--muted-foreground)' }}>+383 44 123 456</span>
              </li>
              <li className="flex items-start gap-2.5">
                <Mail size={15} className="mt-0.5 flex-shrink-0" style={{ color: 'var(--primary)' }} />
                <span className="text-sm" style={{ color: 'var(--muted-foreground)' }}>info@ritravel-ks.com</span>
              </li>
              <li className="flex items-start gap-2.5">
                <MapPin size={15} className="mt-0.5 flex-shrink-0" style={{ color: 'var(--primary)' }} />
                <span className="text-sm" style={{ color: 'var(--muted-foreground)' }}>Rr. Nëna Terezë, Nr. 45<br />10000 Prishtinë, Kosovë</span>
              </li>
            </ul>
          </div>
        </div>
      </div>
      {/* Bottom bar */}
      <div style={{ borderTop: '1px solid var(--border)' }}>
        <div className="max-w-screen-2xl mx-auto px-4 lg:px-8 xl:px-10 2xl:px-16 py-4 flex flex-col sm:flex-row items-center justify-between gap-2">
          <p className="text-xs" style={{ color: 'var(--muted-foreground)' }}>
            © 2025 RI TRAVEL. Të gjitha të drejtat e rezervuara.
          </p>
          <p className="text-xs flex items-center gap-1" style={{ color: 'var(--muted-foreground)' }}>
            Krijuar me <span style={{ color: '#ef4444' }}>♥</span> për udhëtimet tuaja të sigurta.
          </p>
        </div>
      </div>
    </footer>
  );
}