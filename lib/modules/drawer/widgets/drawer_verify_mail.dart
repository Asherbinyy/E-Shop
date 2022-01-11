
part of 'widgets_custom_drawer_imports.dart';


class DrawerVerifyMail extends StatelessWidget {
  final GestureTapCallback? onTap;
  const DrawerVerifyMail({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        color: Colors.amber.withOpacity(0.1),
        child: InkWell(
            child: ListTile(
              onTap: onTap,
              contentPadding: EdgeInsets.zero,
              leading: const Icon(
                Icons.info,
                color: Colors.amber,
              ),
              title: Text(
                'verify_email'.tr(),
                style: const TextStyle(color: Colors.amber),
              ),
            )),
      ),
    );
  }
}
