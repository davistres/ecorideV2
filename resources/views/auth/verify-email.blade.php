<x-guest-layout>
    <div class="auth-container">
        <h2>Vérification de l'adresse e-mail</h2>

        <div class="info-message">
            Merci de vous être inscrit ! Avant de commencer, pourriez-vous vérifier votre adresse e-mail en cliquant sur
            le lien que nous venons de vous envoyer ? Si vous n'avez pas reçu l'e-mail, nous vous en enverrons
            volontiers un autre.
        </div>

        @if (session('status') == 'verification-link-sent')
            <div class="alert-success">
                Un nouveau lien de vérification a été envoyé à l'adresse e-mail que vous avez fournie lors de
                l'inscription.
            </div>
        @endif

        <div class="auth-form">
            <form method="POST" action="{{ route('verification.send') }}">
                @csrf
                <x-primary-button class="auth-button">
                    Renvoyer l'e-mail de vérification
                </x-primary-button>
            </form>

            <div class="auth-links">
                <form method="POST" action="{{ route('logout') }}">
                    @csrf
                    <button type="submit" class="link-button">
                        Se déconnecter
                    </button>
                </form>
            </div>
        </div>
    </div>
</x-guest-layout>
