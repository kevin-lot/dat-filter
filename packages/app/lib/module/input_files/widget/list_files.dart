import 'package:domain/domain.dart' show FilePickerResultNotifierInterface;
import 'package:flutter/material.dart';
import 'package:watch_it/watch_it.dart';
import 'package:yaru/widgets.dart';

class ListFiles extends WatchingWidget {
  const ListFiles({super.key});

  @override
  Widget build(final BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color evenItemColor = colorScheme.primary.withValues(alpha: 0.15);
    final Color oddItemColor = colorScheme.primary.withValues(alpha: 0.05);

    final List<String?>? paths = watchPropertyValue((final FilePickerResultNotifierInterface n) => n.value)?.paths;
    if (paths == null) {
      return const _Container(); // maintain height
    }

    paths.removeWhere((final String? item) => item == null); // remove nullable string

    return _Container(
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: paths.length,
        itemBuilder: (final BuildContext context, final int index) {
          return Material(
            child: ListTile(
              leading: const Icon(Icons.file_present),
              title: Text(paths[index]!),
              trailing: YaruIconButton(
                icon: const Icon(Icons.close_rounded),
                onPressed: () => _removeFile(index),
              ),
              tileColor: index.isEven ? oddItemColor : evenItemColor,
            ),
          );
        },
      ),
    );
  }

  void _removeFile(final int index) {
    di<FilePickerResultNotifierInterface>().removeAt(index);
  }
}

class _Container extends StatelessWidget {
  const _Container({this.child});

  final Widget? child;

  @override
  Widget build(final BuildContext context) {
    return Container(
      child: child,
    );
  }
}
