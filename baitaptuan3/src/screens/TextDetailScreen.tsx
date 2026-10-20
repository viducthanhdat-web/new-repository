import { useNavigate } from 'react-router-dom';
import { ChevronLeft } from 'lucide-react';

export default function TextDetailScreen() {
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
        <h1 className="text-lg font-bold text-blue-500">Text Detail</h1>
      </header>

      <div className="flex-1 flex items-center justify-center p-8">
        <div className="text-center space-y-2">
          <p className="text-4xl leading-tight">
            The <span className="font-light italic">quick</span>{' '}
            <span className="text-orange-600 font-bold">Brown</span>
          </p>
          <p className="text-4xl leading-tight">
            fox <span className="font-mono text-3xl">jumps</span>{' '}
            <span className="font-black italic underline">over</span>
          </p>
          <p className="text-4xl leading-tight">
            <span className="border-b-2 border-slate-900">the</span>{' '}
            <span className="font-serif italic text-2xl">lazy</span>{' '}
            <span className="font-bold">dog.</span>
          </p>
        </div>
      </div>
    </div>
  );
}
