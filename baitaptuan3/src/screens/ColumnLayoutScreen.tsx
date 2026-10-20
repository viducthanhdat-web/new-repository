import { useNavigate } from 'react-router-dom';
import { ChevronLeft } from 'lucide-react';

export default function ColumnLayoutScreen() {
  const navigate = useNavigate();

  return (
    <div className="h-full flex flex-col bg-white">
      <header className="h-14 flex items-center justify-center px-4 relative border-b border-slate-100">
        <button 
          onClick={() => navigate('/list')}
          className="absolute left-2 w-10 h-10 flex items-center justify-center text-blue-500"
        >
          <ChevronLeft size={24} />
        </button>
        <h1 className="text-lg font-bold text-blue-500">Column Layout</h1>
      </header>

      <div className="flex-1 p-8 flex flex-col gap-6">
        <div className="h-32 w-full bg-green-200 rounded-2xl" />
        <div className="h-32 w-full bg-green-500 rounded-2xl shadow-lg" />
        <div className="h-32 w-full bg-green-300 rounded-2xl" />
      </div>
    </div>
  );
}
