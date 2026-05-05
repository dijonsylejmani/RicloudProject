import React from 'react';
import Navbar from '@/components/Navbar';
import Footer from '@/components/Footer';
import SchedulesHero from './components/SchedulesHero';
import ScheduleFilters from './components/ScheduleFilters';
import ScheduleList from './components/ScheduleList';

export default function BusSchedulesPage() {
  return (
    <main style={{ backgroundColor: 'var(--background)' }}>
      <Navbar />
      <SchedulesHero />
      <div className="max-w-screen-2xl mx-auto px-4 lg:px-8 xl:px-10 2xl:px-16 py-8">
        <ScheduleFilters />
        <ScheduleList />
      </div>
      <Footer />
    </main>
  );
}