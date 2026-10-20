import { useNavigate } from 'react-router-dom';
import { ChevronLeft } from 'lucide-react';

export default function ImagesScreen() {
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
        <h1 className="text-lg font-bold text-blue-500">Images</h1>
      </header>

      <div className="flex-1 p-6 space-y-8 overflow-y-auto">
        <div className="space-y-2">
          <div className="aspect-[4/3] w-full bg-slate-100 rounded-2xl overflow-hidden flex items-center justify-center">
            {/* Placeholder for the university building */}
            <div className="w-full h-full bg-gradient-to-br from-slate-200 to-slate-300 flex flex-col items-center justify-center p-4">
               <div className="w-24 h-16 bg-white/50 rounded-lg mb-2" />
               <p className="text-[10px] text-slate-400 text-center uppercase tracking-widest font-bold">University Image</p>
            </div>
          </div>
          <p className="text-[10px] text-blue-500 break-all underline leading-tight text-center">
            https://phongthongvantaithcm.edu.vn/wp-content/uploads/2023/01/Logo-UT-T.png
          </p>
        </div>

        <div className="space-y-4">
          <div className="aspect-[4/3] w-full bg-slate-100 rounded-2xl overflow-hidden flex items-center justify-center">
             {/* Placeholder for the modern building */}
             <div className="w-full h-full bg-gradient-to-tr from-slate-300 to-slate-400 flex flex-col items-center justify-center">
               <div className="w-16 h-24 bg-white/30 rounded-lg" />
               <p className="text-[10px] text-slate-500 mt-2 font-bold uppercase tracking-widest">In App Asset</p>
             </div>
          </div>
          <p className="text-xs text-slate-400 text-center">In app</p>
        </div>
      </div>
    </div>
  );
}
