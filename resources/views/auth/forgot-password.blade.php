<x-guest-layout>
    <div class="auth-container">
        <h2>Mot de passe oublié</h2>

        <div class="info-message">
            Mot de passe oublié ? Pas de problème. Indiquez-nous simplement votre adresse e-mail et nous vous enverrons
            un lien de réinitialisation de mot de passe qui vous permettra d'en choisir un nouveau.
        </div>

        <!-- Session Status -->
        <x-auth-session-status class="mb-4" :status="session('status')" />

        <form method="POST" action="{{ route('password.email') }}" class="auth-form">
            @csrf

            <!-- Email Address -->
            <div class="form-group">
                <x-input-label for="email" value="Adresse e-mail" />
                <x-text-input id="email" type="email" name="email" :value="old('email')" required autofocus />
                <x-input-error :messages="$errors->get('email')" class="mt-2" />
            </div>

            <x-primary-button class="auth-button">
                Envoyer le lien de réinitialisation
            </x-primary-button>

            <div class="auth-links">
                <p>Vous vous souvenez de votre mot de passe ? <a href="{{ route('login') }}">Connectez-vous</a></p>
            </div>
        </form>
    </div>
</x-guest-layout>
