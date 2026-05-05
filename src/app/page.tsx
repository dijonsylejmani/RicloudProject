import React from 'react';
import Navbar from '@/components/Navbar';
import Footer from '@/components/Footer';
import HeroSection from './components/HeroSection';
import StatsBar from './components/StatsBar';
import PopularRoutes from './components/PopularRoutes';
import HowItWorks from './components/HowItWorks';
import LiveTrackTeaser from './components/LiveTrackTeaser';
import FeaturesStrip from './components/FeaturesStrip';

export default function HomePage() {
  return (
    <main style={{ backgroundColor: 'var(--background)' }}>
      <Navbar />
      <HeroSection />
      <StatsBar />
      <div className="max-w-screen-2xl mx-auto px-4 lg:px-8 xl:px-10 2xl:px-16 py-12">
        <div className="grid grid-cols-1 lg:grid-cols-3 gap-8">
          <div className="lg:col-span-1">
            <PopularRoutes />
          </div>
          <div className="lg:col-span-1">
            <HowItWorks />
          </div>
          <div className="lg:col-span-1">
            <LiveTrackTeaser />
          </div>
        </div>
      </div>
      <FeaturesStrip />
      <Footer />
    </main>
  );
}