import 'package:flutter/material.dart';

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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

              // Color selection section
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

              // Category selection for Description, Reviews, Inquiries
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

              // Product Description Section
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

              // Inquiries Section
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
                  controller: titleController, // Ensure this is the correct controller for the title
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
                    labelText: '문의할 내용을 입력해주세요.',
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
                  'assets/add_img.png', // Add your image here
                  width: 70,
                  height: 70,
                  color: Colors.grey,
                ),
                const SizedBox(height: 30),

                // 등록 버튼
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

                    // 오류 메시지가 있을 경우 SnackBar로 표시
                    if (errorMessage != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(errorMessage)),
                      );
                    } else {
                      // 등록 버튼 클릭 시 처리할 내용 추가
                      // 예를 들어, 입력된 내용을 서버에 전송하는 등의 작업
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey, // Set the button color to grey
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Rounded corners with a radius of 10
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20), // Padding of 5 pixels
                  ),
                  child: const Text(
                    '등록',
                    style: TextStyle(
                      color: Colors.white, // Set the text color to white
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
              // Reviews Section
              if (showReviews) ...[
                const SizedBox(height: 10),
                const Text('리뷰', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
                          color: Color(0xFFE0E0E0), // 선 색상
                          thickness: 0.5,          // 선 두께
                          indent: 16.0,            // 좌측 여백
                          endIndent: 16.0,         // 우측 여백
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
                  child: const Text(
                    '리뷰 더보기',
                    style: TextStyle(
                      color: Colors.green, // Set text color to green
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
