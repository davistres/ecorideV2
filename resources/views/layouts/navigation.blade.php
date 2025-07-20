<nav class="navbar" x-data="{ open: false }">
    <div class="logo">
        <a href="{{ route('welcome') }}">EcoRide</a>
    </div>
    <div class="burger" id="burger" @click="open = ! open">
        <div></div>
        <div></div>
        <div></div>
    </div>
    <ul class="nav-links">
        <li><a href="{{ route('welcome') }}">Accueil</a></li>
        <li><a href="{{ route('trips.index') }}">Covoiturage</a></li>
        <li><a href="{{ route('contact') }}">Contact</a></li>

        @php
            use Illuminate\Support\Facades\Auth;
        @endphp

        @if (Auth::guard('admin')->check())
            <li>
                <a href="{{ route('admin.dashboard') }}" class="user-nom">
                    ADMIN
                </a>
            </li>
        @elseif(Auth::guard('employe')->check())
            <li>
                <a href="{{ route('employe.dashboard') }}" class="user-nom">
                    {{ Auth::guard('employe')->user()->name }}
                </a>
            </li>
        @elseif(Auth::guard('web')->check())
            <li>
                <a href="{{ route('home') }}" class="user-nom">
                    {{ Auth::guard('web')->user()->pseudo }}
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

    <div class="mobile-menu" id="mobile-menu" :class="{'active': open, 'hidden': ! open}">
        <a href="{{ route('welcome') }}" class="cta-button">Accueil</a>
        <a href="{{ route('trips.index') }}" class="cta-button">Covoiturage</a>
        <a href="{{ route('contact') }}" class="cta-button">Contact</a>

        @if (Auth::guard('admin')->check())
            <a href="{{ route('admin.dashboard') }}" class="cta-button user-identifier">ADMIN</a>
        @elseif(Auth::guard('employe')->check())
            <a href="{{ route('employe.dashboard') }}" class="cta-button user-identifier">
                {{ Auth::guard('employe')->user()->name }}
            </a>
        @elseif(Auth::guard('web')->check())
            <a href="{{ route('home') }}"
                class="cta-button user-identifier">{{ Auth::guard('web')->user()->pseudo }}</a>
        @endif

        @if (Auth::guard('admin')->check() || Auth::guard('employe')->check() || Auth::guard('web')->check())
            <form method="POST" action="{{ route('logout') }}" class="mobile-logout-form">
                @csrf
                <button type="submit" class="cta-button">Déconnexion</button>
            </form>
        @else
            <a href="{{ route('login') }}" class="cta-button">Connexion</a>
        @endif

        <div class="close-menu" id="close-menu" @click="open = false">&times;</div>
    </div>
</nav>
