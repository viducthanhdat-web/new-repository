import { useNavigate } from 'react-router-dom';
import { ChevronLeft } from 'lucide-react';

interface ComponentItem {
  title: string;
  description: string;
  path: string;
  color?: string;
}

const CATEGORIES = [
  {
    name: 'Display',
    items: [
      { title: 'Text', description: 'Displays text', path: '/text' },
      { title: 'Image', description: 'Displays an image', path: '/images' },
    ],
  },
  {
    name: 'Input',
    items: [
      { title: 'TextField', description: 'Input field for text', path: '/textfield' },
    ],
  },
  {
    name: 'Layout',
    items: [
      { title: 'Column', description: 'Arranges elements vertically', path: '/column' },
      { title: 'Row', description: 'Arranges elements horizontally', path: '/row' },
    ],
  },
];

export default function ComponentListScreen() {
  const navigate = useNavigate();

  return (
    <div className="h-full flex flex-col bg-white">
      {/* Header */}
      <header className="h-14 flex items-center justify-center px-4 relative border-b border-slate-100">
        <button 
          onClick={() => navigate('/')}
          className="absolute left-2 w-10 h-10 flex items-center justify-center text-blue-500"
        >
          <ChevronLeft size={24} />
        </button>
        <h1 className="text-lg font-bold text-blue-500">UI Components List</h1>
      </header>

      {/* List Content */}
      <div className="flex-1 overflow-y-auto p-4 space-y-6">
        {CATEGORIES.map((category) => (
          <div key={category.name} className="space-y-3">
            <h2 className="text-sm font-bold text-slate-900 ml-1">{category.name}</h2>
            <div className="space-y-3">
              {category.items.map((item) => (
                <button
                  key={item.title}
                  onClick={() => navigate(item.path)}
                  className="w-full p-4 bg-blue-100/50 hover:bg-blue-100 rounded-xl text-left transition-colors active:scale-[0.98]"
                >
                  <p className="text-sm font-bold text-slate-900">{item.title}</p>
                  <p className="text-xs text-slate-500 mt-0.5">{item.description}</p>
                </button>
              ))}
            </div>
          </div>
        ))}


      </div>
    </div>
  );
}
