import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter/material.dart';
import 'package:vtapp/models/attendance_model.dart';
import 'package:vtapp/models/exam_schedule_model.dart';
import 'package:vtapp/models/gpa_model.dart';
import 'package:vtapp/models/grades_model.dart';
import 'package:vtapp/models/marks_model.dart';
import 'package:vtapp/models/timetable_model.dart';
import 'package:vtapp/models/timetablecurr_model.dart';

class Session {
  static String? attmodel;
  static String? authorizedID;
  static String? logincsrf;
  static String? cookies;
  static String? gpamodel;
  static String? regNo;
  static String? logindata;
  static String? password;
  static String? captcha;
  static String? dashboardcsrf;
  static Dio? dio;
  static CookieJar? cookieJar;
  static GpaModel? GPAinfo;
  static List<AttendanceModel>? attinfo;
  static Map<String,String> semesterID = {};
  static List<CourseMark>? marksInfo;
  static String? marksmodel;
  static String? timetablehtml = " ";
  static Element? el;
  static String? gradesHtml= " ";
  static GradeReport? subjects;
  static List<TimetableModel>? timetablemodel;
  static String? examVenueHtml;
  static List<ExamGroup>? examVenueModel;
  static Map<String, (String start, String end)> slotTimes = {
  // Morning A/D series
  "A11": ("08:30", "10:00"),
  "D11": ("08:30", "10:00"),
  "A12": ("08:30", "10:00"),
  "D12": ("08:30", "10:00"),
  "A13": ("08:30", "10:00"),
  "D13": ("08:30", "10:00"),

  // Morning B/E series
  "B11": ("10:05", "11:35"),
  "E11": ("10:05", "11:35"),
  "B12": ("10:05", "11:35"),
  "E12": ("10:05", "11:35"),
  "B13": ("10:05", "11:35"),
  "E13": ("10:05", "11:35"),

  // Morning C/F series
  "C11": ("11:40", "13:10"),
  "F11": ("11:40", "13:10"),
  "C12": ("11:40", "13:10"),
  "F12": ("11:40", "13:10"),
  "C13": ("11:40", "13:10"),
  "F13": ("11:40", "13:10"),
  // Afternoon A/D series
  "A21": ("13:15", "14:45"),
  "D21": ("13:15", "14:45"),
  "A22": ("13:15", "14:45"),
  "D22": ("13:15", "14:45"),
  "A23": ("13:15", "14:45"),
  "D23": ("13:15", "14:45"),
  "A14": ("14:45", "16:20"),
  "E14": ("14:45", "16:20"),
  "B14": ("14:45", "16:20"),
  "F14": ("14:45", "16:20"),
  "C14": ("14:45", "16:20"),
  "D14": ("14:45", "16:20"),


  // Afternoon B/E series
  "B21": ("16:25", "17:55"),
  "E21": ("16:25", "17:55"),
  "B22": ("16:25", "17:55"),
  "E22": ("16:25", "17:55"),
  "B23": ("16:25", "17:55"),
  "D24": ("16:25", "17:55"),


  // Evening C/F series
  "C21": ("18:00", "19:30"),
  "F21": ("18:00", "19:30"),
  "A24": ("18:00", "19:30"),
  "F22": ("18:00", "19:30"),
  "B24": ("18:00", "19:30"),
  "E23": ("18:00", "19:30"),
};
static Map<String, List<String>> dayToSlots = {
  "MON": ["A11", "B11", "C11", "A21", "A14","B21","C21"],
  "TUE": ["D11", "E11", "F11", "D21", "E14","E21","F21"],
  "WED": ["A12", "B12", "C12", "A22", "B14","B22","A24"],
  "THU": ["D12", "E12", "F12", "D22", "F14","E22","F22"],
  "FRI": ["A13", "B13", "C13", "A23", "C14","B23","B24"],
  "SAT": ["D13", "E13", "F13", "D23", "D14","D24","E23"],
};

static List<String>? daysMapping = ["MON","TUE","WED","THU","FRI","SAT"];
static List<TimetablecurrModel>? timetablecurrent;


 }