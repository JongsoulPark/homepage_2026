import { useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { login } from '../services/AuthService.js';

const LoginPage = () => {
    const navigate = useNavigate();
    const [ form, setForm ] = useState({userId: '', password: ''});
    const [ error, setError ] = useState('');
    const [ loading, setLoading ] = useState(false);

    const handleChange = (e) => {
        setForm((prev) => ({...prev, [e.target.name]: e.target.value}));
        setError('');
    };

    const handleSubmit = async e => {
        e.preventDefault();
        if ( !form.userId.trim() || !form.password ) {
            setError('아이디와 비밀번호를 모두 입력해 주세요.');
            return;
        }

        setLoading(true);
        setError('');

        try {
            await login(form.userId.trim(), form.password);
            navigate('/dashboard');
        } catch (error) {
            setError(error.message);
        } finally {
            setLoading(false);
        }
    };

    return (
        <div style={styles.page}>
            <div style={styles.card}>
                <div style={styles.header}>
                    <div style={styles.logo}>
                        <span style={styles.logoIcon}>◈</span>
                    </div>
                    <h1 style={styles.title}>로그인</h1>
                    <p style={styles.subtitle}>시스템에 접속하려면 로그인하세요</p>
                </div>

                <form onSubmit={handleSubmit} style={styles.form} noValidate>
                    <Field label="아이디">
                        <input
                            type="text"
                            name="username"
                            value={form.username}
                            onChange={handleChange}
                            placeholder="아이디를 입력하세요"
                            autoComplete="username"
                            disabled={loading}
                            style={styles.input}
                        />
                    </Field>

                    <Field label="비밀번호">
                        <input
                            type="password"
                            name="password"
                            value={form.password}
                            onChange={handleChange}
                            placeholder="비밀번호를 입력하세요"
                            autoComplete="current-password"
                            disabled={loading}
                            style={styles.input}
                        />
                    </Field>

                    {error && <p style={styles.error}>{error}</p>}

                    <button type="submit" disabled={loading} style={styles.button}>
                        {loading ? '로그인 중...' : '로그인'}
                    </button>
                </form>

                <p style={styles.footer}>
                    계정이 없으신가요?{' '}
                    <Link to="/register" style={styles.link}>
                        회원가입
                    </Link>
                </p>
            </div>
        </div>
    );
};

const Field = ({ label, children }) => {
    return (
        <div style={{ display: 'flex', flexDirection: 'column', gap: 6 }}>
            <label style={styles.label}>{label}</label>
            {children}
        </div>
    );
};

const styles = {
    page: {
        minHeight: '100vh',
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'center',
        background: '#f0f2f5',
        padding: '1.5rem',
    },
    card: {
        background: '#ffffff',
        borderRadius: 12,
        border: '1px solid #e2e5ea',
        padding: '2.5rem 2rem',
        width: '100%',
        maxWidth: 420,
        boxShadow: '0 2px 12px rgba(0,0,0,0.06)',
    },
    header: {
        textAlign: 'center',
        marginBottom: '2rem',
    },
    logo: {
        display: 'inline-flex',
        alignItems: 'center',
        justifyContent: 'center',
        width: 52,
        height: 52,
        background: '#1a3f6f',
        borderRadius: 12,
        marginBottom: '1rem',
    },
    logoIcon: {
        color: '#ffffff',
        fontSize: 22,
    },
    title: {
        margin: 0,
        fontSize: 22,
        fontWeight: 600,
        color: '#111827',
        letterSpacing: '-0.3px',
    },
    subtitle: {
        margin: '6px 0 0',
        fontSize: 14,
        color: '#6b7280',
    },
    form: {
        display: 'flex',
        flexDirection: 'column',
        gap: 18,
    },
    label: {
        fontSize: 13,
        fontWeight: 500,
        color: '#374151',
    },
    input: {
        height: 42,
        padding: '0 12px',
        border: '1px solid #d1d5db',
        borderRadius: 8,
        fontSize: 14,
        color: '#111827',
        background: '#fff',
        outline: 'none',
        transition: 'border-color 0.15s',
        width: '100%',
        boxSizing: 'border-box',
    },
    error: {
        margin: 0,
        padding: '10px 12px',
        background: '#fef2f2',
        border: '1px solid #fecaca',
        borderRadius: 8,
        fontSize: 13,
        color: '#dc2626',
    },
    button: {
        height: 44,
        background: '#1a3f6f',
        color: '#ffffff',
        border: 'none',
        borderRadius: 8,
        fontSize: 15,
        fontWeight: 600,
        cursor: 'pointer',
        transition: 'background 0.15s',
        marginTop: 4,
    },
    footer: {
        textAlign: 'center',
        marginTop: '1.5rem',
        fontSize: 14,
        color: '#6b7280',
    },
    link: {
        color: '#1a3f6f',
        fontWeight: 600,
        textDecoration: 'none',
    },
};



export default LoginPage;