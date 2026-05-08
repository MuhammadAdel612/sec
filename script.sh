#!/bin/bash
# 1. بناء الصورة
buildah bud -t my-app:latest .

# 2. فحص الصورة باستخدام ACS
echo "Starting RHACS Scan..."
# الـ Variables دي هتيجي من الـ Secret اللي عملناه
./roxctl image check \
  --endpoint $ROX_CENTRAL_ADDRESS \
  --image my-app:latest \
  --insecure-skip-tls-verify

# 3. النتيجة
if [ $? -eq 0 ]; then
  echo "ACS Scan Passed!"
  # لو نجح يعمل Push
  buildah push my-app:latest $DESTINATION_IMAGE
else
  echo "ACS Scan Failed! Blocking build..."
  exit 1 # السطر ده هو اللي بيمنع الاستكمال وبيفشل الـ Build
fi
