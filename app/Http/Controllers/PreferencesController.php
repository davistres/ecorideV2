<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class PreferencesController extends Controller
{
    public function update(Request $request)
    {
        $request->validate([
            'pref_smoke' => 'nullable|in:Fumeur,Non-fumeur',
            'pref_pet' => 'nullable|in:Acceptés,Non-acceptés',
            'pref_libre' => 'nullable|string|max:255',
        ]);

        $user = Auth::user();
        $user->pref_smoke = $request->input('pref_smoke');
        $user->pref_pet = $request->input('pref_pet');
        $user->pref_libre = $request->input('pref_libre');
        $user->save();

        return response()->json(['success' => true, 'message' => 'Préférences mises à jour avec succès!']);
    }
}
