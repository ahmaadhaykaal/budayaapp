class UnbordingContent {
  String image;
  String title;
  String discription;

  UnbordingContent({required this.image, required this.title, required this.discription});
}

List<UnbordingContent> contents = [
  UnbordingContent(
    title: 'Selamat Datang',
    image: 'assets/StudyTeach.png',
    discription: "Di Project UTS Ahmad Givantri Haykal (2311089005)"
  ),
  UnbordingContent(
    title: 'Selamat Datang',
    image: 'assets/StudyTeach.png',
    discription: "Terdapat berbagai fitur di project ini"
  ),
  UnbordingContent(
    title: 'Selamat Datang',
    image: 'assets/StudyTeach.png',
    discription: "Seperti List Budaya, Gallery Foto, CRUD Sejarawan dan Edit Profile"
  ),
];