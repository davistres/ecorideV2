<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class UserController extends Controller
{
    public function updateRole(Request $request)
    {
        $request->validate([
            'role' => 'required|in:Passager,Conducteur,Les deux',
        ]);

        $user = Auth::user();
        $user->role = $request->input('role');
        $user->save();

        return redirect()->back()->with('success', 'Votre rôle a été mis à jour.');
    }

    // TODO: Logique pour suppr les préférences et les véhicules
    public function resetRole()
    {
        $user = Auth::user();
        $user->role = 'Passager';

        $user->save();

        return response()->json(['success' => true, 'message' => 'Votre rôle a été réinitialisé à Passager.']);
    }
}
