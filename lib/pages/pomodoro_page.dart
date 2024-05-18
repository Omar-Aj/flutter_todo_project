import 'package:flutter/material.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'package:flutter_todo_project/components/app_bar.dart';

enum DurationType { pomodoroDuration, breakDuration }

class PomodoroPage extends StatefulWidget {
  const PomodoroPage({super.key});

  @override
  State<PomodoroPage> createState() => _PomodoroPageState();
}

class _PomodoroPageState extends State<PomodoroPage> {
  final timerController = CountdownController();

  bool isRunning = false;
  bool isPaused = false;
  DurationType durationType = DurationType.pomodoroDuration;
  int durationsInSecond = 1500;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: appBar(colorScheme, "Pomodoro"),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            currentDurationType(),
            countDownWidget(context),
            const SizedBox(
              height: 48,
            ),
            timerControl(),
            const Spacer(),
            FilledButton(
              onPressed: isRunning
                  ? null
                  : () {
                      setState(() {
                        durationType =
                            (durationType == DurationType.pomodoroDuration)
                                ? DurationType.breakDuration
                                : DurationType.pomodoroDuration;
                      });
                    },
              child: Text(durationType == DurationType.pomodoroDuration
                  ? "Break"
                  : "Pomodoro"),
            ),
          ],
        ),
      ),
    );
  }

  Row timerControl() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        OutlinedButton(
          onPressed: isRunning ? resetTimer : startTimer,
          child: Text(isRunning ? "Reset" : "Start"),
        ),
        Visibility(
          visible: isRunning,
          child: Row(
            children: [
              const SizedBox(
                width: 24,
              ),
              OutlinedButton(
                onPressed: isRunning && isPaused ? resumeTimer : pauseTimer,
                child: Text(isRunning && isPaused ? "Resume" : "Pause"),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Text currentDurationType() {
    return Text(
      durationType == DurationType.pomodoroDuration ? "Pomodoro" : "Break",
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 36, fontWeight: FontWeight.w500),
    );
  }

  Countdown countDownWidget(BuildContext context) {
    return Countdown(
      controller: timerController,
      seconds: durationType == DurationType.pomodoroDuration ? 1500 : 300,
      build: (_, double time) {
        String minutes = (time ~/ 60).toString();
        String seconds = (time % 60).toString();
        if (minutes.length == 1) {
          minutes = '0$minutes';
        }
        if (seconds.length == 1) {
          seconds = '0$seconds';
        }
        return Text(
          "$minutes:$seconds",
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 96, fontWeight: FontWeight.bold),
        );
      },
      onFinished: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Congratulations! you have completed a ${durationType == DurationType.pomodoroDuration ? "Pomodoro" : "Break"}'),
          ),
        );
        setState(() {
          isRunning = false;
          isPaused = false;
          durationType = DurationType.pomodoroDuration;
        });
      },
    );
  }

  void startTimer() {
    timerController.start();
    setState(() {
      isRunning = true;
    });
  }

  void pauseTimer() {
    timerController.pause();
    setState(() {
      isPaused = true;
    });
  }

  void resumeTimer() {
    timerController.resume();
    setState(() {
      isPaused = false;
    });
  }

  void resetTimer() {
    timerController.restart();
    timerController.pause();
    setState(() {
      isRunning = false;
      isPaused = false;
    });
  }
}
