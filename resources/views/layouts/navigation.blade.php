<nav class="navbar" x-data="{ open: false }">
    <div class="logo">
        <a href="{{ route('welcome') }}">EcoRide</a>
    </div>
    <div class="burger" id="burger">
        <div></div>
        <div></div>
        <div></div>
    </div>
    <ul class="nav-links" x-show="open" x-transition:enter="transition ease-out duration-200" x-transition:enter-start="opacity-0 scale-95" x-transition:enter-end="opacity-100 scale-100" x-transition:leave="transition ease-in duration-75" x-transition:leave-start="opacity-100 scale-100" x-transition:leave-end="opacity-0 scale-95">
        <li><a href="{{ route('welcome') }}">Accueil</a></li>
        <li><a href="{{ route('trips.index') }}">Covoiturage</a></li>
        <li><a href="{{ route('contact') }}">Contact</a></li>

        @php
            use Illuminate\Support\Facades\Auth;
        @endphp

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
