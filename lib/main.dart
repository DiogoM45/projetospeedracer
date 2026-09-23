import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:speed_racer/pagina_apresentacao.dart';
import 'package:url_launcher/url_launcher.dart';

Future<List<dynamic>> carregarTextos() async {
  final String dados = await rootBundle.loadString(
    'assets/json/textos.json',
  );

  return jsonDecode(dados);
}

Future<List<dynamic>> carregarBotoes() async {
  final String dados = await rootBundle.loadString(
    'assets/json/botoes.json',
  );

  return jsonDecode(dados);
}

Future<List<dynamic>> carregarImagens() async {
  final String dados = await rootBundle.loadString(
    'assets/json/imagens.json',
  );

  return jsonDecode(dados);
}

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',

      theme: ThemeData(
        colorScheme: .fromSeed(
          seedColor: Colors.deepPurple,
        ),
      ),

      home: const MyHomePage(
        title: 'Flutter Demo Home Page',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<dynamic>>(
        future: carregarTextos(),

        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text(
                'JSON miou',
              ),
            );
          }

          final textos = snapshot.data!;

          return FutureBuilder<List<dynamic>>(
            future: carregarBotoes(),

            builder: (context, snapshotBotoes) {
              if (snapshotBotoes.connectionState ==
                  ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (snapshotBotoes.hasError) {
                return const Center(
                  child: Text(
                    'Erro ao carregar os botões',
                  ),
                );
              }

              final botoes = snapshotBotoes.data!;

              return FutureBuilder<List<dynamic>>(
                future: carregarImagens(),

                builder: (context, snapshotImagens) {
                  if (snapshotImagens.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (snapshotImagens.hasError) {
                    return const Center(
                      child: Text(
                        'Erro ao carregar as imagens',
                      ),
                    );
                  }

                  final imagens = snapshotImagens.data!;

                  return Stack(
                    children: [
                      // Fundo
                      Positioned.fill(
                        child: Image.asset(
                          imagens[0]['caminho'],
                          fit: BoxFit.cover,
                        ),
                      ),

                      Column(
                        children: [
                          // Título
                          Align(
                            alignment: Alignment.topCenter,

                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 30,
                              ),

                              child: Container(
                                width:
                                    MediaQuery.of(context).size.width *
                                    0.65,

                                padding:
                                    const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 15,
                                ),

                                decoration: BoxDecoration(
                                  color: Colors.pink,
                                  borderRadius:
                                      BorderRadius.circular(30),

                                  border: Border.all(
                                    color: Colors.black,
                                    width: 15,
                                  ),
                                ),

                                child: Text(
                                  textos[0]['texto'],

                                  textAlign: TextAlign.center,

                                  style: const TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(
                            height: 25,
                          ),

                          // Apresentação
                          Container(
                            width:
                                MediaQuery.of(context).size.width *
                                0.50,

                            height:
                                MediaQuery.of(context).size.height *
                                0.60,

                            padding: const EdgeInsets.all(20),

                            decoration: BoxDecoration(
                              color: const Color.fromARGB(
                                255,
                                162,
                                144,
                                55,
                              ),

                              border: Border.all(
                                color: Colors.black,
                                width: 15,
                              ),
                            ),

                            child: Center(
                              child: Text(
                                textos[1]['texto'],

                                textAlign: TextAlign.center,

                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),

                          const Spacer(),

                          // Botões
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(
                              horizontal: 25,
                              vertical: 20,
                            ),

                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,

                              children: [
                                // Sobre o filme
                                ElevatedButton(
                                  onPressed: () async {
                                    final Uri url = Uri.parse(
                                      'https://pt.wikipedia.org/wiki/Speed_Racer',
                                    );

                                    try {
                                      await launchUrl(
                                        url,
                                        mode:
                                            LaunchMode.platformDefault,
                                      );
                                    } catch (e) {
                                      debugPrint(
                                        'Erro ao abrir o link: $e',
                                      );
                                    }
                                  },

                                  style:
                                      ElevatedButton.styleFrom(
                                    backgroundColor: Colors.pink,
                                    foregroundColor: Colors.black,
                                  ),

                                  child: Text(
                                    botoes[0]['texto'],

                                    style: TextStyle(
                                      fontSize:
                                          botoes[0]['size']
                                              .toDouble(),
                                    ),
                                  ),
                                ),

                                // Próxima página
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,

                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const PaginaApresentacao(),
                                      ),
                                    );
                                  },

                                  style:
                                      ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color.fromARGB(
                                      255,
                                      255,
                                      120,
                                      165,
                                    ),

                                    foregroundColor:
                                        Colors.black,
                                  ),

                                  child: Text(
                                    botoes[1]['texto'],

                                    style: TextStyle(
                                      fontSize:
                                          botoes[1]['size']
                                              .toDouble(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}