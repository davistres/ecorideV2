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

        \App\Models\Contact::create([
            'nom' => $validated['name'],
            'mail' => $validated['email'],
            'sujet' => match ($validated['subject']) {
                'support' => 'Support technique',
                'reservation' => 'Problème lié à une réservation',
                'other' => 'Autre',
                default => 'Autre',
            },
            'message' => $validated['message'],
            'date_envoi' => now(),
            'statut' => 'Non-traité',
        ]);

        return redirect()->route('contact')->with('success', 'Votre message a été envoyé avec succès !');
    }
}