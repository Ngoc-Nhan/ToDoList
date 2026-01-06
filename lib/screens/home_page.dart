import 'package:flutter/material.dart';
import 'forget_pw_page.dart';

class Noti {
  final String image;
  final String title;
  final String description;
  Noti({
    required this.image,
    required this.title,
    required this.description,
  });
}

final List<Noti> noti = [
  Noti(
      image: 'assets/images/one.png',
      title: 'Easy Time Management',
      description:
          'With managemnt based on priority and dailt task, it will give you convenience in managing and determining the tasks that must be done first'),
  Noti(
      image: 'assets/images/two.png',
      title: 'Inscrease Work Effectiveness',
      description:
          'Time management and the dterminantion of more important tasks will give your job statistics better and always improve '),
  Noti(
      image: 'assets/images/three.png',
      title: 'Reminder Notification',
      description:
          'The advantage of this application is that it also provides reminderes for you so you don\'nt forget to keep doingyour assignments well and according to the time you have set'),
];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  int currentIndex = 0;
  final int totalPage = 3;

  void nextPage() {
    if (currentIndex < totalPage - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => ForgetPwPage()),
      );
    }
  }

  void skipToLast() {
    _pageController.animateToPage(
      totalPage - 1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void prevPage() {
    if (currentIndex > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Widget buildNotiItem(Noti item) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          item.image,
          height: 220,
          fit: BoxFit.contain,
        ),
        const SizedBox(height: 32),
        Text(
          item.title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          item.description,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15,
            color: Colors.grey.shade600,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // const SizedBox(height: 10),

              // ===== DOT + SKIP =====
              Row(
                children: [
                  // DOT
                  Row(
                    children: List.generate(totalPage, (index) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.only(right: 6),
                        width: currentIndex == index ? 14 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color:
                              currentIndex == index ? Colors.blue : Colors.grey,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      );
                    }),
                  ),

                  const Spacer(),

                  // SKIP
                  TextButton(
                    onPressed: skipToLast,
                    child: const Text('Skip'),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // ===== PAGE VIEW =====
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (index) {
                    setState(() => currentIndex = index);
                  },
                  children: noti.map((item) {
                    return buildNotiItem(item);
                  }).toList(),
                ),
              ),

              const SizedBox(height: 20),

              // ===== NEXT BUTTON =====
              Row(
                children: [
                  // 🔙 Back icon (chỉ hiện từ trang 2)
                  if (currentIndex > 0)
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: prevPage,
                      ),
                    ),

                  // 👉 khoảng cách giữa back và nút chính
                  if (currentIndex > 0) const SizedBox(width: 12),

                  // ▶️ Nút chính
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        minimumSize: const Size.fromHeight(48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: nextPage,
                      child: Text(
                        currentIndex == totalPage - 1 ? 'Get Started' : 'Next',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
