import 'package:flutter/material.dart';
import '../data/time_repository.dart';
import '../data/setting_repository.dart';
import '../model/time.dart';
import 'select.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final repository = TimeRepository();
  late Future<SettingsRepository> settingsRepoFuture;

  @override
  void initState() {
    super.initState();
    settingsRepoFuture = SettingsRepository.create();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Times"),
      ),
      body: FutureBuilder<List<Time>>(
        future: repository.fetchTime(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Erro ao carregar os times'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhum time encontrado'));
          } else {
            final times = snapshot.data!;

            return FutureBuilder<SettingsRepository>(
              future: settingsRepoFuture,
              builder: (context, repoSnapshot) {
                if (!repoSnapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                final settingsRepo = repoSnapshot.data!;

                return FutureBuilder<List<Time>>(
                  future: settingsRepo.getRecentTimes(),
                  builder: (context, recentSnapshot) {
                    final recentList = recentSnapshot.data ?? [];

                    return ListView(
                      children: [
                        if (recentList.isNotEmpty) ...[
                          const Padding(
                            padding: EdgeInsets.all(12),
                            child: Text(
                              "Recentes",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          ...recentList.map(
                            (time) => GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => SelectPage(time: time),
                                  ),
                                );
                              },
                              child: Card(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        time.logo,
                                        width: 40,
                                        height: 40,
                                        fit: BoxFit.contain,
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: Text(
                                          time.name,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      const Icon(
                                        Icons.arrow_forward_ios,
                                        size: 16,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Divider(),
                        ],
                        const Padding(
                          padding: EdgeInsets.all(12),
                          child: Text(
                            "Times",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        ...times.map((time) {
                          return GestureDetector(
                            onTap: () async {
                              await settingsRepo.addRecentTime(time);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => SelectPage(time: time),
                                ),
                              ).then((_) => setState(() {}));
                            },
                            child: Card(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      time.logo,
                                      width: 40,
                                      height: 40,
                                      fit: BoxFit.contain,
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Text(
                                        time.name,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    const Icon(
                                      Icons.arrow_forward_ios,
                                      size: 16,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ],
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
