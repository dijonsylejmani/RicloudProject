import React from 'react';
import Navbar from '@/components/Navbar';
import Footer from '@/components/Footer';
import BookingHero from './components/BookingHero';
import BookingFlow from './components/BookingFlow';

export default function BookingPage() {
  return (
    <main style={{ backgroundColor: 'var(--background)' }}>
      <Navbar />
      <BookingHero />
      <div className="max-w-screen-2xl mx-auto px-4 lg:px-8 xl:px-10 2xl:px-16 py-8">
        <BookingFlow />
      </div>
      <Footer />
    </main>
  );
}