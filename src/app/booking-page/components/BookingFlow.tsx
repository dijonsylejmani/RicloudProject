'use client';
import React, { useState } from 'react';
import BookingStepIndicator from './BookingStepIndicator';
import TripDetailsPanel from './TripDetailsPanel';
import SeatMapPanel from './SeatMapPanel';
import BookingSummaryPanel from './BookingSummaryPanel';

export type SelectedSeat = number | null;

export default function BookingFlow() {
  const [currentStep, setCurrentStep] = useState(2);
  const [selectedSeat, setSelectedSeat] = useState<number | null>(14);

  return (
    <div>
      <BookingStepIndicator currentStep={currentStep} />
      <div className="grid grid-cols-1 lg:grid-cols-12 gap-6 mt-8">
        {/* Left: Trip details */}
        <div className="lg:col-span-3">
          <TripDetailsPanel />
        </div>

        {/* Center: Seat map */}
        <div className="lg:col-span-5">
          <SeatMapPanel selectedSeat={selectedSeat} onSelectSeat={setSelectedSeat} />
        </div>

        {/* Right: Summary + form */}
        <div className="lg:col-span-4">
          <BookingSummaryPanel selectedSeat={selectedSeat} />
        </div>
      </div>
    </div>
  );
}