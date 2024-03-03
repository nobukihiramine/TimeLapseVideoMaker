# Time Lapse Video Maker
タイムラプス動画（時間経過動画）メーカー

# 目次
* [1. 概要](#1-概要)
* [2. セットアップ](#2-セットアップ)
* [3. Webカメラからの画像の保存の動作確認](#3-Webカメラからの画像の保存の動作確認)
* [4. サポートされているカメラパラメータのリストの確認](#4-サポートされているカメラパラメータのリストの確認)
* [5. Webカメラからの画像の保存の定期実行](#5-Webカメラからの画像の保存の定期実行)
* [5. タイムプラス動画の作成](#5-タイムプラス動画の作成)
* [License (ライセンス)](#license-ライセンス)

# 1. 概要

* 要件
   * Webカメラを用いて、タイムラプス動画を作成すること

* 動作確認環境  
   - Raspberry Pi 3 Model B
   - Logicool Webカメラ C270
   - Raspberry Pi OS version 11 (bullseye)
   - Python version 3.11.2
   - fswebcam version 20140113

# 2. セットアップ

1. 必要となるパッケージのインストール
   ```shell
   $ sudo apt install git -y
   $ sudo apt install -y fswebcam
   $ sudo apt install -y ffmpeg
   ```

2. プログラムファイルのダウンロード
   ```shell
   $ git clone https://github.com/nobukihiramine/TimeLapseVideoMaker
   ```

3. シェルスクリプトファイルに実行権限の付与
   ```shell
   $ chmod +x ./TimeLapseVideoMaker/*.sh
   ```

# 3. Webカメラからの画像の保存の動作確認

1. Webカメラの接続  
   コンピューターにWebカメラを接続します。

2. スクリプトの実行  
   ```shell
   ./TimeLapseVideoMaker/save_frame.sh
   ```

3. 結果の確認  
   問題がなければ "image_output" ディレクトリに、Webカメラからの画像ファイルが "frame_YYYYmmDD_HHMMSS.jpg" 形式のファイル名で保存されます。

# 4. サポートされているカメラパラメータのリストの確認

1. コマンドの実行  
   ```shell
   $ v4l2-ctl --list-formats-ext
   ```

2. 結果の確認  
   サポートされているカメラパラメータのリストが出力されます。

# 5. Webカメラからの画像の保存の定期実行

1. cron設定  
   以下の書式で、コマンドの予約実行をcron設定します。  
   ```shell
   分 時 日 月 曜日 ./TimeLapseVideoMaker/save_frame.sh 解像度 画像フォーマット 出力ディレクトリパス
   ```
   - 解像度 : Webカメラからの画像の解像度を "幅x高さ" の書式で指定します。省略可。省略した場合は "640x480"。
   - 画像フォーマット : Webカメラからの画像のフォーマットを指定します。省略可。省略した場合は "YUYV"。
   - 出力ディレクトリパス : Webカメラからの画像を出力するディレクトリパスを指定します。省略可。省略した場合値は "image_output"。

2. 結果の確認  
   "出力ディレクトリパス" で指定したディレクトリに、Webカメラからの画像ファイルが "frame_YYYYmmDD_HHMMSS.jpg" 形式のファイル名で保存されます。

# 6. タイムプラス動画の作成

1. 準備  
   "image_output" ディレクトリ(※1)から、タイムラプス動画の元とする画像ファイルを、"video_source" ディレクトリ(※2) に移動します。
   - ※1 "image_output" ディレクトリ : save_frame.sh の引数にて変更可能。
   - ※2 "video_source" ディレクトリ : make_video.sh の引数にて変更可能。

2. スクリプトの実行
   ```shell
   $ ./TimeLapseVideoMaker/make_video.sh フレームレート[fps] 入力ディレクトリパス 出力ディレクトリパス
   ```
   - フレームレート[fps] : 1秒に何枚の画像を使用するかを指定します。省略可。省略した場合は "30"。
   - 入力ディレクトリパス : タイムラプス動画の元となる画像ファイルが入っているディレクトリパスを指定します。省略可。省略した場合は "video_source"。
   - 出力ディレクトリパス : 作成結果のタイムラプス動画を出力するディレクトリパスを指定します。省略可。省略した場合は "video_output"。

3. 結果の確認  
   "video_output" ディレクトリ(※3) に、タイムラプス動画ファイルが "timelapse_YYYYmmDD_HHMMSS.mp4" 形式のファイル名で保存されます。
   - ※3 "video_output" ディレクトリ : make_video.sh の引数にて変更可能。

# License (ライセンス)

Copyright 2023 Nobuki HIRAMINE  
The source is licensed under the Apache License, Version 2.0.  
"Source" form shall mean the preferred form for making modifications, including but not limited to software source code, documentation source, and configuration files.  
See the [LICENSE](LICENSE) file for more details.   
(ソースのライセンスは、「Apache License, Version 2.0」です。  
「ソース」という用語は、変更を加えるのに都合の良い形式を指し、「ソース」にはソフトウェアのソースコード、ドキュメントのソース、設定ファイルなどが含まれますが、これに限定されるものではありません。  
詳細は「[LICENSE](LICENSE)」ファイルを参照ください。)
