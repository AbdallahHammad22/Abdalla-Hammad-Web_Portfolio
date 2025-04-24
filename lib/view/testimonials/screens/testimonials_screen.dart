import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:my_web_app/core/utils/const_data.dart';
import 'package:my_web_app/view/home/widget/profile_care_widget.dart';

class TestimonialsScreen extends StatelessWidget {
  const TestimonialsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('آراء العملاء'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal, Colors.blueGrey],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32),
          child: FadeInUp(
            child: Column(
              children: [
                const Text(
                  'آراء العملاء',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 16),
                Column(
                  children: testimonials
                      .map((testimonial) => TestimonialCard(
                            name: testimonial['name']!,
                            feedback: testimonial['feedback']!,
                            image: testimonial['image']!,
                          ))
                      .toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}