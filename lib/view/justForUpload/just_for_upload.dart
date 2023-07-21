import 'package:arabic_speaker_child/controller/var.dart';
import 'package:flutter/material.dart';
import 'package:moyasar_payment/model/paymodel.dart';
import 'package:moyasar_payment/moyasar_payment.dart';

class JustForUpload extends StatefulWidget {
  const JustForUpload({super.key});

  @override
  State<JustForUpload> createState() => _JustForUploadState();
}

List images = [
  [
    "assets/justforpay/img1.jpg",
    "Wearable captioning device for hearing impaired people",
    3000
  ],
  [
    "assets/justforpay/img2.jpg",
    "portable deaf elderly digit hearing aid,rechargeable",
    3500
  ],
  ["assets/justforpay/img3.jpg", "categories of disabilities", 4200],
];

class _JustForUploadState extends State<JustForUpload> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: maincolor,
          title: const Text(
            "المنتجات",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: GridView.builder(
            itemCount: 3,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 1 / 1.3),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () async {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Column(children: [
                            const TextField(
                              decoration: InputDecoration(
                                  hintText:
                                      "Enter a valid number to contact you"),
                            ),
                            InkWell(
                                onTap: () async {
                                  PayModel data = await MoyasarPayment().applePay(
                                      amount: double.parse(
                                          images[index][2].toString()),
                                      publishableKey:
                                          "pk_live_5HcCv9pGLqGGttnHj95LrTntgqphFMmn2Fop35dk",
                                      applepayMerchantId:
                                          "merchant.sa.org.tawasal.store",
                                      paymentItems: {
                                        ' ': double.parse(
                                            images[index][2].toString())
                                      },
                                      currencyCode: "SAR",
                                      countryCode: "SA",
                                      description: "تحدث");

                                  if (data.status == 'paid') {}
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Container(
                                    height: 50,
                                    width: 150,
                                    color: maincolor,
                                    child: const Center(
                                        child: Text(
                                      "buy",
                                      style: TextStyle(color: Colors.white),
                                    )),
                                  ),
                                ))
                          ]),
                        );
                      });
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 120,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all()),
                    child: Column(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              images[index][0],
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            images[index][1],
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                        Text(
                          images[index][2].toString() + " SAR",
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }));
  }
}
