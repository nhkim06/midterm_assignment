class ProductDetailPage extends StatefulWidget {
  final Map<String, String> product;

  const ProductDetailPage({Key? key, required this.product}) : super(key: key);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  bool isLiked = false;
  int likeCount = 41;
  bool showAllReviews = false; // Toggle to show all reviews

  // Sample reviews
  final List<Map<String, dynamic>> reviews = [
    {
      'user': 'User1',
      'content': 'Great product! Really loved the quality and design.',
      'rating': 4,
    },
    {
      'user': 'User2',
      'content': 'Good value for money. Would recommend it to others!',
      'rating': 5,
    },
    {
      'user': 'User3',
      'content': 'Decent quality, but the color is slightly different from the picture.',
      'rating': 3,
    },
  ];

  double get averageRating {
    if (reviews.isEmpty) return 0.0; // Handle case with no reviews
    double totalRating = reviews.fold(0.0, (sum, review) => sum + review['rating']);
    return totalRating / reviews.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.product['name']!,
          style: const TextStyle(fontSize: 24),
        ),
        backgroundColor: Colors.white,
        titleTextStyle: const TextStyle(color: Colors.black),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  widget.product['image']!,
                  width: 250,
                  height: 250,
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: ColorFiltered(
                  colorFilter: const ColorFilter.mode(
                    Colors.grey,
                    BlendMode.srcIn,
                  ),
                  child: Image.asset(
                    'assets/turn.png',
                    width: 50,
                    height: 50,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Divider(thickness: 0.5, color: Colors.grey),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.product['price']!,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isLiked) {
                          likeCount--;
                        } else {
                          likeCount++;
                        }
                        isLiked = !isLiked;

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(isLiked ? '좋아요 추가됨' : '좋아요 취소됨'),
                            behavior: SnackBarBehavior.floating,
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      });
                    },
                    child: Row(
                      children: [
                        ColorFiltered(
                          colorFilter: ColorFilter.mode(
                            isLiked ? Colors.red : Colors.grey.withOpacity(0.5),
                            BlendMode.srcIn,
                          ),
                          child: Image.asset(
                            'assets/heart.png',
                            width: 24,
                            height: 24,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text('$likeCount'),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                widget.product['name']!,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                widget.product['manufacturer']!,
                style: const TextStyle(fontSize: 18, color: Colors.grey),
              ),
              const SizedBox(height: 30),
              const Text(
                '색깔',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _buildColorCircle(Colors.black),
                  const SizedBox(width: 16),
                  _buildColorCircle(Colors.white),
                  const SizedBox(width: 16),
                  _buildColorCircle(Colors.green),
                  const SizedBox(width: 16),
                  _buildColorCircle(Colors.blue),
                ],
              ),
              const SizedBox(height: 45),

              // 리뷰
              const Text(
                '리뷰',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              // Average Rating Section
              Row(
              children: [
                ...List.generate(5, (index) {
                  return Icon(
                    Icons.star,
                    color: index < averageRating ? Colors.amber : Colors.grey,
                    size: 25,
                  );
                }),
                const SizedBox(width: 8), // Adds spacing between stars and the text
                Text(
                  '${averageRating.toStringAsFixed(1)}', // Display average rating text
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Divider(
              color: Color(0xFFE0E0E0),     // 선 색상
              thickness: 1.2,         // 선 두께
              indent: 0.0,           // 좌측 여백
              endIndent: 0.0,        // 우측 여백
            ),
            const SizedBox(height: 20),
            
              // Review Section
              Column(
                children: List.generate(
                  showAllReviews ? reviews.length : 2,
                  (index) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Column( // Changed from Row to Column to accommodate the Divider
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              'assets/user.png',
                              width: 24,
                              height: 24,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    reviews[index]['user']!,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: List.generate(5, (starIndex) {
                                      return Icon(
                                        Icons.star,
                                        color: starIndex < reviews[index]['rating'] ? Colors.amber : Colors.grey,
                                        size: 16,
                                      );
                                    }),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    reviews[index]['content']!,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                          const SizedBox(height: 20),
                          const Divider(
                            color: Color(0xFFE0E0E0),     // 선 색상
                            thickness: 0.5,         // 선 두께
                            indent: 16.0,           // 좌측 여백
                            endIndent: 16.0,        // 우측 여백
                          ),
                          
                      ],
                    ),
                  ),
                ),
              ),
              if (reviews.length > 2)
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReviewPage(reviews: reviews),
                      ),
                    );
                  },
                  child: const Text('리뷰 더보기'),
                ),
              const SizedBox(height: 20),
              
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildColorCircle(Color color) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey, width: 1),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Colors.grey.withOpacity(0.3),
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                onPressed: () {
                  // Cart action
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  side: const BorderSide(color: Colors.green, width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 20),
                ),
                child: const Text(
                  '장바구니',
                  style: TextStyle(color: Colors.green, fontSize: 18),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                onPressed: () {
                  // Buy action
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 20),
                ),
                child: const Text(
                  '바로 구매',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}