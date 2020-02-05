import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:forasterosrp_chat/custom_icons_icons.dart';

class Chat extends StatefulWidget {
  static const String id = "CHAT";
  final FirebaseUser user;

  const Chat({Key key, this.user}) : super(key: key);
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _firestore = Firestore.instance;

  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();

  Future<void> callback() async {
    if (messageController.text.length > 0) {
      await _firestore.collection('chat-ooc').add({
        'text': messageController.text,
        'from': widget.user.email,
        'date': DateTime.now().toIso8601String().toString(),
      });
      messageController.clear();
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 300),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    _launchURL(String url) async {
      if (await canLaunch(url)) {
        await launch(url);
      }
    }

    desconectar() {
      _auth.signOut();
      Navigator.of(context).popUntil((route) => route.isFirst);
    }

    return Scaffold(
      appBar: AppBar(
        leading: Hero(
          tag: 'logo',
          child: Container(
            height: 40.0,
            child: Image.asset('assets/image/logo.png'),
          ),
        ),
        title: Text("ForasterosRP Chat"),
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("ForasterosRP"),
              accountEmail: Text(widget.user.email),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/image/logo.gif'),
              ),
            ),
            /*ListView(
              children: <Widget>[
                ExpansionTile(
                  title: Text('Foro ForasterosRP'),
                  children: <Widget>[
                    ExpansionTile(
                      title: Text('General'),
                      children: <Widget>[
                        ListTile(
                          leading: Icon(FontAwesomeIcons.page4),
                          title: Text('Normas'),
                          onTap: () => _launchURL(
                              'https://foro.forasterosrp.com/normas-f4/'),
                        ),
                        ListTile(
                          leading: Icon(FontAwesomeIcons.page4),
                          title: Text('Información y noticias'),
                          onTap: () => _launchURL(
                              'https://foro.forasterosrp.com/informacion-y-noticias-f5/'),
                        ),
                        ListTile(
                          leading: Icon(FontAwesomeIcons.page4),
                          title: Text('Eventos y concursos'),
                          onTap: () => _launchURL(
                              'https://foro.forasterosrp.com/eventos-y-concursos-f6/'),
                        ),
                      ],
                    ),
                    ExpansionTile(
                      title: Text('Facciones'),
                      children: <Widget>[
                        ListTile(
                          leading: Icon(FontAwesomeIcons.poll),
                          title: Text('LSPD'),
                          onTap: () => _launchURL(
                              'https://foro.forasterosrp.com/fuerzas-y-cuerpos-de-seguridad-del-estado-f22/'),
                        ),
                        ListTile(
                          leading: Icon(FontAwesomeIcons.medkit),
                          title: Text('LSFD'),
                          onTap: () => _launchURL(
                              'https://foro.forasterosrp.com/cuerpo-de-emergencias-sanitarias-f23/'),
                        ),
                      ],
                    ),
                    ExpansionTile(
                      title: Text('Soporte'),
                      children: <Widget>[
                        ListTile(
                          leading: Icon(FontAwesomeIcons.medkit),
                          title: Text('Reportes'),
                          onTap: () => _launchURL(
                              'https://foro.forasterosrp.com/reportes-f15/'),
                        ),
                        ListTile(
                          leading: Icon(FontAwesomeIcons.medkit),
                          title: Text('Dudas y problemas técnicos'),
                          onTap: () => _launchURL(
                              'https://foro.forasterosrp.com/dudas-y-problemas-tecnicos-f16/'),
                        ),
                        ListTile(
                          leading: Icon(FontAwesomeIcons.medkit),
                          title: Text('Informar de un bug'),
                          onTap: () => _launchURL(
                              'https://foro.forasterosrp.com/informar-de-un-bug-f17/'),
                        ),
                        ListTile(
                          leading: Icon(FontAwesomeIcons.medkit),
                          title: Text('Reclamaciones'),
                          onTap: () => _launchURL(
                              'https://foro.forasterosrp.com/reclamaciones-f18/'),
                        ),
                      ],
                    ),
                    ExpansionTile(
                      title: Text('Comunidad'),
                      children: <Widget>[
                        ListTile(
                          leading: Icon(FontAwesomeIcons.medkit),
                          title: Text('Vida de la ciudad [IC]'),
                          onTap: () => _launchURL(
                              'https://foro.forasterosrp.com/vida-en-la-ciudad-ic-f8/'),
                        ),
                        ListTile(
                          leading: Icon(FontAwesomeIcons.medkit),
                          title: Text('Roles de la comunidad [OOC]'),
                          onTap: () => _launchURL(
                              'https://foro.forasterosrp.com/roles-de-la-comunidad-ooc-f9/'),
                        ),
                        ListTile(
                          leading: Icon(FontAwesomeIcons.medkit),
                          title: Text('Debates'),
                          onTap: () => _launchURL(
                              'https://foro.forasterosrp.com/debates-f10/'),
                        ),
                        ListTile(
                          leading: Icon(FontAwesomeIcons.medkit),
                          title: Text('Sugerencias'),
                          onTap: () => _launchURL(
                              'https://foro.forasterosrp.com/sugerencias-f11/'),
                        ),
                        ListTile(
                          leading: Icon(FontAwesomeIcons.medkit),
                          title: Text('Presentaciones'),
                          onTap: () => _launchURL(
                              'https://foro.forasterosrp.com/presentaciones-f12/'),
                        ),
                        ListTile(
                          leading: Icon(FontAwesomeIcons.medkit),
                          title: Text('Off-Topic'),
                          onTap: () => _launchURL(
                              'https://foro.forasterosrp.com/off-topic-f13/'),
                        ),
                      ],
                    ),
                    ExpansionTile(
                      title: Text('IC'),
                      children: <Widget>[
                        ListTile(
                          leading: Icon(FontAwesomeIcons.newspaper),
                          title: Text('Forasteros News'),
                          onTap: () => _launchURL(
                              'https://foro.forasterosrp.com/forasteros-news-f25/'),
                        ),
                      ],
                    )
                  ],
                ),
                ListTile(
                  leading: Icon(CustomIcons.twitter_1),
                  title: Text('Twitter'),
                  onTap: () => _launchURL('https://twitter.com/ForasterosRp'),
                ),
                ListTile(
                  leading: Icon(CustomIcons.twitch),
                  title: Text('Twitch'),
                  onTap: () =>
                      _launchURL('https://www.twitch.tv/forasterosrp/'),
                ),
                Divider(),
                Expanded(
                  child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: ListTile(
                      leading: Icon(FontAwesomeIcons.signOutAlt),
                      title: Text('Desconectarse'),
                      onTap: () => desconectar(),
                    ),
                  ),
                )
              ],
            ),*/
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
                child: StreamBuilder<QuerySnapshot>(
                    stream: _firestore
                        .collection('chat-ooc')
                        .orderBy('date')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData)
                        return Center(
                          child: CircularProgressIndicator(),
                        );

                      List<DocumentSnapshot> docs = snapshot.data.documents;

                      List<Widget> messages = docs
                          .map((doc) => Message(
                              from: doc.data['from'],
                              text: doc.data['text'],
                              me: widget.user.email == doc.data['from']))
                          .toList();
                      return ListView(
                        controller: scrollController,
                        children: <Widget>[
                          ...messages,
                        ],
                      );
                    })),
            Container(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onSubmitted: (value) => callback(),
                      decoration: InputDecoration(
                        hintText: "Escribe un Mensaje...",
                        border: const OutlineInputBorder(),
                      ),
                      controller: messageController,
                    ),
                  ),
                  SendButton(
                    text: "Enviar",
                    callback: callback,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SendButton extends StatelessWidget {
  final String text;
  final VoidCallback callback;

  const SendButton({Key key, this.text, this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: Colors.orange,
      onPressed: callback,
      child: Text(text),
    );
  }
}

class Message extends StatelessWidget {
  final String from;
  final String text;

  final bool me;

  const Message({Key key, this.from, this.text, this.me}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment:
            me ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(from),
          Material(
            color: me ? Colors.green[900] : Colors.red[700],
            borderRadius: BorderRadius.circular(10.0),
            elevation: 6.0,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
              child: Text(text),
            ),
          )
        ],
      ),
    );
  }
}
