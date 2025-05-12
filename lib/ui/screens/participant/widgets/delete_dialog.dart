import 'package:flutter/material.dart';
import 'package:race_tracking_app/providers/participant_provider.dart';
import 'package:race_tracking_app/ui/widgets/alerts/success_alert_dialog.dart';

class DeleteConfirmationDialog extends StatelessWidget {
  final String id;
  final String name;
  final ParticipantProvider participantProvider;

  const DeleteConfirmationDialog({
    Key? key,
    required this.id,
    required this.name,
    required this.participantProvider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: const EdgeInsets.all(24),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: colors.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(28),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: colors.errorContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.delete_rounded,
                size: 32,
                color: colors.onErrorContainer,
              ),
            ),
            const SizedBox(height: 24),

            // Title
            Text(
              'Delete Participant $name?',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: colors.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),

            // Description
            Text(
              'This participant will be permanently removed from the event.\nThis action cannot be undone.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colors.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),

            // Buttons
            Row(
              children: [
                // Cancel Button
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: colors.onSurface,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      side: BorderSide(color: colors.outline),
                    ),
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 16),

                // Delete Button
                Expanded(
                  child: FilledButton(
                    onPressed: () async {
                      await participantProvider.deleteParticipant(id);
                      Navigator.of(
                        context,
                      ).pop(); // Close the delete confirmation dialog

                      // Show the success dialog          // close confirmation before alert success
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder:
                            (_) => const SuccessAlertDialog(
                              message:
                                  'Participant has been successfully deleted.',
                            ),
                      );
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: colors.error,
                      foregroundColor: colors.onError,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text('Delete'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
