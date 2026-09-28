// Puts the booking overlap constraint (SRS 4.8) into the latest migration.
//
// Serverpod's ORM cannot express an exclusion constraint, so after every
// `serverpod create-migration` run:
//
//   dart run tool/patch_migration.dart
//
// The idempotent SQL from `lib/src/db/constraints.dart` is added before the
// final COMMIT of `definition.sql` (used for new databases) and
// `migration.sql` (used to upgrade existing ones). Running the tool again
// updates the block in place.
import 'dart:io';

import 'package:homeslot_server/src/db/constraints.dart';

const _begin = '-- BEGIN HOMESLOT: booking overlap constraint (SRS 4.8)';
const _end = '-- END HOMESLOT';

void main(List<String> args) {
  final versions =
      Directory('migrations')
          .listSync()
          .whereType<Directory>()
          .map((d) => d.path)
          .where((p) => RegExp(r'\d{17}$').hasMatch(p))
          .toList()
        ..sort();
  if (versions.isEmpty) {
    stderr.writeln('No migrations found. Run `serverpod create-migration`.');
    exitCode = 1;
    return;
  }
  final target = args.isNotEmpty ? 'migrations/${args.first}' : versions.last;
  final block = '$_begin\n${DbConstraints.sql}$_end\n';

  for (final name in ['definition.sql', 'migration.sql']) {
    final file = File('$target/$name');
    final original = file.readAsStringSync();
    var sql = original;

    final begin = sql.indexOf(_begin);
    if (begin >= 0) {
      final end = sql.indexOf(_end, begin) + _end.length + 1;
      sql = sql.substring(0, begin) + block + sql.substring(end);
    } else {
      final commit = sql.lastIndexOf('COMMIT;');
      if (commit < 0) {
        stderr.writeln('$target/$name has no COMMIT; statement.');
        exitCode = 1;
        return;
      }
      sql = '${sql.substring(0, commit)}$block\n${sql.substring(commit)}';
    }

    if (sql == original) {
      stdout.writeln('$target/$name is up to date.');
    } else {
      file.writeAsStringSync(sql);
      stdout.writeln('Patched $target/$name');
    }
  }
}
