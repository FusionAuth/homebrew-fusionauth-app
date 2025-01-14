#
# Copyright (c) 2019-2024, FusionAuth, All Rights Reserved
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND,
# either express or implied. See the License for the specific
# language governing permissions and limitations under the License.
#

# To release (version 1.10.1 for example)
#
# >  ./release.sh 1.10.1

# Download sha256 sum files
rm -f fusionauth-app-${1}.zip.sha256
wget --no-verbose "https://files.fusionauth.io/products/fusionauth/${1}/fusionauth-app-${1}.zip.sha256"

# - Note that this generally will run on a build server running GNU. If you run on macOS which is BSD, the behavior of sed differs when using -i.
#   See: https://stackoverflow.com/questions/29904928/sed-adding-e-suffixed-file-when-used-in-osx
#        https://stackoverflow.com/a/5694430/3892636
#
# Note that if you try to run this on macOS it won't work the same, and a backup file will be created with a '-E' extension.
# GNU: sed -i -E
# BSD: sed -i '' -E

# Update URL
sed -i -E "s/fusionauth\/(.*)\/fusionauth-app-(.*).zip\"$/fusionauth\/${1}\/fusionauth-app-${1}.zip\"/" ./Formula/fusionauth-app.rb

# Update SHA 256 sum
sum=`cat ./fusionauth-app-${1}.zip.sha256|awk -F" " '{print $1}'`
sed -i -E "s/sha256 \"(.*)\"$/sha256 \"${sum}\"/" ./Formula/fusionauth-app.rb

rm fusionauth-app-${1}.zip.sha256

git add .
git commit -m"release ${1}"
git push
git tag ${1}
git push --tags
