import 'package:flutter/material.dart';

import '../middleware/feedback_layout_config.dart';

class LayoutPageFeedback extends StatefulWidget {
  final FeedbackLayoutConfig config;
  final VoidCallback onPop;
  const LayoutPageFeedback({
    super.key,
    required this.config,
    required this.onPop,
  });

  @override
  State<LayoutPageFeedback> createState() => _LayoutPageFeedbackState();
}

class _LayoutPageFeedbackState extends State<LayoutPageFeedback> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 65, 16, 24),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            widget.config.type.image,
            const SizedBox(
              height: 32.0,
            ),
            Text(
              widget.config.title ?? "Deu erro",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                widget.config.message ?? "Mensagem de erro generica",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Visibility(
                      child: ElevatedButton(
                        child: Text(
                          widget.config.primaryButton?.text ?? "Fechar",
                        ),
                        onPressed: () {
                          widget.config.primaryButton?.action?.call();
                          widget.onPop.call();
                        },
                      ),
                    ),
                    Visibility(
                      visible: widget.config.secondaryButton != null,
                      child: ElevatedButton(
                        child: Text(
                          widget.config.secondaryButton?.text ?? '',
                        ),
                        onPressed: () {
                          widget.config.secondaryButton?.action?.call();
                          widget.onPop.call();
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Visibility(
                      visible: widget.config.flatButton != null,
                      child: TextButton(
                        child: Text(
                          widget.config.flatButton?.text ?? "",
                        ),
                        onPressed: () {
                          widget.config.flatButton?.action?.call();
                          widget.onPop.call();
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
