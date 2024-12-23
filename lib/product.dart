// 상품 페이지 (UI완)

import 'package:flutter/material.dart';
import 'product_review.dart';
import 'ProductService.dart';
import 'productData.dart';

class ProductDetailPage extends StatefulWidget {
  final Map<String, String> product;

  const ProductDetailPage({Key? key, required this.product}) : super(key: key);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  bool isLiked = false;
  int likeCount = 0;
  bool showAllReviews = false;
  bool showDescription = true;
  bool showReviews = false;
  bool showInquiries = false;
  String selectedInquiryType = '배송';
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  // Sample reviews
  final List<Map<String, dynamic>> reviews = [
    {
      "user": "사용자 1", 
      "content": "훌륭한 제품입니다! 품질과 디자인이 정말 마음에 들어요.",
      "rating": 4
    },
    {
      "user": "사용자 2",
      "content": "가격 대비 좋은 가치입니다. 다른 사람에게 추천할 것입니다!",
      "rating": 5
    },
    {
      "user": "사용자 3",
      "content": "괜찮은 품질이지만 색상이 사진과 약간 다릅니다.",
      "rating": 3
    },
    {
      "user": "사용자 4",
      "content": "배송이 빠르고 서비스가 좋았습니다. 매우 만족합니다!",
      "rating": 5
    }
  ];

  @override
  void initState() {
    super.initState();
    likeCount = int.parse(widget.product['likes'] ?? '0');
    isLiked = (widget.product['selected'] == 'true');
  }

