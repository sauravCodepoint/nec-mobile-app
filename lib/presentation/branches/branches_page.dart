import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../application/branches/branches_bloc.dart';
import '../core/app_bar/app_app_bar.dart';
import '../core/app_states/app_state_view.dart';
import '../core/overlay_loading/app_overlay_loading.dart';
import '../core/scaffold/app_scaffold.dart';
import '../core/text_form_field/app_text_form_field.dart';
import 'widgets/branches_item.dart';

@RoutePage()
class BranchesPage extends HookWidget {
  const BranchesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final searchController = useTextEditingController();

    return AppScaffold(
      onTapOutside: () => FocusScope.of(context).unfocus(),
      appBar: AppAppBar(title: 'ourBranches.title'.tr()),
      body: BlocBuilder<BranchesBloc, BranchesState>(
        builder: (context, state) {
          return state.branchesListFailureOrSuccessOption.fold(
            // AppOverlayLoading is a Positioned.fill — it needs a sized Stack
            // ancestor, otherwise it collapses to 0x0 and nothing shows.
                () => const SizedBox.expand(
              child: Stack(children: [AppOverlayLoading()]),
            ),
                (either) => either.fold(
                  (failure) => AppErrorView(
                title: 'ourBranches.loadError'.tr(),
                retryLabel: 'buttons.retry'.tr(),
                onRetry: () => context.read<BranchesBloc>().add(
                  const BranchesEvent.getBranchesList(),
                ),
              ),
                  (success) {
                final branches = success.data?.branchList ?? [];
                if (branches.isEmpty) {
                  return AppEmptyView(
                    icon: Icons.location_city_rounded,
                    title: 'ourBranches.noBranches'.tr(),
                  );
                }

                final query = state.searchQuery.toLowerCase().trim();
                final filtered = query.isEmpty
                    ? branches
                    : branches.where((b) {
                  final name = b.branchName?.toLowerCase() ?? '';
                  final address = [
                    b.address1,
                    b.address2,
                    b.address3,
                  ].whereType<String>().join(' ').toLowerCase();
                  return name.contains(query) || address.contains(query);
                }).toList();

                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 0),
                      child: AppTextFormField(
                        controller: searchController,
                        hintText: 'ourBranches.searchHint'.tr(),
                        prefixIcon: Icon(
                          Icons.search_rounded,
                          size: 20.sp,
                          color: colorScheme.tertiary,
                        ),
                        suffixIcon: state.searchQuery.isNotEmpty
                            ? GestureDetector(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            searchController.clear();
                            context.read<BranchesBloc>().add(
                              const BranchesEvent.searchBranches(''),
                            );
                          },
                          child: Icon(
                            Icons.clear_rounded,
                            size: 20.sp,
                            color: colorScheme.onSurfaceVariant,
                          ),
                        )
                            : null,
                        autocorrect: false,
                        onChanged: (value) => context.read<BranchesBloc>().add(
                          BranchesEvent.searchBranches(value),
                        ),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    SizedBox(
                      height: 2.h,
                      child: state.isSearching
                          ? LinearProgressIndicator(
                        backgroundColor: Colors.transparent,
                        valueColor: AlwaysStoppedAnimation(
                          colorScheme.tertiary,
                        ),
                      )
                          : const SizedBox.shrink(),
                    ),
                    SizedBox(height: 8.h),
                    Expanded(
                      child: filtered.isEmpty
                          ? AppEmptyView(
                        icon: Icons.search_off_rounded,
                        title: 'ourBranches.noBranches'.tr(),
                      )
                          : ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemCount: filtered.length,
                        padding: EdgeInsets.fromLTRB(
                          16.w,
                          4.h,
                          16.w,
                          MediaQuery.paddingOf(context).bottom + 16.h,
                        ),
                        separatorBuilder: (_, _) =>
                            SizedBox(height: 12.h),
                        itemBuilder: (context, index) => BranchesItem(
                          branch: filtered[index],
                          index: index,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
