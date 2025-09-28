#!/bin/sh
set -e

# Go into docs/ folder
cd "$(dirname "$0")/docs"

echo "🔄 Extracting gettext files..."
sphinx-build -b gettext source build/gettext

echo "🔄 Updating PO files..."
sphinx-intl update -p build/gettext -l de

echo ""
echo "✅ PO files updated: source/locale/de/LC_MESSAGES/*.po"
echo "✍️  Please edit the translations now."
echo ""

printf "Are you done with translations? Run 'sphinx-intl build'? (y/n) "
read answer

case "$answer" in
    y|Y)
        echo "🚀 Building MO files..."
        sphinx-intl build
        echo "✅ Done!"
        ;;
    *)
        echo "⏸️ Skipped. You can run 'sphinx-intl build' later."
        ;;
esac
