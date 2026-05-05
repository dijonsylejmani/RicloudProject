'use client';
import React, { useState } from 'react';
import { useForm } from 'react-hook-form';
import { User, Mail, CreditCard, Banknote, ChevronDown, ArrowRight } from 'lucide-react';

interface PassengerForm {
  firstName: string;
  lastName: string;
  email: string;
  phone: string;
}

interface BookingSummaryPanelProps {
  selectedSeat: number | null;
}

export default function BookingSummaryPanel({ selectedSeat }: BookingSummaryPanelProps) {
  const [paymentMethod, setPaymentMethod] = useState<'card' | 'cash'>('card');
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [submitted, setSubmitted] = useState(false);

  const { register, handleSubmit, formState: { errors } } = useForm<PassengerForm>();

  const pricePerSeat = 6.00;
  const total = selectedSeat ? pricePerSeat : 0;

  // Backend integration point: POST /api/bookings with passenger + seat + payment data
  const onSubmit = async (data: PassengerForm) => {
    setIsSubmitting(true);
    await new Promise((r) => setTimeout(r, 1500));
    setIsSubmitting(false);
    setSubmitted(true);
  };

  if (submitted) {
    return (
      <div
        className="rounded-2xl p-6 text-center"
        style={{ backgroundColor: 'var(--card)', border: '1px solid var(--border)' }}
      >
        <div
          className="w-16 h-16 rounded-full flex items-center justify-center mx-auto mb-4"
          style={{ backgroundColor: 'rgba(34,197,94,0.15)' }}
        >
          <span className="text-3xl">✓</span>
        </div>
        <h3 className="text-lg font-extrabold mb-2" style={{ color: '#22c55e' }}>Rezervimi u konfirmua!</h3>
        <p className="text-sm mb-4" style={{ color: 'var(--muted-foreground)' }}>
          Bileta juaj elektronike u dërgua në email. Udhëtim të mbarë!
        </p>
        <div
          className="rounded-xl p-4 text-left"
          style={{ backgroundColor: 'var(--muted)', border: '1px solid var(--border)' }}
        >
          <p className="text-xs font-semibold mb-1" style={{ color: 'var(--muted-foreground)' }}>Kodi i rezervimit</p>
          <p className="text-xl font-extrabold tabular-nums" style={{ color: 'var(--primary)' }}>RT-2025-{String(selectedSeat).padStart(4, '0')}</p>
        </div>
      </div>
    );
  }

  return (
    <div
      className="rounded-2xl p-5"
      style={{ backgroundColor: 'var(--card)', border: '1px solid var(--border)' }}
    >
      {/* Summary */}
      <h3 className="text-sm font-bold mb-4" style={{ color: 'var(--foreground)' }}>Përmbledhja e rezervimit</h3>
      <div className="flex flex-col gap-2.5 mb-5">
        {[
          { label: 'Linja', value: 'Prishtinë → Prizren' },
          { label: 'Data', value: '25 Maj 2025' },
          { label: 'Ora e nisjes', value: '08:00' },
        ].map(({ label, value }) => (
          <div key={`summary-${label}`} className="flex items-center justify-between">
            <span className="text-xs" style={{ color: 'var(--muted-foreground)' }}>{label}</span>
            <span className="text-xs font-semibold" style={{ color: 'var(--foreground)' }}>{value}</span>
          </div>
        ))}
        <div className="flex items-center justify-between">
          <span className="text-xs" style={{ color: 'var(--muted-foreground)' }}>Ulëse të zgjedhura</span>
          {selectedSeat ? (
            <span
              className="text-xs font-extrabold px-2 py-0.5 rounded-full"
              style={{ backgroundColor: 'var(--primary)', color: 'var(--primary-foreground)' }}
            >
              {selectedSeat}
            </span>
          ) : (
            <span className="text-xs" style={{ color: 'var(--muted-foreground)' }}>—</span>
          )}
        </div>
        <div className="flex items-center justify-between">
          <span className="text-xs" style={{ color: 'var(--muted-foreground)' }}>Çmimi për ulëse</span>
          <span className="text-xs font-semibold tabular-nums" style={{ color: 'var(--foreground)' }}>€{pricePerSeat.toFixed(2)}</span>
        </div>
        <div
          className="flex items-center justify-between pt-2"
          style={{ borderTop: '1px solid var(--border)' }}
        >
          <span className="text-sm font-bold" style={{ color: 'var(--foreground)' }}>Totali</span>
          <span className="text-lg font-extrabold tabular-nums" style={{ color: 'var(--primary)' }}>
            €{total.toFixed(2)}
          </span>
        </div>
      </div>

      {/* Passenger form */}
      <div style={{ borderTop: '1px solid var(--border)', paddingTop: '1rem' }}>
        <h4 className="text-sm font-bold mb-4" style={{ color: 'var(--foreground)' }}>Të dhënat e udhëtarit</h4>
        <form onSubmit={handleSubmit(onSubmit)} noValidate>
          <div className="grid grid-cols-2 gap-3 mb-3">
            <div>
              <label className="block text-xs font-medium mb-1" style={{ color: 'var(--muted-foreground)' }}>Emri</label>
              <div className="relative">
                <input
                  {...register('firstName', { required: 'Emri kërkohet' })}
                  className="search-input pr-9 text-xs"
                  placeholder="Emri juaj"
                />
                <User size={13} className="absolute right-3 top-1/2 -translate-y-1/2" style={{ color: 'var(--muted-foreground)' }} />
              </div>
              {errors.firstName && (
                <p className="text-xs mt-1" style={{ color: 'var(--danger, #ef4444)' }}>{errors.firstName.message}</p>
              )}
            </div>
            <div>
              <label className="block text-xs font-medium mb-1" style={{ color: 'var(--muted-foreground)' }}>Mbiemri</label>
              <div className="relative">
                <input
                  {...register('lastName', { required: 'Mbiemri kërkohet' })}
                  className="search-input pr-9 text-xs"
                  placeholder="Mbiemri juaj"
                />
                <User size={13} className="absolute right-3 top-1/2 -translate-y-1/2" style={{ color: 'var(--muted-foreground)' }} />
              </div>
              {errors.lastName && (
                <p className="text-xs mt-1" style={{ color: '#ef4444' }}>{errors.lastName.message}</p>
              )}
            </div>
          </div>

          <div className="mb-3">
            <label className="block text-xs font-medium mb-1" style={{ color: 'var(--muted-foreground)' }}>Email</label>
            <div className="relative">
              <input
                type="email"
                {...register('email', {
                  required: 'Email kërkohet',
                  pattern: { value: /^\S+@\S+\.\S+$/, message: 'Email i pavlefshëm' },
                })}
                className="search-input pr-9 text-xs"
                placeholder="email@shembull.com"
              />
              <Mail size={13} className="absolute right-3 top-1/2 -translate-y-1/2" style={{ color: 'var(--muted-foreground)' }} />
            </div>
            {errors.email && (
              <p className="text-xs mt-1" style={{ color: '#ef4444' }}>{errors.email.message}</p>
            )}
          </div>

          <div className="mb-5">
            <label className="block text-xs font-medium mb-1" style={{ color: 'var(--muted-foreground)' }}>Numri i telefonit</label>
            <div className="flex gap-2">
              <div
                className="flex items-center gap-1 px-3 py-2 rounded-lg text-xs font-medium flex-shrink-0"
                style={{ backgroundColor: 'rgba(255,255,255,0.08)', border: '1px solid rgba(255,255,255,0.15)', color: 'var(--foreground)' }}
              >
                🇽🇰 +383 <ChevronDown size={12} />
              </div>
              <div className="flex-1 relative">
                <input
                  {...register('phone', { required: 'Telefoni kërkohet' })}
                  className="search-input text-xs"
                  placeholder="44 123 456"
                />
              </div>
            </div>
            {errors.phone && (
              <p className="text-xs mt-1" style={{ color: '#ef4444' }}>{errors.phone.message}</p>
            )}
          </div>

          {/* Payment method */}
          <div style={{ borderTop: '1px solid var(--border)', paddingTop: '1rem', marginBottom: '1rem' }}>
            <h4 className="text-sm font-bold mb-3" style={{ color: 'var(--foreground)' }}>Zgjedh mënyrën e pagesës</h4>
            <div className="grid grid-cols-2 gap-2">
              <button
                type="button"
                onClick={() => setPaymentMethod('card')}
                className="flex flex-col items-start gap-1 p-3 rounded-xl text-left transition-all"
                style={{
                  backgroundColor: paymentMethod === 'card' ? 'rgba(245,166,35,0.1)' : 'var(--muted)',
                  border: `2px solid ${paymentMethod === 'card' ? 'var(--primary)' : 'transparent'}`,
                }}
              >
                <CreditCard size={16} style={{ color: paymentMethod === 'card' ? 'var(--primary)' : 'var(--muted-foreground)' }} />
                <span className="text-xs font-bold" style={{ color: 'var(--foreground)' }}>Kartë online</span>
                <span className="text-xs" style={{ color: 'var(--muted-foreground)' }}>Paguaj online me kartë</span>
              </button>
              <button
                type="button"
                onClick={() => setPaymentMethod('cash')}
                className="flex flex-col items-start gap-1 p-3 rounded-xl text-left transition-all"
                style={{
                  backgroundColor: paymentMethod === 'cash' ? 'rgba(245,166,35,0.1)' : 'var(--muted)',
                  border: `2px solid ${paymentMethod === 'cash' ? 'var(--primary)' : 'transparent'}`,
                }}
              >
                <Banknote size={16} style={{ color: paymentMethod === 'cash' ? 'var(--primary)' : 'var(--muted-foreground)' }} />
                <span className="text-xs font-bold" style={{ color: 'var(--foreground)' }}>Cash në ndalesë</span>
                <span className="text-xs" style={{ color: 'var(--muted-foreground)' }}>Paguaj para në dorë</span>
              </button>
            </div>
          </div>

          <button
            type="submit"
            disabled={isSubmitting || !selectedSeat}
            className="w-full flex items-center justify-center gap-2 py-3.5 rounded-xl text-sm font-extrabold transition-all hover:brightness-110 active:scale-95 disabled:opacity-60 disabled:cursor-not-allowed"
            style={{ backgroundColor: 'var(--primary)', color: 'var(--primary-foreground)' }}
          >
            {isSubmitting ? (
              <>
                <span className="w-4 h-4 border-2 border-current border-t-transparent rounded-full animate-spin" />
                Duke procesuar...
              </>
            ) : (
              <>
                Vazhdo për pagesë
                <ArrowRight size={16} />
              </>
            )}
          </button>

          {!selectedSeat && (
            <p className="text-xs text-center mt-2" style={{ color: 'var(--muted-foreground)' }}>
              Zgjidhni ulësen para se të vazhdoni
            </p>
          )}
        </form>
      </div>
    </div>
  );
}