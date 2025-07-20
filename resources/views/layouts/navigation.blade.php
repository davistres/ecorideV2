<nav class="navbar">
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
</nav>
