import 'package:flutter/material.dart';

class Project {
  final String title;
  final String description;
  final List<String> tags;
  final Color accentColor;

  Project({
    required this.title,
    required this.description,
    required this.tags,
    required this.accentColor,
  });
}

// Data updated with your specific projects
List<Project> myProjects = [
  Project(
    title: "Sukhadiya Caterers Admin",
    description: "Managed live orders, event schedules, and automated billing for a large catering firm.",
    tags: ["Flutter", "Firebase", "PDF"],
    accentColor: Colors.orangeAccent,
  ),
  Project(
    title: "SkySnap Weather",
    description: "Real-time weather tracking with dynamic Lottie animations and location services.",
    tags: ["REST API", "Geolocator", "UI/UX"],
    accentColor: Colors.blueAccent,
  ),
  Project(
    title: "Amoncar Booking App",
    description: "Digital menu catalogue allowing clients to customize food packages and estimate costs.",
    tags: ["Node.js", "REST API", "GetX"],
    accentColor: Colors.greenAccent,
  ),
  Project(
    title: "Shree Hari Operations",
    description: "Inventory management dashboard for tracking raw materials and staff logistics.",
    tags: ["SQLite", "Offline First", "Dashboard"],
    accentColor: Colors.purpleAccent,
  ),
];

List<String> navTitles = ["Home", "Skills", "Projects", "Contact"];