  Future<void> _toggleLike() async {
    try {
      final updatedProduct = Products(
        id: widget.product['id']!,
        name: widget.product['name']!,
        price: int.parse(widget.product['price']!), 
        image: widget.product['image']!,
        
        likes: isLiked ? likeCount - 1 : likeCount + 1,
        selected: !isLiked,
        manufacturer: widget.product['manufacturer']!,
        description: widget.product['description']!,
      );

      String productType = '';
      if (updatedProduct.image.contains('chair')) {
        productType = 'chairs';
      } else if (updatedProduct.image.contains('sofa')) {
        productType = 'sofas';
      } else if (updatedProduct.image.contains('desk')) {
        productType = 'desks';
      } else if (updatedProduct.image.contains('bed')) {
        productType = 'beds';
      } else if (updatedProduct.image.contains('table')) {
        productType = 'tables';
      }

      await ProductService.updateProduct(updatedProduct, productType);
      await ProductService.refreshProducts();

      setState(() {
        if (isLiked) {
          likeCount--;
        } else {
          likeCount++;
        }
        isLiked = !isLiked;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(isLiked ? '좋아요 추가됨' : '좋아요 취소됨'),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 1),
        ),
      );
    } catch (e) {
      print('Error updating like: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('좋아요 업데이트 실패'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  double get averageRating {
    if (reviews.isEmpty) return 0.0; // Handle case with no reviews
    double totalRating = reviews.fold(0.0, (sum, review) => sum + review['rating']);
    return totalRating / reviews.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () async {
            await ProductService.refreshProducts();
            Navigator.pop(context);
          },
        ),
        title: Text(
          widget.product['name']!,
          style: const TextStyle(fontSize: 18),
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
              // 상품 이미지
              Center(
                child: Image.asset(
                  widget.product['image']!,
                  width: 250,
                  height: 250,
                ),
              ),
              const SizedBox(height: 20),
              // 화살표 아이콘
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
              // 상품 기본 정보
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 가격 표시
                  Text(
                    widget.product['price']!,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  // 좋아요
                  GestureDetector(
                    onTap: _toggleLike,
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
              // 상품 이름과 제조사
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

              // 색깔
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
              const SizedBox(height: 30),

              // 카테고리
              Container(
                color: const Color(0xFFF5F5F5),
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildCategoryButton('상품 정보', () {
                      setState(() {
                        showDescription = true;
                        showReviews = false;
                        showInquiries = false;
                      });
                    }, showDescription),
                    _buildCategoryButton('리뷰', () {
                      setState(() {
                        showReviews = true;
                        showDescription = false;
                        showInquiries = false;
                      });
                    }, showReviews),
                    _buildCategoryButton('문의', () {
                      setState(() {
                        showInquiries = true;
                        showDescription = false;
                        showReviews = false;
                      });
                    }, showInquiries),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // 상품 정보
              if (showDescription) ...[
                const SizedBox(height: 10),
                const Text('상품 정보', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Text('상품 번호: ${widget.product['id']}', style: const TextStyle(fontSize: 16, color: Colors.grey)),
                const SizedBox(height: 10),
                Text('상품 설명: ${widget.product['description']}', style: const TextStyle(fontSize: 16, color: Colors.grey)),
                const SizedBox(height: 40),
                Image.asset('assets/adv_other.png'),
              ],

              // 문의 유형
              if (showInquiries) ...[
                const SizedBox(height: 10),
                const Text('문의', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 30),

                // 문의 유형 선택
                const Text(
                  '문의 유형 (필수)',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                DropdownButton<String>(
                  value: selectedInquiryType,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedInquiryType = newValue!;
                    });
                  },
                  items: <String>['배송', '재입고', '상품상세문의', '기타']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),

                // 제목 입력
                const Text(
                  '제목 (필수)',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                TextField(
                  controller: titleController,
                  maxLines: 1,
                  decoration: InputDecoration(
                    labelText: '30자 내로 입력해주세요.',
                    labelStyle: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // 내용 입력
                const Text(
                  '내용 (필수)',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                TextField(
                  controller: contentController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    labelText: '문의할 내용을 입력해주세��.',
                    labelStyle: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // 사진 추가
                const Text(
                  '사진 추가',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Image.asset(
                  'assets/add_img.png', 
                  width: 70,
                  height: 70,
                  color: Colors.grey,
                ),
                const SizedBox(height: 30),

                // ��록 버튼
                ElevatedButton(
                  onPressed: () {
                    String title = titleController.text.trim();
                    String content = contentController.text.trim();

                    // 오류 메시지 변수
                    String? errorMessage;

                    // 제목과 내용 검증
                    if (title.isEmpty) {
                      errorMessage = '제목을 입력해주세요.';
                    } else if (title.length > 30) {
                      errorMessage = '제목은 30자 이내로 입력해주세요.';
                    } else if (content.isEmpty) {
                      errorMessage = '내용을 입력해주세요.';
                    }

                    // SnackBar 표시
                    if (errorMessage != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(errorMessage)),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('문의가 접수되었습니다. ')),
                      );
                    }
                  },
                  // 버튼
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey, 
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), 
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20), 
                  ),
                  child: const Text(
                    '등록',
                    style: TextStyle(
                      color: Colors.white, 
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],


              // 리뷰
              if (showReviews) ...[
                const SizedBox(height: 10),
                const Text('리뷰', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
              // 평균
              Row(
              children: [
                ...List.generate(5, (index) {
                  return Icon(
                    Icons.star,
                    color: index < averageRating ? Colors.amber : Colors.grey,
                    size: 25,
                  );
                }),
                const SizedBox(width: 8), 
                Text(
                  '${averageRating.toStringAsFixed(1)}',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Divider(
              color: Color(0xFFE0E0E0),  
              thickness: 1.2,        
              indent: 0.0,           
              endIndent: 0.0,        
            ),
            const SizedBox(height: 20),
            // 리뷰 내용
                Column(
                  children: List.generate(
                    showAllReviews ? reviews.length : 2,
                    (index) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Column(
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
                                    const SizedBox(height: 3),
                                    Row(
                                      children: List.generate(5, (starIndex) {
                                        return Icon(
                                          Icons.star,
                                          color: starIndex < reviews[index]['rating'] ? Colors.amber : Colors.grey,
                                          size: 16,
                                        );
                                      }),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      reviews[index]['content']!,
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        const SizedBox(height: 20),
                        const Divider(
                          color: Color(0xFFE0E0E0),
                          thickness: 0.5,         
                          indent: 16.0,           
                          endIndent: 16.0,         
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // 리��� 더보기
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
                  child: const Text(
                    '리뷰 더보기',
                    style: TextStyle(
                      color: Colors.green, 
                    ),
                  ),
                ),
              const SizedBox(height: 20),
            ],
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }


  Widget _buildCategoryButton(String title, VoidCallback onTap, bool isSelected) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            color: isSelected ? Colors.green : Colors.black,
          ),
        ),
      ),
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
                  '구매하기',
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