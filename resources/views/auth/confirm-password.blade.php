<x-guest-layout>
    <div class="auth-container">
        <h2>Confirmation du mot de passe</h2>

        <div class="info-message">
            Ceci est une zone sécurisée de l'application. Veuillez confirmer votre mot de passe avant de continuer.
        </div>

        <form method="POST" action="{{ route('password.confirm') }}" class="auth-form">
            @csrf

            <!-- Password -->
            <div class="form-group">
                <x-input-label for="password" value="Mot de passe" />
                <x-text-input id="password" type="password" name="password" required autocomplete="current-password" />
                <x-input-error :messages="$errors->get('password')" class="mt-2" />
            </div>

            <x-primary-button class="auth-button">
                Confirmer
            </x-primary-button>
        </form>
    </div>
</x-guest-layout>
