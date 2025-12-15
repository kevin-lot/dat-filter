import 'package:app/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaru/widgets.dart';

class ListFiles extends ConsumerWidget {
  const ListFiles({super.key});

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color evenItemColor = colorScheme.primary.withValues(alpha: 0.15);
    final Color oddItemColor = colorScheme.primary.withValues(alpha: 0.05);

    final List<String?>? paths = ref.watch(filePickerResultNotifierProvider).value?.paths;
    if (paths == null) {
      return Container(); // maintain height
    }

    paths.removeWhere((final String? item) => item == null); // remove nullable string

    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: paths.length,
      itemBuilder: (final BuildContext context, final int index) {
        return Material(
          child: ListTile(
            leading: const Icon(Icons.file_present),
            title: Text(paths[index]!),
            trailing: YaruIconButton(
              icon: const Icon(Icons.close_rounded),
              onPressed: () => _removeFile(index, ref),
            ),
            tileColor: index.isEven ? oddItemColor : evenItemColor,
          ),
        );
      },
    );
  }

  void _removeFile(final int index, final WidgetRef ref) {
    ref.read(filePickerResultNotifierProvider).removeAt(index);
  }
}
