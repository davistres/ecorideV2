<x-guest-layout>
    <div class="auth-container">
        <h2>Réinitialiser le mot de passe</h2>

        <form method="POST" action="{{ route('password.store') }}" class="auth-form">
            @csrf

            <!-- Password Reset Token -->
            <input type="hidden" name="token" value="{{ $request->route('token') }}">

            <!-- Email Address -->
            <div class="form-group">
                <x-input-label for="email" value="Adresse e-mail" />
                <x-text-input id="email" type="email" name="email" :value="old('email', $request->email)" required autofocus
                    autocomplete="username" />
                <x-input-error :messages="$errors->get('email')" class="mt-2" />
            </div>

            <!-- Password -->
            <div class="form-group">
                <x-input-label for="password" value="Nouveau mot de passe" />
                <x-text-input id="password" type="password" name="password" required autocomplete="new-password" />
                <x-input-error :messages="$errors->get('password')" class="mt-2" />
            </div>

            <!-- Confirm Password -->
            <div class="form-group">
                <x-input-label for="password_confirmation" value="Confirmer le nouveau mot de passe" />
                <x-text-input id="password_confirmation" type="password" name="password_confirmation" required
                    autocomplete="new-password" />
                <x-input-error :messages="$errors->get('password_confirmation')" class="mt-2" />
            </div>

            <x-primary-button class="auth-button">
                Réinitialiser le mot de passe
            </x-primary-button>
        </form>
    </div>
</x-guest-layout>
