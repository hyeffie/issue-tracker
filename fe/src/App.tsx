import React from 'react';
import './App.css';
import Header from './Header/Header';
import FilterBar from './FilterBar/FilterBar';

function App() {
  return (
    <div className="App h-screen px-10 py-6">
      <Header url="https://images.unsplash.com/photo-1600354587397-681c16c184bf?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1180&q=80" />
      <FilterBar />
    </div>
  );
}

export default App;
