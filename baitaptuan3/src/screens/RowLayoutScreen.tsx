import { useNavigate } from 'react-router-dom';
import { ChevronLeft } from 'lucide-react';

export default function RowLayoutScreen() {
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
        <h1 className="text-lg font-bold text-blue-500">Row Layout</h1>
      </header>

      <div className="flex-1 p-8 flex flex-col gap-4">
        {[1, 2, 3, 4].map((row) => (
          <div key={row} className="flex gap-4">
            <div className="flex-1 aspect-square bg-blue-100 rounded-lg" />
            <div className="flex-1 aspect-square bg-blue-500 rounded-lg shadow-md" />
            <div className="flex-1 aspect-square bg-blue-200 rounded-lg" />
          </div>
        ))}
      </div>
    </div>
  );
}
