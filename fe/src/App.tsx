import React from 'react';

import Header from './components/Header/Header';
import FilterBar from './components/FilterBar/FilterBar';
import NavLinks from './components/NavLinks/NavLinks';
import Issue from './components/IssueList/Issue';

function App() {
  return (
    <div className="App h-screen px-10 py-6">
      <Header url="https://images.unsplash.com/photo-1600354587397-681c16c184bf?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1180&q=80" />
      <FilterBar />
      <NavLinks countAllLabels={3} countAllMilestones={2} />
    </div>
  );
}

export default App;
