import { BrowserRouter, Routes, Route, Navigate } from 'react-router-dom';
import LoginPage from './pages/LoginPage';
import SignupPage from './pages/SignupPage';

export default function App() {
  return (
      <BrowserRouter>
        <Routes>
          <Route path="/login"    element={<LoginPage />} />
          <Route path="/register" element={<SignupPage />} />

          {/* 나중에 페이지 추가할 때 여기에 계속 Route 추가 */}
          {/* <Route path="/dashboard" element={<DashboardPage />} /> */}

          {/* 정의되지 않은 경로는 로그인으로 */}
          <Route path="*" element={<Navigate to="/login" replace />} />
        </Routes>
      </BrowserRouter>
  );
}