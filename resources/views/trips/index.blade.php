@extends('layouts.app')

@section('title', 'Covoiturage')

@section('content')
    <script src="{{ asset('js/date-restriction.js') }}"></script>
    <script src="{{ asset('js/suggestion-links.js') }}"></script>
    <script src="{{ asset('js/profile-photo-sync.js') }}"></script>
    <script src="{{ asset('js/trip-filters.js') }}"></script>
    <script src="{{ asset('js/trip-details-modal.js') }}"></script>
    <script src="{{ asset('js/rating-stars.js') }}"></script>
    <script src="{{ asset('js/participate-buttons.js') }}"></script>
    <div class="covoiturage-container">
        <h1 class="covoiturage-title">Rechercher un covoiturage</h1>

        <section class="search-section">
            <!-- Gestion des messages -->
            @if (isset($error))
                <div class="error-message">
                    {{ $error }}
                </div>
            @endif

            @if (isset($success))
                <div class="alert-success">
                    {{ $success }}
                </div>
            @endif

            @if (isset($info))
                <div class="info-message">
                    {{ $info }}

                    @if (isset($suggested_date))
                        <form action="{{ route('search.covoiturage') }}" method="POST" class="suggested-date-form">
                            @csrf
                            <input type="hidden" name="lieu_depart" value="{{ $lieu_depart }}">
                            <input type="hidden" name="lieu_arrivee" value="{{ $lieu_arrivee }}">
                            <input type="hidden" name="date" value="{{ $suggested_date }}">
                            Essayez plutôt le <strong>{{ date('d/m/Y', strtotime($suggested_date)) }}</strong>
                            <button type="submit" class="suggested-date-btn">Rechercher à cette date</button>
                        </form>
                    @endif

                    @if (isset($suggestions))
                        <div class="date-suggestions">
                            @if (count($suggestions) > 0)
                                <p>Nous n'avons pas de covoiturage à la date recherchée. Néanmoins, nous en avons
                                    @foreach ($suggestions as $index => $suggestion)
                                        @if ($index == 0)
                                            @if ($suggestion['count'] > 1)
                                                {{ $suggestion['count'] }} le <a href="#" class="suggestion-link"
                                                    data-date="{{ $suggestion['date'] }}"
                                                    data-depart="{{ $lieu_depart }}"
                                                    data-arrivee="{{ $lieu_arrivee }}">{{ $suggestion['formatted_date'] }}</a>
                                                ({{ $suggestion['diff'] }})
                                            @else
                                                le <a href="#" class="suggestion-link"
                                                    data-date="{{ $suggestion['date'] }}"
                                                    data-depart="{{ $lieu_depart }}"
                                                    data-arrivee="{{ $lieu_arrivee }}">{{ $suggestion['formatted_date'] }}</a>
                                                ({{ $suggestion['diff'] }})
                                            @endif
                                        @elseif($index == count($suggestions) - 1)
                                            @if ($suggestion['count'] > 1)
                                                et {{ $suggestion['count'] }} le <a href="#" class="suggestion-link"
                                                    data-date="{{ $suggestion['date'] }}"
                                                    data-depart="{{ $lieu_depart }}"
                                                    data-arrivee="{{ $lieu_arrivee }}">{{ $suggestion['formatted_date'] }}</a>
                                                ({{ $suggestion['diff'] }})
                                            @else
                                                et le <a href="#" class="suggestion-link"
                                                    data-date="{{ $suggestion['date'] }}"
                                                    data-depart="{{ $lieu_depart }}"
                                                    data-arrivee="{{ $lieu_arrivee }}">{{ $suggestion['formatted_date'] }}</a>
                                                ({{ $suggestion['diff'] }})
                                            @endif
                                        @else
                                            @if ($suggestion['count'] > 1)
                                                , {{ $suggestion['count'] }} le <a href="#" class="suggestion-link"
                                                    data-date="{{ $suggestion['date'] }}"
                                                    data-depart="{{ $lieu_depart }}"
                                                    data-arrivee="{{ $lieu_arrivee }}">{{ $suggestion['formatted_date'] }}</a>
                                                ({{ $suggestion['diff'] }})
                                            @else
                                                , le <a href="#" class="suggestion-link"
                                                    data-date="{{ $suggestion['date'] }}"
                                                    data-depart="{{ $lieu_depart }}"
                                                    data-arrivee="{{ $lieu_arrivee }}">{{ $suggestion['formatted_date'] }}</a>
                                                ({{ $suggestion['diff'] }})
                                            @endif
                                        @endif
                                    @endforeach
                                    ... Pourquoi ne pas changer de date si vous êtes flexible?
                                </p>
                            @else
                                <p>Nous n'avons pas de covoiturage à la date recherchée. Pourquoi ne pas changer de date si
                                    vous êtes flexible?</p>
                            @endif

                            <!-- Formulaire caché pour les suggestions -->
                            <form id="suggestion-form" action="{{ route('search.covoiturage') }}" method="POST"
                                style="display: none;">
                                @csrf
                                <input type="hidden" id="suggestion-lieu-depart" name="lieu_depart" value="">
                                <input type="hidden" id="suggestion-lieu-arrivee" name="lieu_arrivee" value="">
                                <input type="hidden" id="suggestion-date" name="date" value="">
                            </form>
                        </div>
                    @endif
                </div>
            @endif

            <!-- Formulaire de recherche -->
            <form class="search-form" action="{{ route('search.covoiturage') }}" method="POST">
                @csrf
                <div class="form-group">
                    <label for="lieu_depart">Départ</label>
                    <input type="text" id="lieu_depart" name="lieu_depart" placeholder="Ville de départ" required
                        value="{{ old('lieu_depart') ?? ($lieu_depart ?? request('lieu_depart')) }}">
                </div>
                <div class="form-group">
                    <label for="lieu_arrivee">Arrivée</label>
                    <input type="text" id="lieu_arrivee" name="lieu_arrivee" placeholder="Ville d'arrivée" required
                        value="{{ old('lieu_arrivee') ?? ($lieu_arrivee ?? request('lieu_arrivee')) }}">
                </div>
                <div class="form-group">
                    <label for="date">Date</label>
                    <input type="date" id="date" name="date" required
                        value="{{ old('date') ?? ($date_recherche ?? request('date')) }}">
                </div>
                <button type="submit" class="search-button">Rechercher un trajet</button>
            </form>
        </section>

        <!-- Section des filtres -->
        @include('trips.partials.filters', ['min_price' => $min_price, 'max_price' => $max_price, 'min_duration' => $min_duration, 'max_duration' => $max_duration, 'min_duration_formatted' => $min_duration_formatted, 'max_duration_formatted' => $max_duration_formatted])

        @if (isset($covoiturages) && count($covoiturages) > 0)
            <div class="results-title">
                <h2>Trajets disponibles</h2>
                <p>{{ count($covoiturages) }} résultat(s) trouvé(s)</p>
            </div>

            <section class="covoiturage-list">
                @foreach ($covoiturages as $covoiturage)
                    <div class="covoiturage-card">
                        <div class="covoiturage-top-info">
                            <div class="covoiturage-driver">
                                @if ($covoiturage->photo_chauffeur_data)
                                    <img src="{{ $covoiturage->photo_chauffeur_data }}"
                                        alt="{{ $covoiturage->pseudo_chauffeur }}" class="driver-photo">
                                @else
                                    <div class="driver-photo photo-placeholder">
                                        <i class="fas fa-user svg-inline--fa"></i>
                                    </div>
                                @endif
                                <div class="driver-info">
                                    <h3>{{ $covoiturage->pseudo_chauffeur }}</h3>
                                    <div class="driver-rating">
                                        <span class="rating-value">{{ $covoiturage->note_chauffeur }}</span>
                                        <span class="rating-stars">
                                            @if (is_numeric($covoiturage->note_chauffeur))
                                                @for ($i = 1; $i <= 5; $i++)
                                                    <span class="star filled">★</span>
                                                @endfor
                                            @else
                                                <span>Nouveau conducteur</span>
                                            @endif
                                        </span>
                                    </div>
                                </div>
                            </div>

                            <div class="covoiturage-booking-info">
                                <div class="trip-seats">
                                    <i class="fas fa-user"></i>
                                    <span>{{ $covoiturage->places_restantes }}
                                        {{ $covoiturage->places_restantes > 1 ? 'places disponibles' : 'place disponible' }}</span>
                                </div>
                                <div class="trip-price">
                                    <span class="price-value">{{ $covoiturage->prix }} crédits</span>
                                    <span class="price-per-person">par personne</span>
                                </div>
                            </div>
                        </div>

                        <div class="covoiturage-driver">
                            @if ($covoiturage->photo_chauffeur_data)
                                <img src="{{ $covoiturage->photo_chauffeur_data }}"
                                    alt="{{ $covoiturage->pseudo_chauffeur }}" class="driver-photo">
                            @else
                                <div class="driver-photo photo-placeholder">
                                    <i class="fas fa-user svg-inline--fa"></i>
                                </div>
                            @endif
                            <div class="driver-info">
                                <h3>{{ $covoiturage->pseudo_chauffeur }}</h3>
                                <div class="driver-rating">
                                    <span class="rating-value">{{ $covoiturage->note_chauffeur }}</span>
                                    <span class="rating-stars">
                                        <!-- C'est le JS qui génère les étoiles -->
                                        @if (!is_numeric($covoiturage->note_chauffeur))
                                            <span>Nouveau conducteur</span>
                                        @endif
                                    </span>
                                </div>
                            </div>
                        </div>


                        <div class="covoiturage-details">
                            <div class="trip-info-container">
                                <div class="trip-info-left">
                                    <div class="trip-route">
                                        <span class="from">{{ $covoiturage->city_dep }}</span>
                                        <span class="route-arrow">→</span>
                                        <span class="to">{{ $covoiturage->city_arr }}</span>
                                    </div>
                                    <div class="trip-date">
                                        <i class="fas fa-calendar"></i>
                                        {{ date('d/m/Y', strtotime($covoiturage->departure_date)) }}
                                    </div>
                                </div>
                                <div class="trip-time">
                                    <span class="departure-time">
                                        <i class="fas fa-clock"></i>
                                        Départ: {{ substr($covoiturage->departure_time, 0, 5) }}
                                    </span>
                                    <span class="arrival-time">
                                        <i class="fas fa-clock"></i>
                                        Arrivée: {{ substr($covoiturage->arrival_time ?? '00:00', 0, 5) }}
                                    </span>
                                </div>
                            </div>

                            <div class="trip-eco-badge {{ $covoiturage->ecologique ? 'eco' : 'standard' }}">
                                @if ($covoiturage->ecologique)
                                    <i class="fas fa-leaf"></i> Voyage écologique
                                @else
                                    <i class="fas fa-car"></i> Voyage standard
                                @endif
                            </div>
                        </div>


                        <div class="covoiturage-booking">
                            <div class="trip-seats">
                                <i class="fas fa-user"></i>
                                <span>{{ $covoiturage->places_restantes }}
                                    {{ $covoiturage->places_restantes > 1 ? 'places disponibles' : 'place disponible' }}</span>
                            </div>

                            <div class="trip-price">
                                <span class="price-value">{{ $covoiturage->prix }} crédits</span>
                                <span class="price-per-person">par personne</span>
                            </div>

                            <div class="booking-buttons">
                                <a href="{{ route('trips.confirm', ['id' => $covoiturage->id ?? 1]) }}"
                                    class="btn-base btn-details" data-id="{{ $covoiturage->id ?? 1 }}">
                                    Détails
                                </a>
                                <a href="{{ route('trips.participate', ['id' => $covoiturage->id ?? 1]) }}"
                                    class="btn-base btn-participate">
                                    Participer
                                </a>
                            </div>
                        </div>

                        <div class="mobile-buttons">
                            <a href="{{ route('trips.confirm', ['id' => $covoiturage->id ?? 1]) }}"
                                class="btn-base btn-details" data-id="{{ $covoiturage->id ?? 1 }}">
                                Détails
                            </a>
                            <a href="{{ route('trips.participate', ['id' => $covoiturage->id ?? 1]) }}"
                                class="btn-base btn-participate">
                                Participer
                            </a>
                        </div>
                    </div>
                @endforeach
            </section>
        @elseif(request()->isMethod('POST') || isset($_GET['error']))
            <div class="no-results">
                <p>Aucun covoiturage disponible correspondant à vos critères.</p>
                <p>Essayez de modifier votre recherche ou consultez nos suggestions ci-dessus.</p>
            </div>
        @else
            <div class="welcome-message">
                <div class="welcome-icon">🚗</div>
                <h2>Bienvenue sur la page de covoiturage</h2>
                <p>Utilisez le formulaire ci-dessus pour trouver votre prochain trajet écologique et économique.</p>
                <div class="welcome-tips">
                    <h3>Conseils pour votre recherche :</h3>
                    <ul>
                        <li>Soyez précis sur les noms de villes</li>
                        <li>Essayez différentes dates pour plus d'options</li>
                        <li>Les voyages écologiques sont indiqués par un badge vert</li>
                    </ul>
                </div>
            </div>

        @endif

    </div>

    <!-- Inclure la modale => détails des covoit -->
    @include('trips.trip-details-modal')
@endsection
