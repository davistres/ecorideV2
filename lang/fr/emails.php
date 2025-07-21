<?php

return [
    // Modèles pour des mails

    // Divers
    'hello' => 'Bonjour',
    'regards' => 'Cordialement',
    'salutation' => 'L\'équipe :app_name',
    'whoops' => 'Oups !',

    // Appel à l'action
    'action_url_trouble' => 'Si vous avez des difficultés à cliquer sur le bouton ":actionText", copiez et collez l\'URL ci-dessous dans votre navigateur web :',

    // Réinitialisation de mot de passe
    'reset_password' => [
        'subject' => 'Notification de réinitialisation de mot de passe',
        'greeting' => 'Bonjour !',
        'line_1' => 'Vous recevez cet e-mail car nous avons reçu une demande de réinitialisation de mot de passe pour votre compte.',
        'action' => 'Réinitialiser le mot de passe',
        'line_2' => 'Ce lien de réinitialisation de mot de passe expirera dans :count minutes.',
        'line_3' => 'Si vous n\'avez pas demandé de réinitialisation de mot de passe, aucune action supplémentaire n\'est requise.',
    ],

    // Vérification
    'verify_email' => [
        'subject' => 'Vérifiez votre adresse e-mail',
        'greeting' => 'Bonjour !',
        'line_1' => 'Veuillez cliquer sur le bouton ci-dessous pour vérifier votre adresse e-mail.',
        'action' => 'Vérifier l\'adresse e-mail',
        'line_2' => 'Si vous n\'avez pas créé de compte, aucune action supplémentaire n\'est requise.',
    ],

    // Bienvenue
    'welcome' => [
        'subject' => 'Bienvenue sur :app_name !',
        'greeting' => 'Bonjour :name !',
        'line_1' => 'Bienvenue sur :app_name ! Votre compte a été créé avec succès.',
        'line_2' => 'Vous avez reçu 20 crédits gratuits pour commencer à utiliser notre plateforme de covoiturage.',
        'action' => 'Commencer à utiliser :app_name',
        'line_3' => 'Si vous avez des questions, n\'hésitez pas à nous contacter.',
    ],
];
