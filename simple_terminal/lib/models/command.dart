abstract class TerminalCommand {
  final String name;
  final String description;
  final String manual;
  TerminalCommand({
    required this.name,
    this.description = "",
    this.manual = "",
  });

  Future<String> execute({required List<String> arguments});
  String? autocomplete(String argument);
}
