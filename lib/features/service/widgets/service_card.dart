part of '../screens/service_screen.dart';

class _ServiceCard extends StatelessWidget {
  final ServiceModel service;

  const _ServiceCard({
    required this.service,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Card(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16.r),
                    child: CachedNetworkImage(
                      imageUrl: service.image ?? '',
                      height: 105.h,
                      width: 150.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 5.h,
                    left: 5.w,
                    child: Container(
                      decoration: BoxDecoration(
                        color: context.appTheme.primary,
                        borderRadius: BorderRadius.circular(50.r),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 5.h),
                        child: Center(
                          child: Text(
                            "\$${service.price.toString()}",
                            style: context.appTextStyles.bodyMedium.copyWith(
                              color: context.appTheme.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            16.verticalSpace,
            SizedBox(
              width: 150.w,
              child: Text(
                service.title,
                style: context.appTextStyles.bodyMedium.copyWith(
                  color: context.appTheme.black,
                ),
                maxLines: 2,
              ),
            ),
            16.verticalSpace,
            Center(
              child: Row(
                children: [
                  SvgPicture.asset(
                    AppAssets.star,
                  ),
                  4.horizontalSpace,
                  Text(
                    "(${(service.averageRating ?? 0).toString()})",
                    style: context.appTextStyles.labelSmall.copyWith(
                      color: context.appTheme.warning,
                    ),
                  ),
                  8.horizontalSpace,
                  Container(
                    height: 15.h,
                    width: 1.w,
                    color: context.appTheme.secondaryVariant,
                  ),
                  8.horizontalSpace,
                  SvgPicture.asset(
                    AppAssets.cart,
                  ),
                  4.horizontalSpace,
                  Text(
                    (service.completedSalesCount ?? 0).toString(),
                    style: context.appTextStyles.labelSmall.copyWith(
                      color: context.appTheme.secondary,
                      height: 0,
                    ),
                  ),
                ],
              ),
            ),
            16.verticalSpace,
          ],
        ),
      ),
    );
  }
}
