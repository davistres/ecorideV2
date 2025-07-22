<!DOCTYPE html>
<html lang="fr">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="csrf-token" content="{{ csrf_token() }}">

    @php
        use Illuminate\Support\Facades\Auth;
    @endphp

    <title>{{ config('app.name', 'EcoRide') }}</title>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

    @vite(['resources/css/app.css', 'resources/js/app.js'])
</head>

<body>
    <!-- HEADER -->
    <header>
        <nav class="navbar">
            <div class="logo">
                <a href="{{ route('welcome') }}">EcoRide</a>
            </div>
            <div class="burger" id="burger">
                <div></div>
                <div></div>
                <div></div>
            </div>
            <ul class="nav-links">
                <li><a href="{{ route('welcome') }}">Accueil</a></li>
                <li><a href="{{ route('trips.index') }}">Covoiturage</a></li>
                <li><a href="{{ route('contact') }}">Contact</a></li>

                @if (Auth::guard('admin')->check())
                    <li>
                        <a href="{{ route('dashboard_admin') }}" class="user-nom">
                            ADMIN
                        </a>
                    </li>
                @elseif(Auth::guard('employe')->check())
                    <li>
                        <a href="{{ route('dashboard_employe') }}" class="user-nom">
                            {{ Auth::guard('employe')->user()->name }}
                        </a>
                    </li>
                @elseif(Auth::guard('web')->check())
                    <li>
                        <a href="{{ route('dashboard_users') }}" class="user-nom">
                            {{ Auth::guard('web')->user()->name }}
                        </a>
                    </li>
                @endif

                @if (Auth::guard('admin')->check() || Auth::guard('employe')->check() || Auth::guard('web')->check())
                    <li>
                        <form method="POST" action="{{ route('logout') }}">
                            @csrf
                            <button type="submit" class="cta-button">Déconnexion</button>
                        </form>
                    </li>
                @else
                    <a href="{{ route('login') }}" class="cta-button">Connexion</a>
                @endif
            </ul>
        </nav>

        <div class="mobile-menu" id="mobile-menu">
            <a href="{{ route('welcome') }}" class="cta-button">Accueil</a>
            <a href="{{ route('trips.index') }}" class="cta-button">Covoiturage</a>
            <a href="{{ route('contact') }}" class="cta-button">Contact</a>

            @if (Auth::guard('admin')->check())
                <a href="{{ route('dashboard_admin') }}" class="cta-button user-identifier">ADMIN</a>
            @elseif(Auth::guard('employe')->check())
                <a href="{{ route('dashboard_employe') }}" class="cta-button user-identifier">
                    {{ Auth::guard('employe')->user()->name }}
                </a>
            @elseif(Auth::guard('web')->check())
                <a href="{{ route('dashboard_users') }}"
                    class="cta-button user-identifier">{{ Auth::guard('web')->user()->name }}</a>
            @endif

            @if (Auth::guard('admin')->check() || Auth::guard('employe')->check() || Auth::guard('web')->check())
                <form method="POST" action="{{ route('logout') }}" class="mobile-logout-form">
                    @csrf
                    <button type="submit" class="cta-button">Déconnexion</button>
                </form>
            @else
                <a href="{{ route('login') }}" class="cta-button">Connexion</a>
            @endif

            <div class="close-menu" id="close-menu">&times;</div>
        </div>
    </header>

    <!-- MAIN QUI CHANGE -->
    <main>
        @yield('content')
    </main>

    <!-- FOOTER -->
    <footer>
        <div class="image-banner">
            <img src="{{ asset('images/pexels-cottonbro-5329298.jpg') }}" alt="Covoiturage EcoRide" class="main-image">
        </div>
        <div class="footer footer-content">
            <nav class="footer-nav">
                <a href="{{ route('mentions-legales') }}">Mentions légales</a>
                <a href="mailto:maildelentreprise@ecoride.fr">maildelentreprise@ecoride.fr</a>
            </nav>
            <p class="copyright">&copy; {{ date('Y') }} EcoRide</p>
        </div>
    </footer>

    <script src="https://hammerjs.github.io/dist/hammer.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/js/all.min.js"></script>
    <script src="{{ asset('js/main.js') }}"></script>
    <script src="{{ asset('js/navbar.js') }}"></script>
    <script src="{{ asset('js/forms.js') }}"></script>
    <script src="{{ asset('js/reviews-slider.js') }}"></script>
    <script src="{{ asset('js/covoiturage.js') }}"></script>
    @yield('scripts')
</body>

</html>
