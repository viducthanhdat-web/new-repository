import React from 'react';

interface MobileFrameProps {
  children: React.ReactNode;
}

export default function MobileFrame({ children }: MobileFrameProps) {
  return (
    <div className="w-full max-w-[430px] h-[100dvh] sm:h-[844px] bg-white sm:rounded-[3rem] sm:shadow-2xl overflow-hidden border-[8px] border-slate-900 relative flex flex-col">
      {/* Top Status Bar Mockup */}
      <div className="h-10 shrink-0 flex items-center justify-between px-6 pt-2 bg-white">
        <span className="text-sm font-semibold text-slate-900">9:41</span>
        <div className="flex items-center gap-1.5">
          <div className="w-4 h-4 rounded-full border-2 border-slate-900" />
          <div className="w-4 h-4 rounded-full bg-slate-900" />
          <div className="w-6 h-3 rounded-sm border-2 border-slate-900" />
        </div>
      </div>
      
      {/* App Content */}
      <div className="flex-1 overflow-y-auto scrollbar-hide relative bg-white">
        {children}
      </div>

      {/* Bottom Home Indicator */}
      <div className="h-8 shrink-0 flex items-center justify-center bg-white">
        <div className="w-32 h-1 bg-slate-900 rounded-full" />
      </div>
    </div>
  );
}
