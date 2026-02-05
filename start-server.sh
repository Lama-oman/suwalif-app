#!/bin/bash
# Local Server Script for Suwalif

echo "🚀 Starting Suwalif local server..."
echo ""
cd "$(dirname "$0")/docs"
echo "📁 Serving from: $(pwd)"
echo ""
echo "🌐 Open your browser and navigate to:"
echo "   http://localhost:8765"
echo ""
echo "📱 The app will be available on any device on your network!"
echo ""
python3 -m http.server 8765