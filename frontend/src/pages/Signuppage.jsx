import { useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { register } from '../services/authService';

const INITIAL_FORM = {
    username: '',
    password: '',
    passwordConfirm: '',
    name: '',
    email: '',
};

export default function SignupPage() {
    const navigate = useNavigate();
    const [form, setForm] = useState(INITIAL_FORM);
    const [error, setError] = useState('');
    const [loading, setLoading] = useState(false);

    const handleChange = (e) => {
        setForm((prev) => ({ ...prev, [e.target.name]: e.target.value }));
        setError('');
    };

    const validate = () => {
        if (!form.username.trim()) return '아이디를 입력해 주세요.';
        if (form.username.trim().length < 4) return '아이디는 4자 이상이어야 합니다.';
        if (!form.name.trim()) return '이름을 입력해 주세요.';
        if (!form.email.trim()) return '이메일을 입력해 주세요.';
        if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(form.email))
            return '이메일 형식이 올바르지 않습니다.';
        if (form.password.length < 8) return '비밀번호는 8자 이상이어야 합니다.';
        if (form.password !== form.passwordConfirm)
            return '비밀번호가 일치하지 않습니다.';
        return null;
    };

    const handleSubmit = async (e) => {
        e.preventDefault();
        const validationError = validate();
        if (validationError) {
            setError(validationError);
            return;
        }

        setLoading(true);
        setError('');

        try {
            await register({
                username: form.username.trim(),
                password: form.password,
                name: form.name.trim(),
                email: form.email.trim(),
            });
            alert('회원가입이 완료되었습니다. 로그인해 주세요.');
            navigate('/login');
        } catch (err) {
            setError(err.message);
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
                    <h1 style={styles.title}>회원가입</h1>
                    <p style={styles.subtitle}>계정을 만들어 시스템을 이용하세요</p>
                </div>

                <form onSubmit={handleSubmit} style={styles.form} noValidate>
                    <Row>
                        <Field label="아이디 *">
                            <input
                                type="text"
                                name="username"
                                value={form.username}
                                onChange={handleChange}
                                placeholder="영문·숫자, 4자 이상"
                                autoComplete="username"
                                disabled={loading}
                                style={styles.input}
                            />
                        </Field>
                        <Field label="이름 *">
                            <input
                                type="text"
                                name="name"
                                value={form.name}
                                onChange={handleChange}
                                placeholder="실명을 입력하세요"
                                autoComplete="name"
                                disabled={loading}
                                style={styles.input}
                            />
                        </Field>
                    </Row>

                    <Field label="이메일 *">
                        <input
                            type="email"
                            name="email"
                            value={form.email}
                            onChange={handleChange}
                            placeholder="example@email.com"
                            autoComplete="email"
                            disabled={loading}
                            style={styles.input}
                        />
                    </Field>

                    <Field label="비밀번호 *">
                        <input
                            type="password"
                            name="password"
                            value={form.password}
                            onChange={handleChange}
                            placeholder="8자 이상 입력하세요"
                            autoComplete="new-password"
                            disabled={loading}
                            style={styles.input}
                        />
                    </Field>

                    <Field label="비밀번호 확인 *">
                        <input
                            type="password"
                            name="passwordConfirm"
                            value={form.passwordConfirm}
                            onChange={handleChange}
                            placeholder="비밀번호를 다시 입력하세요"
                            autoComplete="new-password"
                            disabled={loading}
                            style={{
                                ...styles.input,
                                borderColor:
                                    form.passwordConfirm && form.password !== form.passwordConfirm
                                        ? '#dc2626'
                                        : undefined,
                            }}
                        />
                        {form.passwordConfirm && form.password !== form.passwordConfirm && (
                            <span style={styles.fieldError}>비밀번호가 일치하지 않습니다</span>
                        )}
                    </Field>

                    {error && <p style={styles.error}>{error}</p>}

                    <button type="submit" disabled={loading} style={styles.button}>
                        {loading ? '처리 중...' : '회원가입'}
                    </button>
                </form>

                <p style={styles.footer}>
                    이미 계정이 있으신가요?{' '}
                    <Link to="/login" style={styles.link}>
                        로그인
                    </Link>
                </p>
            </div>
        </div>
    );
}

function Field({ label, children }) {
    return (
        <div style={{ display: 'flex', flexDirection: 'column', gap: 6, flex: 1 }}>
            <label style={styles.label}>{label}</label>
            {children}
        </div>
    );
}

function Row({ children }) {
    return (
        <div style={{ display: 'flex', gap: 14 }}>
            {children}
        </div>
    );
}

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
        maxWidth: 520,
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
        width: '100%',
        boxSizing: 'border-box',
    },
    fieldError: {
        fontSize: 12,
        color: '#dc2626',
        marginTop: 2,
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