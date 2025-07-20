<x-guest-layout>
    <div class="auth-container">
        <h2>Inscription</h2>

        <form method="POST" action="{{ route('register') }}" class="auth-form">
            @csrf

            <!-- Pseudo -->
            <div class="form-group">
                <x-input-label for="pseudo" value="Pseudo" />
                <x-text-input id="pseudo" type="text" name="pseudo" :value="old('pseudo')" required autofocus autocomplete="pseudo" />
                <x-input-error :messages="$errors->get('pseudo')" class="mt-2" />
            </div>

            <!-- Email Address -->
            <div class="form-group">
                <x-input-label for="email" value="Email" />
                <x-text-input id="email" type="email" name="email" :value="old('email')" required autocomplete="username" />
                <x-input-error :messages="$errors->get('email')" class="mt-2" />
            </div>

            <!-- Password -->
            <div class="form-group">
                <x-input-label for="password" value="Mot de passe" />
                <x-text-input id="password" type="password" name="password" required autocomplete="new-password" />
                <x-input-error :messages="$errors->get('password')" class="mt-2" />
            </div>

            <!-- Confirm Password -->
            <div class="form-group">
                <x-input-label for="password_confirmation" value="Confirmer le mot de passe" />
                <x-text-input id="password_confirmation" type="password" name="password_confirmation" required autocomplete="new-password" />
                <x-input-error :messages="$errors->get('password_confirmation')" class="mt-2" />
            </div>

            <div class="info-message">
                En vous inscrivant, vous recevez automatiquement 20 crédits!
            </div>

            <x-primary-button class="auth-button">
                {{ __('S\'inscrire') }}
            </x-primary-button>

            <div class="auth-links">
                <p>Déjà inscrit? <a href="{{ route('login') }}">Connectez-vous</a></p>
            </div>
        </form>
    </div>
</x-guest-layout>