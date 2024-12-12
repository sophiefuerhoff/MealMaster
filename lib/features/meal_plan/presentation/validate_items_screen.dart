import 'package:flutter/material.dart';
import 'package:mealmaster/db/isar_factory.dart';
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';

import '../../../common/widgets/base_scaffold.dart';
import '../../../common/widgets/info_dialog_button.dart';
import '../../../db/storage_ingredient.dart';
import '../../../shared/open_ai/api_client.dart';
import '../../user_profile/data/user_repository.dart';
import 'widgets/detected_ingredient.dart';

class ValidateItemsScreen extends StatefulWidget {
  final List<StorageIngredient> ingredients;

  const ValidateItemsScreen({super.key, required this.ingredients});

  @override
  State<ValidateItemsScreen> createState() => _ValidateItemsScreenState();
}

class _ValidateItemsScreenState extends State<ValidateItemsScreen> {
  bool isRecording = false;
  final record = AudioRecorder();
  Stream<List<int>>? audioStream;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BaseScaffold(
        title: 'Neuer Plan',
        hasBackButton: true,
        child: Container(
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                children: [
                  Text(
                    "Erkannte Zutaten",
                    style: textTheme.titleLarge,
                    textAlign: TextAlign.start,
                  ),
                  InfoDialogButton(
                    infoText:
                        "MealMaster hat die angezeigten Vorräte erkannt. Du kannst diese bearbeiten, oder unten weitere Vorräte hinzufügen. Wenn du unzufrieden bist, kannst du auch zurück gehen und neue Fotos hochladen.",
                    title: "Bestätige die erkannten Vorräte",
                  ),
                ],
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: widget.ingredients.length,
                  itemBuilder: (context, index) {
                    final storageIngredient = widget.ingredients[index];
                    return DetectedIngredient(
                      name: storageIngredient.ingredient.value?.name ?? '',
                      count: storageIngredient.count ?? 0.0,
                      unit: storageIngredient.ingredient.value?.unit ?? '',
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Column(
                  children: [
                    IconButton(
                        onPressed: () async {
                          if (!isRecording) {
                            if (await record.hasPermission()) {
                              final tempDir = await getTemporaryDirectory();
                              final filePath =
                                  '${tempDir.path}/audio_message.m4a';

                              await record.start(
                                const RecordConfig(encoder: AudioEncoder.aacLc),
                                path: filePath,
                              );
                              setState(() {
                                isRecording = true;
                              });
                            }
                          } else {
                            final path = await record.stop();
                            setState(() {
                              isRecording = false;
                            });

                            if (path != null) {
                              var result =
                                  await ApiClient.transcribeAudio(path);
                              if (result != null) {
                                if (context.mounted) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Transkribierter Text'),
                                        content: Text(result),
                                        actions: <Widget>[
                                          TextButton(
                                            child: Text('Abbrechen'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          FilledButton(
                                            child: Text('Anwenden'),
                                            onPressed: () async {
                                              final updatedIngredients =
                                                  await ApiClient
                                                      .updateIngredientsFromText(
                                                widget.ingredients,
                                                result,
                                              );
                                              if (updatedIngredients != null) {
                                                setState(() {
                                                  widget.ingredients.clear();
                                                  widget.ingredients.addAll(
                                                      updatedIngredients);
                                                });
                                              }
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              }
                            }
                          }
                        },
                        iconSize: 40,
                        icon: Icon(
                          Icons.mic,
                          color: isRecording ? Colors.green : null,
                        )),
                    Text('Weitere Vorräte hinzufügen'),
                  ],
                ),
              ),
              SizedBox(height: 60),
              Center(
                child: FilledButton.icon(
                  icon: Icon(Icons.check),
                  onPressed: () async {
                    await ApiClient.generateMealPlan(
                        widget.ingredients,
                        await UserRepository().getUser(),
                        await IsarFactory().db);
                  },
                  label: Text('MealPlan erstellen'),
                ),
              ),
            ])));
  }
}
