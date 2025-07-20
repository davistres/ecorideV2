<!DOCTYPE html>
<html lang="fr">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="csrf-token" content="{{ csrf_token() }}">

    <title>EcoRide</title>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

    @vite(['resources/css/app.css', 'resources/js/app.js'])
</head>

<body>
    <!-- HEADER -->
    <header>
        @include('layouts.navigation') {{-- Using Breeze's navigation for now --}}
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
            <p class="copyright">&copy; {{ date('Y') }} EcoRide</p>
            <nav class="footer-nav">
                <a href="{{ route('mentions-legales') }}">Mentions légales</a>
                <a href="mailto:maildelentreprise@ecoride.fr">maildelentreprise@ecoride.fr</a>
            </nav>
        </div>
    </footer>

    <script src="{{ asset('js/main.js') }}"></script>
    <script src="{{ asset('js/navbar.js') }}"></script>
    <script src="{{ asset('js/forms.js') }}"></script>
    <script src="{{ asset('js/reviews-slider.js') }}"></script>
    <script src="{{ asset('js/covoiturage.js') }}"></script>
    @yield('scripts')
</body>

</html>
