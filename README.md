# supaquiz

A multiplayer trivia/quiz game built with Supabase. Submission for the Supabase launch week 6
hackathon.

Trivia questions used from [The Trivia API](https://the-trivia-api.com).

Try the [live demo](https://yallurium.github.io/supaquiz)!

## Features

* Create/host trivia games and share the game code so that other players can join you.
* Join other games given a game code.
* Play alone (practise).

## Coming up

* Player statistics (games played, games won, questions answered correctly...)
* Quiz customization (categories, difficulty)
* Other game modes?

## Supabase
This project uses Supabase to achieve multiplayer and real-time functionality.

* Supabase Auth: users are registered "anonymously" with a randomly generated email when they visit the app.
* Supabase Database: games, players, questions and answers are stored in a database and accessed by all players to answer questions and see the score.
* Supabase Realtime: players listen to game status updates real-time so that the game starts for everyone at the same time.

## Development
Supaquiz is a [Flutter](https://flutter.dev) app and supports Web, Android and iOS (desktop platforms should also be easy to support). If you have the Flutter SDK installed, you can run the app with `flutter run` or build the app with `flutter build`.

**IMPORTANT**: Because of the "anonymous" login mechanism, email confirmations should be disabled. Otherwise the logged in user will not be able to read/write to the database and the game will not work.

## Deployment
A GitHub Action is set up to build the project for the web platform when changes are pushed to the `main` branch, and publish the updated web app on [GitHub Pages](https://yallurium.github.io/supaquiz).