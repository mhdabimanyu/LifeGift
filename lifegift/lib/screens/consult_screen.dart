import 'dart:async';

import 'package:flutter/material.dart';

import '../data/dummy_data.dart';
import '../data/models.dart';
import '../theme/app_theme.dart';
import '../theme/responsive.dart';

/// LAYAR 09 - Konsultasi Medis Online (slide 18).
///
/// [Ketentuan 1] Scaffold + AppBar + body + (input di bawah).
/// [Ketentuan 3] CircleAvatar (foto dokter via Image/AssetImage), RichText
///               (status online), Text, Icon.
/// [Ketentuan 5] Align, Container, Padding, SizedBox, ConstrainedBox.
/// [Ketentuan 6] ListView.builder, Column, Row, Expanded.
/// [Ketentuan 7] Lebar bubble chat dibatasi (maks 75% / 420 dp) dengan
///               constraint; area chat dipusatkan pada layar lebar.
class ConsultScreen extends StatefulWidget {
  const ConsultScreen({super.key});

  @override
  State<ConsultScreen> createState() => _ConsultScreenState();
}

class _ConsultScreenState extends State<ConsultScreen> {
  final TextEditingController _inputCtrl = TextEditingController();
  final ScrollController _scrollCtrl = ScrollController();
  late List<ChatMessage> _messages;
  Doctor _doctor = DummyData.doctors.first;
  Timer? _replyTimer;

  @override
  void initState() {
    super.initState();
    _messages = List<ChatMessage>.of(DummyData.initialChat);
  }

  @override
  void dispose() {
    _replyTimer?.cancel();
    _inputCtrl.dispose();
    _scrollCtrl.dispose();
    super.dispose();
  }

  void _scrollToEnd() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollCtrl.hasClients) return;
      _scrollCtrl.animateTo(
        _scrollCtrl.position.maxScrollExtent,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    });
  }

  void _send() {
    final String value = _inputCtrl.text.trim();
    if (value.isEmpty) return;
    setState(() => _messages.add(ChatMessage(text: value, fromUser: true)));
    _inputCtrl.clear();
    _scrollToEnd();

    // Balasan otomatis (simulasi chat real-time).
    _replyTimer?.cancel();
    _replyTimer = Timer(const Duration(milliseconds: 900), () {
      if (!mounted) return;
      setState(
        () => _messages.add(
          ChatMessage(
            text: _doctor.online
                ? 'Terima kasih, pesan Anda sudah kami terima. '
                      'Silakan jelaskan keluhan atau kondisi Anda lebih lanjut.'
                : 'Dokter sedang offline. Pesan Anda akan dibalas saat dokter online.',
            fromUser: false,
          ),
        ),
      );
      _scrollToEnd();
    });
  }

  void _pickDoctor() {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (ctx) => SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                Spacing.md,
                0,
                Spacing.md,
                Spacing.sm,
              ),
              child: Text(
                'Pilih dokter',
                style: Theme.of(ctx).textTheme.titleLarge,
              ),
            ),
            for (final Doctor d in DummyData.doctors)
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage(d.avatarAsset),
                ),
                title: Text(d.name),
                subtitle: _StatusText(doctor: d),
                selected: d.name == _doctor.name,
                onTap: () {
                  Navigator.of(ctx).pop();
                  setState(() {
                    _doctor = d;
                    _messages = [
                      ChatMessage(
                        text: 'Halo, saya ${d.name}. Ada yang bisa saya bantu?',
                        fromUser: false,
                      ),
                    ];
                  });
                },
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: Colors.white,
              backgroundImage: AssetImage(_doctor.avatarAsset),
            ),
            const SizedBox(width: Spacing.sm + 4),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _doctor.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: text.titleMedium?.copyWith(color: Colors.white),
                  ),
                  _StatusText(doctor: _doctor, onDark: true),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Daftar dokter',
            icon: const Icon(Icons.groups_outlined),
            onPressed: _pickDoctor,
          ),
        ],
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  controller: _scrollCtrl,
                  padding: const EdgeInsets.all(Spacing.md),
                  itemCount: _messages.length,
                  itemBuilder: (context, i) => _Bubble(message: _messages[i]),
                ),
              ),
              _InputBar(controller: _inputCtrl, onSend: _send),
            ],
          ),
        ),
      ),
    );
  }
}

/// Status dokter dengan RichText: titik berwarna + teks.
class _StatusText extends StatelessWidget {
  const _StatusText({required this.doctor, this.onDark = false});

  final Doctor doctor;
  final bool onDark;

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;
    final Color base = onDark ? AppColors.roseBorder : AppColors.slate;
    final Color dot = doctor.online
        ? (onDark ? const Color(0xFF86EFAC) : AppColors.success)
        : AppColors.rosePale;
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        style: text.bodyMedium?.copyWith(color: base, fontSize: 12),
        children: [
          TextSpan(
            text: '\u25CF ',
            style: TextStyle(color: dot),
          ),
          TextSpan(text: doctor.online ? 'Online' : 'Offline'),
          TextSpan(text: ' \u00B7 ${doctor.specialty}'),
        ],
      ),
    );
  }
}

class _Bubble extends StatelessWidget {
  const _Bubble({required this.message});

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    final bool mine = message.fromUser;
    final TextTheme text = Theme.of(context).textTheme;
    return Align(
      alignment: mine ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: (MediaQuery.sizeOf(context).width * 0.75)
              .clamp(0.0, 420.0)
              .toDouble(),
        ),
        child: Container(
          margin: const EdgeInsets.only(bottom: Spacing.sm + 2),
          padding: const EdgeInsets.symmetric(
            horizontal: Spacing.md,
            vertical: Spacing.sm + 4,
          ),
          decoration: BoxDecoration(
            color: mine ? AppColors.rose : Colors.white,
            border: mine ? null : Border.all(color: AppColors.line),
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(Radii.lg),
              topRight: const Radius.circular(Radii.lg),
              bottomLeft: Radius.circular(mine ? Radii.lg : Spacing.xs),
              bottomRight: Radius.circular(mine ? Spacing.xs : Radii.lg),
            ),
          ),
          child: Text(
            message.text,
            style: text.bodyLarge?.copyWith(
              color: mine ? Colors.white : AppColors.ink,
            ),
          ),
        ),
      ),
    );
  }
}

class _InputBar extends StatelessWidget {
  const _InputBar({required this.controller, required this.onSend});

  final TextEditingController controller;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.canvas,
      padding: const EdgeInsets.fromLTRB(
        Spacing.md,
        Spacing.sm,
        Spacing.md,
        Spacing.md,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              textInputAction: TextInputAction.send,
              onSubmitted: (_) => onSend(),
              decoration: InputDecoration(
                hintText: 'Tulis pesan...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Radii.xl + 8),
                  borderSide: const BorderSide(color: AppColors.line),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Radii.xl + 8),
                  borderSide: const BorderSide(color: AppColors.line),
                ),
              ),
            ),
          ),
          const SizedBox(width: Spacing.sm),
          IconButton.filled(
            tooltip: 'Kirim',
            onPressed: onSend,
            icon: const Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}
