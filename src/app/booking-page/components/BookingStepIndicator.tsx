import React from 'react';
import { Check } from 'lucide-react';

const steps = [
  { key: 'step-ind-1', number: 1, label: 'Zgjedhja e linjës' },
  { key: 'step-ind-2', number: 2, label: 'Zgjedhja e ulëses' },
  { key: 'step-ind-3', number: 3, label: 'Të dhënat e udhëtarit' },
  { key: 'step-ind-4', number: 4, label: 'Pagesa' },
  { key: 'step-ind-5', number: 5, label: 'Konfirmimi' },
];

export default function BookingStepIndicator({ currentStep }: { currentStep: number }) {
  return (
    <div className="flex items-center gap-0 overflow-x-auto pb-2">
      {steps.map((step, idx) => {
        const isDone = step.number < currentStep;
        const isActive = step.number === currentStep;
        return (
          <React.Fragment key={step.key}>
            <div className="flex items-center gap-2 flex-shrink-0">
              <div
                className="w-8 h-8 rounded-full flex items-center justify-center text-sm font-bold transition-all"
                style={{
                  backgroundColor: isDone
                    ? 'var(--primary)'
                    : isActive
                    ? 'var(--primary)'
                    : 'var(--muted)',
                  color: isDone || isActive ? 'var(--primary-foreground)' : 'var(--muted-foreground)',
                }}
              >
                {isDone ? <Check size={14} /> : step.number}
              </div>
              <span
                className="text-xs font-semibold hidden sm:block"
                style={{
                  color: isActive ? 'var(--foreground)' : isDone ? 'var(--primary)' : 'var(--muted-foreground)',
                }}
              >
                {step.label}
              </span>
            </div>
            {idx < steps.length - 1 && (
              <div
                className="flex-1 h-0.5 mx-3 min-w-[20px]"
                style={{ backgroundColor: isDone ? 'var(--primary)' : 'var(--border)' }}
              />
            )}
          </React.Fragment>
        );
      })}
    </div>
  );
}