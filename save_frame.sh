#!/bin/bash

# Copyright 2023 Nobuki HIRAMINE
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# save_frame.sh
# Webカメラからの画像の保存
# Arguments
#   $1 : Resolution : Optional. Default is "640x480".
#   $2 : Image format : Optional. Default is "YUYV".
#   $3 : Image file output directory : Optional. Default is "image_output".

# save_frame.sh
# Webカメラからの画像の保存

# 解像度
readonly RESOLUTION="${1:-640x480}"
# 画像フォーマット
readonly IMAGEFORMAT="${2:-YUYV}"
# フレーム画像の出力ディレクトリ
readonly IMAGE_OUTPUT_DIR="${3:-image_output}"

# 出力ディレクトリがない場合は作成する
mkdir -p "${IMAGE_OUTPUT_DIR}"
result=$?
if [ $result -ne 0 ]; then
    echo "Error : mkdir failed."
    echo "${DATETIME}" >> error.txt
    echo "Error : mkdir failed." >> error.txt
    exit
fi

# ファイル名
readonly DATETIME=$(date "+%Y%m%d_%H%M%S")
readonly IMAGE_OUTPUT_FILE_PATH="${IMAGE_OUTPUT_DIR%/}/frame_${DATETIME}.jpg"

# コマンド実行と結果取得
# fswebcam  --no-banner --quiet -d v4l2:/dev/video0 -p YUYV -r 640x480 --jpeg 90 dir/frame.jpg
#   --no-banner         : バナー無し
#   --quiet             : エラーを除くすべてのメッセージを非表示
#   -d v4l2:/dev/video0 : 使用するデバイスとして「/dev/video0」を指定
#   -p YUYV             : 画像をキャプチャするときの画像形式として「YUYV」を指定
#   -r 640x480          : デバイスの画像解像度として、「640 x 480」を指定
#   --jpeg 90           : jpegの圧縮係数 90。0～95の間の値を指定。大きいほど高画質
#   dir/frame.jpg       : キャプチャした画像の出力ファイルパス
readonly COMMAND_FSWEBCAM="fswebcam --no-banner --quiet -d v4l2:/dev/video0 -p ${IMAGEFORMAT} -r ${RESOLUTION} --jpeg 90 ${IMAGE_OUTPUT_FILE_PATH}"
readonly STDERR_FSWEBCAM=$(${COMMAND_FSWEBCAM} 2>&1 > /dev/null)

# エラー出力
if [ "" != "${STDERR_FSWEBCAM}" ]; then
    echo "${STDERR_FSWEBCAM}" >> "${IMAGE_OUTPUT_FILE_PATH}.txt"
fi
