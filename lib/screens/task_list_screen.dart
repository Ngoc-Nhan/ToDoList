// import 'package:flutter/material.dart';
// import '../services/task_service.dart';
// import '../models/tasks.dart';

// class TaskListScreen extends StatefulWidget {
//   const TaskListScreen({super.key});

//   @override
//   State<TaskListScreen> createState() => _TaskListScreenState();
// }

// class _TaskListScreenState extends State<TaskListScreen> {
//   late Future<tasks> futureTasks;

//   @override
//   void initState() {
//     super.initState();
//     futureTasks = TaskService().getTasks();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Tasks')),
//       body: FutureBuilder<tasks>(
//         future: futureTasks,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Lỗi: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data!.data == null) {
//             return const Center(child: Text('Không có dữ liệu'));
//           }

//           final list = snapshot.data!.data!;

//           return ListView.builder(
//             itemCount: list.length,
//             itemBuilder: (context, index) {
//               final task = list[index];

//               return Card(
//                 margin: const EdgeInsets.all(8),
//                 child: ListTile(
//                   title: Text(task.title ?? ''),
//                   subtitle: Text(task.description ?? ''),
//                   trailing: Text(task.status ?? ''),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
