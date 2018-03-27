# LocoLaser iOS Example
LocoLaser - Localozation tool for Android and iOS. See https://github.com/PocketByte/LocoLaser/ for more details.
<br>This example project shows how to use localization in iOS.

##### 1 Step: Add Bash script
Example has a special Bash scripts in folder `"./locloaser-example-ios/"`. You can copy them without changes in your project in the folder with sources. There are 3 files:
- **`localize.command`** - Run LocoLaser with default parameters;
- **`localizeForce.command`** - Run LocoLaser with flag `--force`;
- **`localizeExportNew.command`** - Run LocoLaser with flag `--force` and `conflict strategy = export_new_platform`.

##### 2 Step: Choose artifact
You are able to choose which type of tool you will to use by setting a special variables in `localize.command`. There are `ARTIFACTS` variable that respons to LocoLaser artifact. For Mobile platform and Google Sheets source use following artifacts:
- **`ru.pocketbyte.locolaser:core:1.2.1`** - Mandatory artifact that contains common LocoLaser logic;
- **`ru.pocketbyte.locolaser:platform-mobile:1.2.1`** - Artifact that has logic of how to work with mobile platform configuration;
- **`ru.pocketbyte.locolaser:source-googlesheet:1.2.1`** - Artifact that has logic of how to work with Google Sheets source configuration.

Leave bash scripts without changes if you want to use Google Sheets as a source in your XCode project.

##### 3 Step: Add LocoLaser config
Place your `"localization_config.json"` in the folder with sources. In example it's `"./locloaser-example-ios/"`. You can read more about config file content in the following repository: https://github.com/PocketByte/LocoLaser/.
<br>You can change name and location of config file by changing variable **`CONFIG_FILE`** in `localize.command`.

##### 4 Step: Run localization
All preparation are done. To run localization you should run coresponded bash script.
<br> If you wish, you able to run LocoLaser before each build. To do it you should add **Run Script** to your project. For example:
``` Bash
./locloaser-example-ios/localize.command
```
This **Run Script** should be exuted **IMMEDIATELY** after phase **Target Dependencies**. If this script run later it can lead to undesirable consequences.

### License
```
Copyright © 2017 Denis Shurygin. All rights reserved.
Contacts: <mail@pocketbyte.ru>

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
