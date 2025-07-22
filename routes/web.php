<?php

use App\Http\Controllers\ProfileController;
use App\Http\Controllers\ContactController;
use App\Http\Controllers\TripController;
use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return view('welcome');
})->name('welcome');


Route::post('/rechercher', [TripController::class, 'search'])->name('search.covoiturage');

Route::get('/covoiturages', [TripController::class, 'index'])->name('trips.index');
Route::get('/covoiturages/confirmer/{id}', [TripController::class, 'confirm'])->name('trips.confirm');
Route::get('/covoiturages/participer/{id}', [TripController::class, 'participate'])->name('trips.participate');
Route::get('/covoiturages/{id}', [TripController::class, 'show'])->name('trips.show');

Route::get('/contact', function () {
    return view('contact');
})->name('contact');

Route::get('/mentions-legales', function () {
    return view('mentions-legales');
})->name('mentions-legales');

Route::post('/contact', [ContactController::class, 'store'])->name('contact.store');

Route::middleware('auth')->group(function () {
    Route::get('/profil', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profil', [ProfileController::class, 'update'])->name('profile.update');
    Route::delete('/profil', [ProfileController::class, 'destroy'])->name('profile.destroy');

    Route::get('/tableau-de-bord/utilisateurs', [App\Http\Controllers\DashboardController::class, 'userDashboard'])->name('dashboard_users');

    Route::get('/tableau-de-bord/admin', function () {
        return view('dashboard.admin');
    })->name('dashboard_admin');

    Route::get('/tableau-de-bord/employe', function () {
        return view('dashboard.employe');
    })->name('dashboard_employe');
});

require __DIR__ . '/auth.php';
