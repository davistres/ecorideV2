@extends('layouts.app')

@section('content')
    <div class="dashboard-container">
        <h1 class="dashboard-title">Tableau de bord</h1>

        <div
            class="dashboard-grid @if (Auth::user()->role == 'Passager') passager @elseif(Auth::user()->role == 'Conducteur') conducteur @else les-deux @endif">

            <!-- Profil -->
            <div class="dashboard-widget profile-widget">
                <div class="widget-header">
                    <h2>Mon Profil</h2>
                </div>
                <div class="widget-content">
                    <p>Bonjour, {{ Auth::user()->name }}!</p>
                </div>
            </div>

            @if (Auth::user()->role == 'Conducteur' || Auth::user()->role == 'Les deux')
                <!-- Proposer un covoiturage -->
                <div class="dashboard-widget offered-trips-widget">
                    <div class="widget-header">
                        <h2>Mes trajets (en tant que chauffeur)</h2>
                        <a href="#" class="widget-action-btn">+</a>
                    </div>
                    <div class="widget-content">
                        @if ($trajets_chauffeur->count() > 0)
                            <div class="trip-cards">
                                @foreach ($trajets_chauffeur as $trajet)
                                    <div class="trip-card">
                                        <div class="trip-card-header">
                                            <div class="trip-route-dash">
                                                <span class="trip-city">{{ $trajet->city_dep }}</span>
                                                <i class="fas fa-arrow-right"></i>
                                                <span class="trip-city">{{ $trajet->city_arr }}</span>
                                            </div>
                                            <div class="trip-date-dash">
                                                {{ $trajet->departure_date }}
                                            </div>
                                        </div>
                                        <div class="trip-card-footer">
                                            <a href="#" class="trip-edit-btn">Modifier</a>
                                            <form action="#" method="POST" class="cancel-form">
                                                @csrf
                                                @method('DELETE')
                                                <button type="submit" class="trip-cancel-btn">Annuler</button>
                                            </form>
                                        </div>
                                    </div>
                                @endforeach
                            </div>
                        @else
                            <div class="no-trips">
                                <p>Vous n'avez aucun trajet de prévu en tant que chauffeur.</p>
                                <a href="#" class="create-trip-btn">Proposer un nouveau trajet</a>
                            </div>
                        @endif
                    </div>
                </div>

                <!-- Voiture -->
                <div class="dashboard-widget vehicles-widget">
                    <div class="widget-header">
                        <h2>Mes véhicules</h2>
                        <a href="#" class="widget-action-btn">+</a>
                    </div>
                    <div class="widget-content">
                        @if ($vehicules->count() > 0)
                            <div class="vehicles-list">
                                @foreach ($vehicules as $vehicule)
                                    <div class="vehicle-card">
                                        <div class="vehicle-info">
                                            <p class="vehicle-model">
                                                <span class="vehicle-brand">{{ $vehicule->brand }}</span>
                                                <span class="vehicle-name">{{ $vehicule->model }}</span>
                                            </p>
                                            <div class="vehicle-details">
                                                <span class="vehicle-detail"><i class="fas fa-car"></i>
                                                    {{ $vehicule->immat }}</span>
                                            </div>
                                        </div>
                                        <div class="vehicle-actions">
                                            <a href="#" class="vehicle-edit-btn"><i class="fas fa-pen"></i></a>
                                            <form action="#" method="POST" class="vehicle-delete-form">
                                                @csrf
                                                @method('DELETE')
                                                <button type="submit" class="vehicle-delete-btn"><i
                                                        class="fas fa-trash"></i></button>
                                            </form>
                                        </div>
                                    </div>
                                @endforeach
                            </div>
                        @else
                            <div class="no-vehicles">
                                <p>Vous n'avez aucun véhicule d'enregistré.</p>
                                <a href="#" class="add-vehicle-btn">Ajouter un véhicule</a>
                            </div>
                        @endif
                    </div>
                </div>
            @endif

            @if (Auth::user()->role == 'Passager' || Auth::user()->role == 'Les deux')
                <!-- Réservattion -->
                <div class="dashboard-widget booked-trips-widget">
                    <div class="widget-header">
                        <h2>Mes réservations (en tant que passager)</h2>
                    </div>
                    <div class="widget-content">
                        @if ($reservations->count() > 0)
                            <div class="trip-cards">
                                @foreach ($reservations as $reservation)
                                    <div class="trip-card">
                                        <div class="trip-card-header">
                                            <div class="trip-route-dash">
                                                <span class="trip-city">{{ $reservation->covoiturage->city_dep }}</span>
                                                <i class="fas fa-arrow-right"></i>
                                                <span class="trip-city">{{ $reservation->covoiturage->city_arr }}</span>
                                            </div>
                                            <div class="trip-date-dash">
                                                {{ $reservation->covoiturage->departure_date }}
                                            </div>
                                        </div>
                                        <div class="trip-card-content">
                                            <p class="trip-driver">
                                                <span class="driver-label">Conducteur:</span>
                                                <span
                                                    class="driver-name">{{ $reservation->covoiturage->user->name }}</span>
                                            </p>
                                        </div>
                                        <div class="trip-card-footer">
                                            <form action="#" method="POST" class="cancel-form">
                                                @csrf
                                                @method('DELETE')
                                                <button type="submit" class="trip-cancel-btn">Annuler la
                                                    réservation</button>
                                            </form>
                                        </div>
                                    </div>
                                @endforeach
                            </div>
                        @else
                            <div class="no-trips">
                                <p>Vous n'avez aucune réservation.</p>
                                <a href="{{ route('trips.index') }}" class="search-trips-btn">Trouver un trajet</a>
                            </div>
                        @endif
                    </div>
                </div>
            @endif
        </div>
    </div>
@endsection
