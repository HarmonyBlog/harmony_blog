import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:harmony_blog/provider/appStateProvider.dart';

class NewPostView extends StatelessWidget {
  const NewPostView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ApplicationState>(
      builder: (context, appState, _) => appState.isCreateLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              child: Column(
                children: <Widget>[
                  AppBar(
                    leading: IconButton(
                      icon: const Icon(Icons.chevron_left),
                      tooltip: 'Show Snackbar',
                      onPressed: () {
                        appState.sethomeTabIndex(0);
                      },
                    ),
                    title: const Text("New Post"),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                      onTap: () {
                        appState.getImage();
                      },
                      child: appState.selectedImage != null
                          ? Container(
                              margin: EdgeInsets.symmetric(horizontal: 16),
                              height: 170,
                              width: MediaQuery.of(context).size.width,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: Image.file(
                                  appState.selectedImage!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          : Container(
                              margin: EdgeInsets.symmetric(horizontal: 16),
                              height: 170,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6)),
                              width: MediaQuery.of(context).size.width,
                              child: Icon(
                                Icons.add_a_photo,
                                color: Colors.black45,
                              ),
                            )),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: <Widget>[
                        TextField(
                          decoration: InputDecoration(hintText: "Title"),
                          onChanged: (val) {
                            appState.title = val;
                          },
                        ),
                        TextField(
                          decoration: InputDecoration(hintText: "Desc"),
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          onChanged: (val) {
                            appState.desc = val;
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20.0),
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Color(0xff009999)),
                                padding: MaterialStateProperty.all(
                                    EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 25)),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)))),
                            child: Text('Post The Blog'),
                            onPressed: () => {appState.uploadBlog()},
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
