part of 'widgets_custom_drawer_imports.dart';

class DrawerViewProfileWidget extends StatelessWidget {
  const DrawerViewProfileWidget({
    Key? key,
    required this.profile,
  }) : super(key: key);

  final ProfileData? profile;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        navigateTo(context, const ProfileScreen());
      },
      child: Row(
        children: [
          Hero(
            tag: ValueKey<String>('${profile?.id}'),
            child: CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage('${profile?.image}'),
            ),
          ),
          XSpace.normal,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${profile?.name?.toUpperCase()}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(fontSize: 14),
                ),
                Text(
                  'view_your_account'.tr(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .caption!
                      .copyWith(fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}