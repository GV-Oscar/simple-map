import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:simple_map/app/bloc/map/map_bloc.dart';
import 'package:simple_map/app/bloc/my_location/my_location_bloc.dart';
import 'package:simple_map/app/bloc/search/search_bloc.dart';
import 'package:simple_map/app/helpers/helpers.dart';
import 'package:simple_map/app/models/search_result.dart';
import 'package:simple_map/app/search/search_destination.dart';
import 'package:simple_map/app/services/traffic_service.dart';
import 'package:polyline_do/polyline_do.dart' as Poly;

part 'btn_my_location.dart';
part 'btn_my_route.dart';
part 'btn_track_user.dart';
part 'marker_manual.dart';
part 'searchbar.dart';
