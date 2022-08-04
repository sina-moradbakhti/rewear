import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rewear/generals/widgets/hr.widget.dart';

class TailoryMapItem extends StatelessWidget {
  VoidCallback? onTapped;
  TailoryMapItem({Key? key, this.onTapped}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300, width: 0.5),
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.all(5),
      clipBehavior: Clip.none,
      child: MaterialButton(
        padding: EdgeInsets.zero,
        onPressed: onTapped,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: SizedBox(
                        width: 100,
                        height: 100,
                        child: Image.network(
                          'https://pr1.nicelocal.ca/qpMl5En9i9Z8BBUeOIpcjw/587x440,q85/4px-BW84_n0QJGVPszge3NRBsKw-2VcOifrJIjPYFYkOtaCZxxXQ2QYGKPyr9phEd2hf2KdrWWhmco4x-UwPq9Z05LRz1uf85kBf0Qhk-gVUWUuWK--t5Q',
                          fit: BoxFit.cover,
                        ))),
              ),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      child: Text(
                        'Lynn — Tailor',
                        style: Get.theme.textTheme.headline6!.copyWith(
                            fontWeight: FontWeight.w500,
                            overflow: TextOverflow.fade),
                      ),
                      height: 35),
                  SizedBox(
                    child: Text(
                      'Montreal, Quebec H2A 1H6, 3257 Rue Michel-Ange',
                      style: Get.theme.textTheme.bodyText2!.copyWith(
                        overflow: TextOverflow.fade,
                      ),
                    ),
                    height: 40,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Hr(),
                  ),
                  Row(
                    children: [
                      Icon(Icons.star, size: 16, color: Colors.yellow.shade700),
                      Icon(Icons.star, size: 16, color: Colors.yellow.shade700),
                      Icon(Icons.star, size: 16, color: Colors.yellow.shade700),
                      Icon(Icons.star, size: 16, color: Colors.yellow.shade700),
                      Icon(Icons.star, size: 16, color: Colors.grey.shade400),
                    ],
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
