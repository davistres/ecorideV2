<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Mail;
use App\Mail\ContactFormMail;

class ContactController extends Controller
{
    public function store(Request $request)
    {
        $validated = $request->validate([
            'name' => 'required|string|max:255',
            'email' => 'required|email|max:255',
            'subject' => 'required|string|max:255',
            'message' => 'required|string',
        ]);

        // Ici, vous enverriez l'e-mail ou enregistreriez le message en base de données
        // Pour l'instant, nous allons juste flasher un message de succès.
        // Exemple d'envoi d'e-mail (nécessite une configuration Mail dans .env et une classe Mailable)
        // Mail::to('votre_email@example.com')->send(new ContactFormMail($validated));

        return redirect()->route('contact')->with('success', 'Votre message a été envoyé avec succès !');
    }
}