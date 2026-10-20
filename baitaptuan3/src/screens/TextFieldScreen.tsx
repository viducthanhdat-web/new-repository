import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { ChevronLeft } from 'lucide-react';

export default function TextFieldScreen() {
  const navigate = useNavigate();
  const [value, setValue] = useState('');

  return (
    <div className="h-full flex flex-col bg-white">
      <header className="h-14 flex items-center justify-center px-4 relative border-b border-slate-100">
        <button 
          onClick={() => navigate('/list')}
          className="absolute left-2 w-10 h-10 flex items-center justify-center text-blue-500"
        >
          <ChevronLeft size={24} />
        </button>
        <h1 className="text-lg font-bold text-blue-500">TextField</h1>
      </header>

      <div className="flex-1 flex flex-col p-8 gap-8">
        <div className="w-full space-y-6">
          <div className="space-y-2">
            <p className="text-xs font-bold text-slate-400 ml-1">Normal Text Field</p>
            <input
              type="text"
              value={value}
              onChange={(e) => setValue(e.target.value)}
              placeholder="Thông tin nhập"
              className="w-full h-14 px-4 border border-slate-300 rounded-xl outline-none focus:border-blue-500 transition-colors text-slate-700"
            />
          </div>



          <p className="text-xs text-red-500 text-center italic">
            Tự động cập nhật dữ liệu theo textfield: {value || '...'}
          </p>
        </div>
      </div>
    </div>
  );
}
