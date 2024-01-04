import 'package:flutter/material.dart';
import 'package:flutter_news_app/src/models/news_model.dart';
import 'package:flutter_news_app/src/theme/tema.dart';

class ListaNoticias extends StatelessWidget {
  final List<Article> noticias;
  const ListaNoticias({Key? key, required this.noticias}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: noticias.length,
        itemBuilder: (context, index) {
          return _Noticia(noticia: noticias[index], index: index);
        });
  }
}

class _Noticia extends StatelessWidget {
  final Article noticia;
  final int index;
  const _Noticia({ required this.noticia, required this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TarjetaTopBar(
          noticia: noticia,
          index: index,
        ),
        _TarjetaTitulo(noticia: noticia),
        _TarjetaImagen(noticia: noticia),
        _TarjetaBody(noticia: noticia),
        const _TarjetaBotones(),
        const SizedBox(height: 10,),
        const Divider()


      ],
    );
  }
}

class _TarjetaBotones extends StatelessWidget {
  const _TarjetaBotones();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        RawMaterialButton(onPressed: (){},
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          fillColor: darkTheme.primaryColorDark,
          child: const Icon(Icons.star_border),
        ),
        const SizedBox(width: 10,),
        RawMaterialButton(onPressed: (){},
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          fillColor: Colors.blue,
          child: const Icon(Icons.more),
        ),
      ],
    );
  }
}

class _TarjetaBody extends StatelessWidget {
  final Article noticia;
  
  const _TarjetaBody({
    required this.noticia,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text((noticia.description != null) ? noticia.description! : ''),
    );
  }
}

class _TarjetaImagen extends StatelessWidget {
  final Article noticia;
  const _TarjetaImagen({
    Key? key,
    required this.noticia,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
        
        child: Container(
          child: (noticia.urlToImage != null)
              ? FadeInImage(
                  image: NetworkImage(noticia.urlToImage!),
                  placeholder: const AssetImage('assets/giphy.gif'),
                )
              : Image.asset('assets/no-image.png'),
        ),
      ),
    );
  }
}


class _TarjetaTitulo extends StatelessWidget {
  final Article noticia;
  const _TarjetaTitulo({
    required this.noticia,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Text(
        noticia.title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
      ),
    );
  }
}

class _TarjetaTopBar extends StatelessWidget {
  final Article noticia;
  final int index;
  const _TarjetaTopBar({
    required this.noticia,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(children: [
        Text(
          '${index + 1}. ',
          style: TextStyle(color: darkTheme.primaryColorDark),
        ),
        Text('${noticia.source.name}. ')
      ]),
    );
  }
}
