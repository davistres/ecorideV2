<?php

use App\Http\Controllers\ProfileController;
use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return view('welcome');
})->name('welcome');

Route::get('/trips', function () {
    return view('trips.index');
})->name('trips.index');

Route::get('/contact', function () {
    return view('contact');
})->name('contact');

Route::get('/mentions-legales', function () {
    return view('mentions-legales');
})->name('mentions-legales');

Route::middleware('auth')->group(function () {
    Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');

    Route::get('/dashboard/users', function () {
        return view('dashboard.users');
    })->name('dashboard_users');

    Route::get('/dashboard/admin', function () {
        return view('dashboard.admin');
    })->name('dashboard_admin');

    Route::get('/dashboard/employe', function () {
        return view('dashboard.employe');
    })->name('dashboard_employe');
});

require __DIR__.'/auth.php';
