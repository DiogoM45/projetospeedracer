import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<List<dynamic>> carregarTextosApresentacao() async {
  final String dados = await rootBundle.loadString(
    'assets/json/textos.json',
  );

  return jsonDecode(dados);
}

Future<List<dynamic>> carregarImagensApresentacao() async {
  final String dados = await rootBundle.loadString(
    'assets/json/imagens.json',
  );

  return jsonDecode(dados);
}

Future<List<dynamic>> carregarBotoesApresentacao() async {
  final String dados = await rootBundle.loadString(
    'assets/json/botoes.json',
  );

  return jsonDecode(dados);
}

class PaginaApresentacao extends StatelessWidget {
  const PaginaApresentacao({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<dynamic>>(
        future: carregarTextosApresentacao(),

        builder: (context, snapshotTextos) {
          if (snapshotTextos.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshotTextos.hasError) {
            return const Center(
              child: Text(
                'Erro ao carregar os textos',
              ),
            );
          }

          final textos = snapshotTextos.data ?? [];

          // Texto da apresentação
          Map<String, dynamic>? textoApresentacao;

          for (final texto in textos) {
            if (texto['id'] == 3) {
              textoApresentacao =
                  Map<String, dynamic>.from(texto);
              break;
            }
          }

          return FutureBuilder<List<dynamic>>(
            future: carregarImagensApresentacao(),

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

              final imagens = snapshotImagens.data ?? [];

              // Imagens
              Map<String, dynamic>? imagemFundo;
              Map<String, dynamic>? imagemPista;
              Map<String, dynamic>? imagemVisao;
              Map<String, dynamic>? imagemModelagem;
              Map<String, dynamic>? imagemSnakeOiler;

              for (final imagem in imagens) {
                if (imagem['id'] == 1) {
                  imagemFundo =
                      Map<String, dynamic>.from(imagem);
                }

                if (imagem['id'] == 2) {
                  imagemPista =
                      Map<String, dynamic>.from(imagem);
                }

                if (imagem['id'] == 3) {
                  imagemVisao =
                      Map<String, dynamic>.from(imagem);
                }

                if (imagem['id'] == 4) {
                  imagemModelagem =
                      Map<String, dynamic>.from(imagem);
                }

                if (imagem['id'] == 5) {
                  imagemSnakeOiler =
                      Map<String, dynamic>.from(imagem);
                }
              }

              return FutureBuilder<List<dynamic>>(
                future: carregarBotoesApresentacao(),

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

                  final botoes = snapshotBotoes.data ?? [];

                  // Botão voltar
                  Map<String, dynamic>? botaoVoltar;

                  for (final botao in botoes) {
                    if (botao['id'] == 5) {
                      botaoVoltar =
                          Map<String, dynamic>.from(botao);
                      break;
                    }
                  }

                  return Stack(
                    children: [
                      // Fundo
                      Positioned.fill(
                        child: imagemFundo != null
                            ? Image.asset(
                                imagemFundo['caminho'],
                                fit: BoxFit.cover,
                              )
                            : Container(
                                color: Colors.grey,
                              ),
                      ),

                      Positioned.fill(
                        child: Container(
                          color: Colors.black.withOpacity(0.15),
                        ),
                      ),

                      SafeArea(
                        child: Column(
                          children: [
                            // Título
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 20,
                                left: 30,
                                right: 30,
                              ),

                              child: Container(
                                width: double.infinity,

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
                                    width: 8,
                                  ),
                                ),

                                child: const Text(
                                  'APRESENTAÇÃO DO JOGO',

                                  textAlign: TextAlign.center,

                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(
                              height: 25,
                            ),

                            // Imagens
                            SizedBox(
                              height: 150,

                              child: ListView(
                                scrollDirection:
                                    Axis.horizontal,

                                padding:
                                    const EdgeInsets.symmetric(
                                  horizontal: 30,
                                ),

                                children: [
                                  if (imagemPista != null)
                                    _criarImagem(
                                      imagemPista['caminho'],
                                    ),

                                  if (imagemVisao != null)
                                    _criarImagem(
                                      imagemVisao['caminho'],
                                    ),

                                  if (imagemModelagem != null)
                                    _criarImagem(
                                      imagemModelagem['caminho'],
                                    ),

                                  if (imagemSnakeOiler != null)
                                    _criarImagem(
                                      imagemSnakeOiler['caminho'],
                                    ),
                                ],
                              ),
                            ),

                            const SizedBox(
                              height: 25,
                            ),

                            // Texto
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(
                                  horizontal: 50,
                                ),

                                child: Container(
                                  width: double.infinity,

                                  padding:
                                      const EdgeInsets.all(25),

                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(
                                      230,
                                      162,
                                      144,
                                      55,
                                    ),

                                    borderRadius:
                                        BorderRadius.circular(35),

                                    border: Border.all(
                                      color: Colors.black,
                                      width: 8,
                                    ),

                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black
                                            .withOpacity(0.5),

                                        blurRadius: 10,

                                        offset:
                                            const Offset(4, 5),
                                      ),
                                    ],
                                  ),

                                  child: Center(
                                    child: Text(
                                      textoApresentacao != null
                                          ? textoApresentacao[
                                              'texto']
                                          : 'Texto não encontrado.',

                                      textAlign:
                                          TextAlign.center,

                                      style: TextStyle(
                                        fontSize:
                                            textoApresentacao !=
                                                    null
                                                ? textoApresentacao[
                                                        'size']
                                                    .toDouble()
                                                : 20,

                                        fontWeight:
                                            FontWeight.bold,

                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(
                              height: 15,
                            ),

                            // Botão voltar
                            Padding(
                              padding:
                                  const EdgeInsets.only(
                                left: 30,
                                right: 30,
                                bottom: 20,
                              ),

                              child: SizedBox(
                                width: double.infinity,

                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },

                                  style:
                                      ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color(
                                      0xFFFF78A5,
                                    ),

                                    foregroundColor:
                                        Colors.black,

                                    padding:
                                        const EdgeInsets.symmetric(
                                      vertical: 15,
                                    ),

                                    shape:
                                        RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(
                                        20,
                                      ),

                                      side:
                                          const BorderSide(
                                        color: Colors.black,
                                        width: 4,
                                      ),
                                    ),
                                  ),

                                  child: Text(
                                    botaoVoltar != null
                                        ? botaoVoltar['texto']
                                        : 'Voltar Para Página Inicial',

                                    textAlign:
                                        TextAlign.center,

                                    style: TextStyle(
                                      fontSize:
                                          botaoVoltar != null
                                              ? botaoVoltar[
                                                      'size']
                                                  .toDouble()
                                              : 20,

                                      fontWeight:
                                          FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
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

  Widget _criarImagem(String caminho) {
    return Container(
      width: 200,

      margin: const EdgeInsets.only(
        right: 15,
      ),

      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 5,
        ),

        borderRadius:
            BorderRadius.circular(20),
      ),

      clipBehavior: Clip.antiAlias,

      child: Image.asset(
        caminho,
        fit: BoxFit.cover,
      ),
    );
  }
}