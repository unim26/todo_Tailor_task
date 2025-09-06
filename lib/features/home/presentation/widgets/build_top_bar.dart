import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/features/auth/data/models/user_model.dart';
import 'package:todo/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:todo/features/auth/presentation/blocs/auth_bloc/auth_events.dart';

class BuildTopBar extends StatelessWidget {
  const BuildTopBar({super.key, required this.user});

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //profile picture
        CircleAvatar(
          radius: 20,
          backgroundImage: NetworkImage(user.photoUrl ?? ''),
          backgroundColor: Colors.grey[200],
        ),
        const SizedBox(width: 20),
        //welcome text
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome,",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              user.name,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ],
        ),

        //logout icon
        IconButton(
          onPressed: () => context.read<AuthBloc>().add(SignOutEvent()),
          icon: const Icon(Icons.logout),
        ),
      ],
    );
  }
}
