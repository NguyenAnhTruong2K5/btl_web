<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>

        <html class="light" lang="vi">

        <head>
            <meta charset="utf-8" />
            <meta content="width=device-width, initial-scale=1.0" name="viewport" />
            <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
            <link
                href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@400;500;700;800;900&amp;family=Inter:wght@400;500;600;700&amp;display=swap"
                rel="stylesheet" />
            <link
                href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap"
                rel="stylesheet" />
            <link
                href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap"
                rel="stylesheet" />
            <script id="tailwind-config">
                tailwind.config = {
                    darkMode: "class",
                    theme: {
                        extend: {
                            colors: {
                                "on-secondary-fixed-variant": "#5c5b5b",
                                "surface-container-high": "#e1e3e3",
                                "primary-fixed": "#ff7668",
                                "surface": "#f6f6f6",
                                "secondary-container": "#e5e2e1",
                                "on-error": "#ffefef",
                                "surface-container-highest": "#dbdddd",
                                "surface-dim": "#d3d5d5",
                                "tertiary-fixed-dim": "#c68af3",
                                "background": "#f6f6f6",
                                "on-primary-container": "#4f0002",
                                "surface-variant": "#dbdddd",
                                "surface-tint": "#bb000c",
                                "outline": "#767777",
                                "secondary": "#5c5b5b",
                                "on-secondary-fixed": "#403f3f",
                                "surface-container-low": "#f0f1f1",
                                "on-error-container": "#510017",
                                "on-tertiary": "#fceeff",
                                "surface-container": "#e7e8e8",
                                "on-tertiary-fixed": "#290045",
                                "on-tertiary-container": "#4b0b75",
                                "tertiary": "#7941a4",
                                "outline-variant": "#acadad",
                                "inverse-surface": "#0c0f0f",
                                "on-primary": "#ffefed",
                                "surface-container-lowest": "#ffffff",
                                "secondary-fixed": "#e5e2e1",
                                "secondary-fixed-dim": "#d6d4d3",
                                "primary-container": "#ff7668",
                                "inverse-on-surface": "#9c9d9d",
                                "inverse-primary": "#ff5446",
                                "tertiary-container": "#d398ff",
                                "tertiary-dim": "#6c3497",
                                "on-surface-variant": "#5a5c5c",
                                "primary": "#bb000c",
                                "on-secondary-container": "#525151",
                                "error-dim": "#a70138",
                                "tertiary-fixed": "#d398ff",
                                "on-surface": "#2d2f2f",
                                "surface-bright": "#f6f6f6",
                                "on-secondary": "#f5f2f1",
                                "on-primary-fixed-variant": "#610003",
                                "on-background": "#2d2f2f",
                                "error-container": "#f74b6d",
                                "on-primary-fixed": "#000000",
                                "secondary-dim": "#504f4f",
                                "primary-fixed-dim": "#ff5b4c",
                                "primary-dim": "#a40009",
                                "on-tertiary-fixed-variant": "#54197f",
                                "error": "#b41340"
                            },
                            fontFamily: {
                                "headline": ["Be Vietnam Pro"],
                                "body": ["Inter"],
                                "label": ["Inter"]
                            },
                            borderRadius: { "DEFAULT": "0.25rem", "lg": "0.5rem", "xl": "0.75rem", "full": "9999px" },
                        },
                    },
                }
            </script>
            <style>
                .material-symbols-outlined {
                    font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
                }

                /* Hide built-in password reveal icon so only one custom eye is shown */
                input[type="password"]::-ms-reveal,
                input[type="password"]::-ms-clear {
                    display: none;
                }

                .bg-login-pattern {
                    background-image: radial-gradient(circle at 2px 2px, #dbdddd 1px, transparent 0);
                    background-size: 40px 40px;
                }
            </style>
        </head>

        <body class="bg-surface font-body text-on-surface min-h-screen flex flex-col">
            <!-- Header / Top Navigation (Suppressed state for transactional focus, but keeping brand identity per request) -->
            <header class="fixed top-0 w-full z-50 bg-white/80 backdrop-blur-md shadow-sm">
                <div class="flex justify-between items-center px-8 h-20 max-w-7xl mx-auto">
                    <div class="text-2xl font-black text-red-700 italic tracking-tighter font-headline">
                        CinemaVN
                    </div>
                    <a class="flex items-center gap-2 text-neutral-700 hover:text-red-600 transition-all duration-300 font-medium"
                        href="/">
                        <span class="material-symbols-outlined text-xl">arrow_back</span>
                        <span>Quay lại trang chủ</span>
                    </a>
                </div>
            </header>
            <!-- Main Content: Login Canvas -->
            <main class="flex-grow flex items-center justify-center pt-24 pb-12 px-4 bg-login-pattern">
                <div class="w-full max-w-md">
                    <!-- Login Card -->
                    <div
                        class="bg-surface-container-lowest rounded-[2rem] p-8 md:p-10 shadow-[0_12px_40px_rgba(45,47,47,0.06)] border border-outline-variant/10">
                        <!-- Title Section -->
                        <div class="text-center mb-10">
                            <h1
                                class="font-headline font-bold text-2xl md:text-3xl tracking-tight text-on-surface mb-3">
                                Đăng nhập hệ thống đặt vé
                            </h1>
                            <p class="text-on-surface-variant body-md">
                                Chào mừng bạn quay trở lại với không gian điện ảnh đỉnh cao.
                            </p>
                        </div>
                        <c:if test="${not empty loginError}">
                            <div class="bg-red-100 text-red-700 border border-red-300 rounded-lg p-4 mb-4 text-center">
                                ${loginError}</div>
                        </c:if>
                        <!-- Form Section -->
                        <form class="space-y-6" action="${pageContext.request.contextPath}/login" method="post">
                            <!-- Identity Input -->
                            <div class="space-y-2">
                                <label class="block label-md font-semibold text-on-surface-variant px-1" for="identity">
                                    Email / Số điện thoại
                                </label>
                                <div class="relative">
                                    <span
                                        class="material-symbols-outlined absolute left-4 top-1/2 -translate-y-1/2 text-outline">alternate_email</span>
                                    <input name="username" id="identity"
                                        class="w-full pl-12 pr-4 py-4 bg-surface-container-low border-none rounded-xl focus:ring-2 focus:ring-primary/20 focus:bg-surface-container-lowest transition-all duration-200 outline-none"
                                        placeholder="name@example.com" type="text"
                                        value="${not empty loginUsername ? loginUsername : param.username}" required />
                                </div>
                            </div>
                            <!-- Password Input -->
                            <div class="space-y-2">
                                <label class="block label-md font-semibold text-on-surface-variant px-1" for="password">
                                    Mật khẩu
                                </label>
                                <div class="relative">
                                    <span
                                        class="material-symbols-outlined absolute left-4 top-1/2 -translate-y-1/2 text-outline">lock</span>
                                    <input name="password" id="password"
                                        class="w-full pl-12 pr-14 py-4 bg-surface-container-low border-none rounded-xl focus:ring-2 focus:ring-primary/20 focus:bg-surface-container-lowest transition-all duration-200 outline-none"
                                        placeholder="••••••••" type="password" required />
                                    <button id="togglePassword"
                                        class="absolute right-4 top-1/2 -translate-y-1/2 text-outline hover:text-on-surface"
                                        aria-label="Hiện mật khẩu" type="button">
                                        <span id="togglePasswordIcon"
                                            class="material-symbols-outlined">visibility</span>
                                    </button>
                                </div>
                            </div>
                            <!-- Options: Remember & Forgot -->
                            <div class="flex items-center justify-between text-sm px-1">
                                <label class="flex items-center gap-2 cursor-pointer group">
                                    <div class="relative flex items-center justify-center">
                                        <input
                                            class="peer h-5 w-5 appearance-none border-2 border-outline-variant rounded bg-surface-container-low checked:bg-primary checked:border-primary transition-all duration-200"
                                            type="checkbox" />
                                        <span
                                            class="material-symbols-outlined absolute text-white scale-0 peer-checked:scale-100 transition-transform duration-200 text-sm">check</span>
                                    </div>
                                    <span
                                        class="text-on-surface-variant group-hover:text-on-surface transition-colors">Duy
                                        trì đăng nhập</span>
                                </label>
                                <a class="text-primary font-medium hover:underline decoration-primary/30 underline-offset-4"
                                    href="#">
                                    Quên mật khẩu?
                                </a>
                            </div>
                            <!-- Action Buttons -->
                            <div class="space-y-4 pt-2">
                                <button
                                    class="w-full py-4 bg-gradient-to-br from-primary to-primary-container text-on-primary font-bold rounded-xl shadow-lg shadow-primary/20 hover:scale-[1.02] active:scale-95 transition-all duration-300"
                                    type="submit">
                                    Đăng nhập
                                </button>
                                <div class="relative py-4 flex items-center justify-center">
                                    <div class="absolute inset-0 flex items-center">
                                        <div class="w-full border-t border-outline-variant/30"></div>
                                    </div>
                                </div>
                            </div>
                        </form>
                        <!-- Footer of Card -->
                        <div class="mt-10 text-center">
                            <p class="text-on-surface-variant body-md">
                                Chưa có tài khoản CinemaVN?
                            </p>
                            <a class="inline-block mt-4 px-8 py-3 bg-surface-container-highest text-on-surface font-bold rounded-xl hover:bg-surface-container-high transition-colors duration-300"
                                href="/register">
                                Đăng ký tài khoản
                            </a>
                        </div>
                    </div>
                    <!-- Promotion / Decorative Text -->
                    <div class="mt-8 text-center text-on-surface-variant opacity-60 flex flex-col items-center gap-2">
                        <div class="flex items-center gap-4 text-xs font-bold uppercase tracking-tighter">
                            <span>Đảm bảo bảo mật</span>
                            <span class="w-1 h-1 rounded-full bg-outline"></span>
                            <span>Hỗ trợ 24/7</span>
                            <span class="w-1 h-1 rounded-full bg-outline"></span>
                            <span>Ưu đãi thành viên</span>
                        </div>
                    </div>
                </div>
            </main>
            <!-- Footer (Minimal version for transaction pages) -->
            <footer class="w-full py-8 bg-surface-container-low border-t border-outline-variant/10">
                <div class="max-w-7xl mx-auto px-8 flex flex-col md:flex-row justify-between items-center gap-4">
                    <div class="text-sm text-on-surface-variant font-body">
                        © 2024 CinemaVN. All rights reserved.
                    </div>
                    <div class="flex gap-6">
                        <a class="text-sm text-neutral-500 hover:text-red-600 transition-colors" href="#">Điều khoản</a>
                        <a class="text-sm text-neutral-500 hover:text-red-600 transition-colors" href="#">Bảo mật</a>
                        <a class="text-sm text-neutral-500 hover:text-red-600 transition-colors" href="#">Trợ giúp</a>
                    </div>
                </div>
            </footer>

            <script>
                document.addEventListener('DOMContentLoaded', function () {
                    const passwordInput = document.getElementById('password');
                    const toggleButton = document.getElementById('togglePassword');
                    const toggleIcon = document.getElementById('togglePasswordIcon');

                    if (!passwordInput || !toggleButton || !toggleIcon) {
                        return;
                    }

                    toggleButton.addEventListener('click', function () {
                        const isHidden = passwordInput.type === 'password';
                        passwordInput.type = isHidden ? 'text' : 'password';
                        toggleIcon.textContent = isHidden ? 'visibility_off' : 'visibility';
                        toggleButton.setAttribute('aria-label', isHidden ? 'Ẩn mật khẩu' : 'Hiện mật khẩu');
                    });
                });
            </script>
        </body>

        </html>