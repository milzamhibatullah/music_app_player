

## Demo

Insert gif or link to demo
# Music App Player
This repository is music app player created using Flutter framework with Itunes music api


## API Reference

#### Get All song

```http
  GET /searc?search?term=$term&media=music
```

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `term` | `string` | Term as query to api |



## Theme Reference

Theme reference is from material design 3. visit [generate custom color](https://m3.material.io/theme-builder#/custom)

## Tech Stack

**Client:** Flutter, Flutter_bloc, Equatable, CachedImageNetwork, Just_Audio, Shimmer



## Installation
Make sure your workstation has installed the Flutter framework(Stable)

for Instalation Flutter Framework visit this [setup flutter framewrk](https://docs.flutter.dev/get-started/install)

Clone the project first

```bash
  git clone https://github.com/milzamhibatullah/music_app_player.git
  git fetch
  git checkout master
  git pull origin master
```
Enter the project directory
```bash
  cd music_app_player/
```
Inside project directory, Clean the project first
```bash
  flutter clean
```
After clean the project, run this command
```bash
  flutter pub get
```

After that, to run this project, run this command
```bash
  flutter run
```

For buildin APK, run this command
```bash
  flutter build apk --release