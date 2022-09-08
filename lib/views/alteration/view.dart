import 'package:flutter/material.dart';
import 'package:rewear/blocs/service.bloc.dart';
import 'package:rewear/config/app_init.dart';
import 'package:rewear/generals/buttons.dart';
import 'package:rewear/generals/colors.dart';
import 'package:rewear/generals/constants.dart';
import 'package:rewear/generals/datefield.dart';
import 'package:rewear/generals/dropdowns.dart';
import 'package:rewear/generals/iconly_font_icons.dart';
import 'package:rewear/generals/strings.dart';
import 'package:rewear/generals/textfields.dart';
import 'package:rewear/generals/widgets/audioPlayer.widget.dart';
import 'package:rewear/generals/widgets/break.widget.dart';
import 'package:rewear/generals/widgets/colorSelector.widget.dart';
import 'package:rewear/generals/widgets/customAppbar.widget.dart';
import 'package:get/get.dart';
import 'package:rewear/generals/widgets/loading.widget.dart';
import 'package:rewear/generals/widgets/neckStyleSelector.widget.dart';
import 'package:rewear/generals/widgets/uploadBox.widget.dart';

class Alteration extends StatelessWidget {
  Alteration({Key? key}) : super(key: key);

  final bloc = Get.put(ServiceBloc(serviceType: 'Alteration'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
          centerTitle: false,
          main: false,
          title: Text(
            MyStrings.alteration_title,
            style: Get.theme.textTheme.headline6,
          )),
      body: ListView(
        padding:
            EdgeInsets.symmetric(vertical: MyConstants.primaryPadding.top / 2),
        children: [
          NeckStyleSelector(onSelected: bloc.updateNeckStyle),
          BreakWidget(),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MyConstants.primaryPadding.left),
            child: Obx(
              () => Column(
                children: [
                  MyDropdown(
                      title: 'Material Clothing',
                      hint: 'Select item',
                      current: bloc.selectedMaterial.value,
                      items: AppInit().materials,
                      onSelected: (material) {
                        bloc.selectedMaterial.value = material;
                      }),
                  BreakWidget(size: 5),
                  MyCustomfield(
                      icon: IconlyFont.calendar,
                      title: 'Date',
                      hint: 'Choose date',
                      current: bloc.currentDateToStr(),
                      onTapped: bloc.chooseDate),
                  BreakWidget(size: 5),
                  // Obx(() => MyCustomfield(
                  //       backgroundColor: bloc.isRecordingVoice.value
                  //           ? MyColors.lightOrange
                  //           : MyColors.lightGrey,
                  //       icon: IconlyFont.voice,
                  //       title: 'Voice writing (Optional)',
                  //       hint: bloc.isRecordingVoice.value
                  //           ? 'Recording... (Tap to stop recording)'
                  //           : 'Long tap here to record voice',
                  //       onTapped: bloc.isRecordingVoice.value
                  //           ? bloc.stopVoiceRecording
                  //           : null,
                  //       onLongTapped: !bloc.isRecordingVoice.value
                  //           ? bloc.startRecordVoice
                  //           : null,
                  //     )),
                  // Obx(() => bloc.recordedAudioPath.value != ''
                  //     ? AudioPlayerWidget(
                  //         audioPath: bloc.recordedAudioPath.value,
                  //         onTappedDelete: bloc.removeRecordedVoice)
                  //     : Container()),
                  // BreakWidget(size: 20),
                  ColorSelectorWidget(
                      selectedColor: Colors.green,
                      onChanged: bloc.changedColor),
                  BreakWidget(size: 5),
                  MyTextfield(
                    onChanges: (newVal) => bloc.description.value = newVal,
                    title: 'Details',
                    hint: 'Details',
                    isMultiline: true,
                    minLines: 4,
                    maxLines: 8,
                  ),
                  BreakWidget(size: 5),
                  UploadBoxWidget(onUpdatedPhotoList: bloc.updatePhotoList),
                  BreakWidget(size: 30),
                  Obx(() => bloc.creatingAnOrderLoading.value
                      ? const Center(child: MyLoading())
                      : MyPrimaryButton(
                          onPressed: bloc.next, title: 'Choose Tailor')),
                  BreakWidget(size: 100),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
