import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import WelcomeScreen from '@/src/screens/WelcomeScreen';
import ComponentListScreen from '@/src/screens/ComponentListScreen';
import TextDetailScreen from '@/src/screens/TextDetailScreen';
import ImagesScreen from '@/src/screens/ImagesScreen';
import TextFieldScreen from '@/src/screens/TextFieldScreen';
import RowLayoutScreen from '@/src/screens/RowLayoutScreen';
import ColumnLayoutScreen from '@/src/screens/ColumnLayoutScreen';
import MobileFrame from '@/src/components/MobileFrame';

export default function App() {
  return (
    <Router>
      <div className="min-h-screen bg-slate-50 flex items-center justify-center p-0 sm:p-4 md:p-8">
        <MobileFrame>
          <Routes>
            <Route path="/" element={<WelcomeScreen />} />
            <Route path="/list" element={<ComponentListScreen />} />
            <Route path="/text" element={<TextDetailScreen />} />
            <Route path="/images" element={<ImagesScreen />} />
            <Route path="/textfield" element={<TextFieldScreen />} />
            <Route path="/row" element={<RowLayoutScreen />} />
            <Route path="/column" element={<ColumnLayoutScreen />} />
          </Routes>
        </MobileFrame>
      </div>
    </Router>
  );
}
