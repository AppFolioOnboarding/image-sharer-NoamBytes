import React from 'react';
import Header from './Header';
import FeedbackForm from './FeedbackForm';
import Footer from './Footer';

export default function App() {
  return (
    <div className='d-flex flex-column align-items-center'>
      <Header title="Tell us what you think" />
      <FeedbackForm />
      <Footer text='Copyright: Appfolio Inc. Onboarding' />
    </div>
  );
}
