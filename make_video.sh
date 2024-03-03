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

# make_video.sh
# 画像からタイムラプス動画の作成

# フレームレート
readonly FRAMERATE="30"
# ビデオソースのディレクトリ
readonly VIDEO_SOURCE_DIR="video_source"
# ビデオの出力ディレクトリ
readonly VIDEO_OUTPUT_DIR="video_output"

# 出力ディレクトリがない場合は作成する
mkdir -p "${VIDEO_OUTPUT_DIR}"
result=$?
if [ $result -ne 0 ]; then
    echo "Error : mkdir failed."
    echo "${DATETIME}" >> error.txt
    echo "Error : mkdir failed." >> error.txt
    exit
fi

# ファイル名
readonly VIDEO_SOURCE_FILE_PATH_PATTERN="${VIDEO_SOURCE_DIR%/}/*.jpg"
readonly DATETIME=$(date "+%Y%m%d_%H%M%S")
readonly VIDEO_OUTPUT_FILE_PATH="${VIDEO_OUTPUT_DIR%/}/timelapse_${DATETIME}.mp4"

# コマンド実行
# ffmpeg -framerate 30 -pattern_type glob -i "*.jpg" -an -vcodec libx264 -pix_fmt yuv420p -r 30 dir/video.mp4
#   -framerate 30    : 1秒に「30」枚の画像を使用
#   -pattern_type glob -i "*.jpg" : 入力画像ファイルのパターンを指定
#   -an              : オーディオ無し
#   -vcodec libx264  : ビデオコーデック H.264
#   -pix_fmt yuv420p : ピクセルフォーマット yuv420p
#   -r 30            : 出力動画のフレームレート「30」fps
#   dir/video.mp4    : タイムラプス動画の出力ファイルパス
ffmpeg -framerate ${FRAMERATE} -pattern_type glob -i "${VIDEO_SOURCE_FILE_PATH_PATTERN}" \
       -an -vcodec libx264 -pix_fmt yuv420p -r ${FRAMERATE} ${VIDEO_OUTPUT_FILE_PATH}
