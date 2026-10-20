import { useNavigate } from 'react-router-dom';

export default function WelcomeScreen() {
  const navigate = useNavigate();

  return (
    <div className="h-full flex flex-col items-center justify-between px-8 py-12 text-center">
      {/* Header Info */}
      <div className="w-full flex justify-end text-right">
        <div>
          <p className="text-sm font-bold text-slate-900">Nguyễn Văn A</p>
          <p className="text-xs text-slate-500">2342312323</p>
        </div>
      </div>

      {/* Main Content */}
      <div className="flex flex-col items-center gap-8">
        {/* Logo Replacement (CSS Cube) */}
        <div className="relative w-32 h-32 flex items-center justify-center">
          <div className="absolute inset-0 bg-blue-500 rounded-2xl rotate-45 transform scale-75 opacity-20" />
          <div className="relative w-24 h-24 bg-gradient-to-br from-green-400 via-blue-500 to-indigo-600 rounded-2xl shadow-xl flex items-center justify-center transform rotate-12">
            <div className="w-12 h-12 border-4 border-white rounded-lg opacity-80" />
          </div>
        </div>

        <div className="space-y-4">
          <h1 className="text-2xl font-bold text-slate-900">Jetpack Compose</h1>
          <p className="text-sm text-slate-600 leading-relaxed px-4">
            Jetpack Compose is a modern UI toolkit for building native Android applications using a declarative programming approach.
          </p>
        </div>
      </div>

      {/* Action Button */}
      <button
        onClick={() => navigate('/list')}
        className="w-full h-14 bg-blue-500 hover:bg-blue-600 text-white font-bold rounded-2xl transition-all active:scale-95 shadow-lg shadow-blue-200"
      >
        I'm ready
      </button>
    </div>
  );
}
