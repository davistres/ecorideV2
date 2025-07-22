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

Route::middleware('auth')->group(function () {
    Route::post('/trip', [TripController::class, 'store'])->name('trip.store');
    Route::put('/trip/{id}', [TripController::class, 'update']);
    Route::delete('/trip/{id}', [TripController::class, 'cancel'])->name('trip.cancel');
    Route::get('/trip/{id}/passengers', [TripController::class, 'passengers']);
    Route::post('/trip/{id}/start', [TripController::class, 'start']);
    Route::post('/trip/{id}/end', [TripController::class, 'end']);
});

Route::get('/contact', function () {
    return view('contact');
})->name('contact');

Route::get('/mentions-legales', function () {
    return view('mentions-legales');
})->name('mentions-legales');

Route::post('/contact', [ContactController::class, 'store'])->name('contact.store');

Route::middleware('auth')->group(function () {
    Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::post('/profile/photo', [ProfileController::class, 'updatePhoto'])->name('profile.photo.update');
    Route::delete('/profile/photo', [ProfileController::class, 'deletePhoto'])->name('profile.photo.delete');
    Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');

    Route::post('/vehicles', [App\Http\Controllers\VehicleController::class, 'store'])->name('vehicle.store');
    Route::put('/vehicles/{immat}', [App\Http\Controllers\VehicleController::class, 'update']);
    Route::delete('/vehicles/{immat}', [App\Http\Controllers\VehicleController::class, 'destroy']);
    Route::get('/vehicles/{immat}/check-trips', [App\Http\Controllers\VehicleController::class, 'checkTrips']);
    Route::delete('/vehicles/{immat}/reset-role', [App\Http\Controllers\VehicleController::class, 'resetRole']);

    Route::put('/user/role', [UserController::class, 'updateRole'])->name('user.role.update');
    Route::post('/user/role/reset', [UserController::class, 'resetRole'])->name('user.role.reset');

    Route::get('/satisfaction/{id}/form', [App\Http\Controllers\SatisfactionController::class, 'showForm'])->name('satisfaction.form');

    Route::put('/preferences', [App\Http\Controllers\PreferencesController::class, 'update'])->name('preferences.update');

    Route::get('/tableau-de-bord/utilisateurs', [App\Http\Controllers\DashboardController::class, 'userDashboard'])->name('dashboard_users');

    Route::get('/tableau-de-bord/admin', function () {
        return view('dashboard.admin');
    })->name('dashboard_admin');

    Route::get('/tableau-de-bord/employe', function () {
        return view('dashboard.employe');
    })->name('dashboard_employe');
});

require __DIR__ . '/auth.php';
