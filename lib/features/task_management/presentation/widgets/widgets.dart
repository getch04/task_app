library task_management_presentation_widgets;

import 'dart:math' show min;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasks_app/core/theme/app_theme.dart';
import 'package:tasks_app/features/task_management/domain/entities/task.dart';
import 'package:tasks_app/features/task_management/domain/services/assignee_color_service.dart';

import '../../../../core/constants/strings.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_field.dart';

part 'add_task_bottom_sheet.dart';
part 'assignee_chip_widget.dart';
part 'header_widget.dart';
part 'quick_filters_widget.dart';
part 'search_bar_widget.dart';
part 'task_bottom_navigation.dart';
part 'task_card.dart';
part 'task_item_widget.dart';
part 'task_list_widget.dart';
part 'task_section.dart';
part 'task_section_widget.dart';
