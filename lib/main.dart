import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const RomanticApology(),
    );
  }
}

class RomanticApology extends StatefulWidget {
  const RomanticApology({super.key});

  @override
  State<RomanticApology> createState() => _RomanticApologyState();
}

class _RomanticApologyState extends State<RomanticApology> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<SlideData> slides = [
    SlideData(
      emoji: '😔',
      title: 'I\'m Sorry Purva...',
      message: 'For treating you badly\nI know I hurt you\nPlease forgive me',
      color1: Color(0xFF6A5ACD),
      color2: Color(0xFF9370DB),
    ),
    SlideData(
      emoji: '💔',
      title: 'I Was Wrong',
      message:
          'Dear Purva,\nI should have been more caring\nMore understanding\nMore patient with you',
      color1: Color(0xFFDC143C),
      color2: Color(0xFFFF69B4),
    ),
    SlideData(
      emoji: '🙏',
      title: 'Please Forgive Me',
      message:
          'Purva, I promise to be better\nTo listen more\nTo appreciate you always',
      color1: Color(0xFF4B0082),
      color2: Color(0xFF8A2BE2),
    ),
    SlideData(
      emoji: '💝',
      title: 'You Mean Everything',
      message: 'Purva, you are my happiness\nMy best friend\nMy everything',
      color1: Color(0xFFFF1493),
      color2: Color(0xFFFF69B4),
    ),
    SlideData(
      emoji: '🌹',
      title: 'I Love You Purva',
      message:
          'More than words can say\nMore than actions can show\nWith all my heart',
      color1: Color(0xFFE91E63),
      color2: Color(0xFFFF6F91),
    ),
    SlideData(
      emoji: '💑',
      title: 'You Complete Me',
      message:
          'Every moment with you is precious\nPurva, you make my world beautiful\nI can\'t imagine life without you',
      color1: Color(0xFFFF4081),
      color2: Color(0xFFFF80AB),
    ),
    SlideData(
      emoji: '✨',
      title: 'My Promise to Purva',
      message:
          'I\'ll cherish you always\nRespect you deeply\nLove you endlessly',
      color1: Color(0xFFBA68C8),
      color2: Color(0xFFCE93D8),
    ),
    SlideData(
      emoji: '❤️',
      title: 'Forever Yours, Purva',
      message:
          'You\'re the one I want\nToday, tomorrow, always\nI love you so much',
      color1: Color(0xFFFF0000),
      color2: Color(0xFFFF6B6B),
    ),
  ];

  void _goToNext() {
    if (_currentPage < slides.length - 1) {
      _pageController.animateToPage(
        _currentPage + 1,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  void _goToPrevious() {
    if (_currentPage > 0) {
      _pageController.animateToPage(
        _currentPage - 1,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: slides.length,
            itemBuilder: (context, index) {
              return SlideWidget(data: slides[index], index: index);
            },
          ),
          // Page indicator
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                slides.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _currentPage == index ? 24 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _currentPage == index
                        ? Colors.white
                        : Colors.white.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: InkWell(
                onTap: _goToPrevious,
                child: Image.asset(
                  "assets/icons/back.png",
                  height: 32,
                  width: 32,
                ),
              ),
            ),
          ),

          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: InkWell(
                onTap: _goToNext,
                child: Image.asset(
                  "assets/icons/next.png",
                  height: 32,
                  width: 32,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SlideData {
  final String emoji;
  final String title;
  final String message;
  final Color color1;
  final Color color2;

  SlideData({
    required this.emoji,
    required this.title,
    required this.message,
    required this.color1,
    required this.color2,
  });
}

class SlideWidget extends StatefulWidget {
  final SlideData data;
  final int index;

  const SlideWidget({Key? key, required this.data, required this.index})
    : super(key: key);

  @override
  State<SlideWidget> createState() => _SlideWidgetState();
}

class _SlideWidgetState extends State<SlideWidget>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _heartController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _heartController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _fadeController, curve: Curves.easeIn));

    _slideAnimation = Tween<double>(
      begin: 50,
      end: 0,
    ).animate(CurvedAnimation(parent: _fadeController, curve: Curves.easeOut));

    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _heartController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [widget.data.color1, widget.data.color2],
        ),
      ),
      child: Stack(
        children: [
          // Floating hearts
          ...List.generate(
            12,
            (i) => FloatingParticle(
              delay: i * 0.4,
              emoji: i % 3 == 0 ? '💕' : (i % 3 == 1 ? '💖' : '✨'),
            ),
          ),
          // Main content
          Center(
            child: AnimatedBuilder(
              animation: _fadeAnimation,
              builder: (context, child) {
                return Opacity(
                  opacity: _fadeAnimation.value,
                  child: Transform.translate(
                    offset: Offset(0, _slideAnimation.value),
                    child: Padding(
                      padding: const EdgeInsets.all(40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Emoji with pulse effect
                          TweenAnimationBuilder(
                            tween: Tween<double>(begin: 0.8, end: 1.1),
                            duration: const Duration(milliseconds: 800),
                            curve: Curves.easeInOut,
                            builder: (context, double scale, child) {
                              return Transform.scale(
                                scale: scale,
                                child: Text(
                                  widget.data.emoji,
                                  style: const TextStyle(fontSize: 100),
                                ),
                              );
                            },
                            onEnd: () {
                              if (mounted) setState(() {});
                            },
                          ),
                          const SizedBox(height: 40),
                          // Title
                          Text(
                            widget.data.title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: "Lobster",
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  blurRadius: 15,
                                  color: Colors.black.withOpacity(0.3),
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 30),
                          // Message
                          Text(
                            widget.data.message,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: "DancingScript",
                              fontSize: 24,
                              height: 1.6,
                              color: Colors.white.withOpacity(0.95),
                              fontWeight: FontWeight.w500,
                              shadows: [
                                Shadow(
                                  blurRadius: 10,
                                  color: Colors.black.withOpacity(0.2),
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class FloatingParticle extends StatefulWidget {
  final double delay;
  final String emoji;

  const FloatingParticle({Key? key, required this.delay, required this.emoji})
    : super(key: key);

  @override
  State<FloatingParticle> createState() => _FloatingParticleState();
}

class _FloatingParticleState extends State<FloatingParticle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late double startX;
  late double curve;

  @override
  void initState() {
    super.initState();
    final random = math.Random();
    startX = random.nextDouble();
    curve = (random.nextDouble() - 0.5) * 0.4;

    _controller = AnimationController(
      duration: Duration(milliseconds: 4000 + random.nextInt(3000)),
      vsync: this,
    );

    _animation = Tween<double>(
      begin: 1.1,
      end: -0.1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));

    Future.delayed(Duration(milliseconds: (widget.delay * 1000).toInt()), () {
      if (mounted) _controller.repeat();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final size = MediaQuery.of(context).size;
        final progress = _animation.value;
        final x = startX + curve * math.sin(progress * math.pi * 2);

        return Positioned(
          left: x * size.width,
          top: progress * size.height,
          child: Opacity(
            opacity: (1 - (progress - 1).abs()).clamp(0.0, 0.7),
            child: Transform.rotate(
              angle: progress * math.pi * 2,
              child: Text(widget.emoji, style: const TextStyle(fontSize: 28)),
            ),
          ),
        );
      },
    );
  }
}
