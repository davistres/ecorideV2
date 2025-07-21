<?php

namespace App\Providers;

use Illuminate\Support\ServiceProvider;
use Illuminate\Auth\Notifications\ResetPassword;
use Illuminate\Auth\Notifications\VerifyEmail;
use Illuminate\Notifications\Messages\MailMessage;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     */
    public function register(): void
    {
        //
    }

    /**
     * Bootstrap any application services.
     */
    public function boot(): void
    {
        // Mail de réinitialisation de mot de passe personnalisé => A vérifier si ça marche!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        ResetPassword::toMailUsing(function (object $notifiable, string $token) {
            return (new MailMessage)
                ->subject(__('emails.reset_password.subject'))
                ->greeting(__('emails.reset_password.greeting'))
                ->line(__('emails.reset_password.line_1'))
                ->action(__('emails.reset_password.action'), url(route('password.reset', [
                    'token' => $token,
                    'email' => $notifiable->getEmailForPasswordReset(),
                ], false)))
                ->line(__('emails.reset_password.line_2', ['count' => config('auth.passwords.' . config('auth.defaults.passwords') . '.expire')]))
                ->line(__('emails.reset_password.line_3'))
                ->salutation(__('emails.regards') . ',<br>' . __('emails.salutation', ['app_name' => config('app.name')]));
        });

        // Pareil: mails de vérification
        VerifyEmail::toMailUsing(function (object $notifiable, string $url) {
            return (new MailMessage)
                ->subject(__('emails.verify_email.subject'))
                ->greeting(__('emails.verify_email.greeting'))
                ->line(__('emails.verify_email.line_1'))
                ->action(__('emails.verify_email.action'), $url)
                ->line(__('emails.verify_email.line_2'))
                ->salutation(__('emails.regards') . ',<br>' . __('emails.salutation', ['app_name' => config('app.name')]));
        });
    }
}
