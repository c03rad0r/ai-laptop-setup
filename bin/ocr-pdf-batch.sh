#!/bin/bash

# Script to convert PDF files to text using OCR
# Usage: ./ocr-pdf-batch.sh [input_directory] [output_directory]

INPUT_DIR="${1:-/media/c03rad0r/Transcend/mietvertrag}"
OUTPUT_DIR="${2:-/media/c03rad0r/Transcend/mietvertrag/ocr-output}"

echo "Starting OCR processing..."
echo "Input directory: $INPUT_DIR"
echo "Output directory: $OUTPUT_DIR"
echo "----------------------------------------"

# Create output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# Find all PDF files and process them
find "$INPUT_DIR" -name "*.pdf" -type f | while read pdf_file; do
    # Get relative path and filename
    relative_path="${pdf_file#$INPUT_DIR/}"
    filename=$(basename "$pdf_file" .pdf)
    output_file="$OUTPUT_DIR/${filename}.txt"
    
    # Create subdirectories in output if needed
    output_subdir=$(dirname "$output_file")
    mkdir -p "$output_subdir"
    
    echo "Processing: $relative_path"
    
    # Try ocrmypdf first (better for PDFs)
    if command -v ocrmypdf &> /dev/null; then
        echo "  Using ocrmypdf..."
        ocrmypdf -l eng+deu --force-ocr "$pdf_file" "$pdf_file"
        # Extract text from the PDF (whether it was OCR'd or not)
        pdftotext "$pdf_file" "$output_file"
    else
        # Fallback to tesseract
        echo "  Using tesseract..."
        tesseract "$pdf_file" "$output_file" -l eng+deu pdf 2>/dev/null || true
    fi
    
    if [ -f "$output_file" ]; then
        echo "  ✓ Output saved to: ${output_file#$OUTPUT_DIR/}"
        # Show first few lines of the output
        echo "  First 3 lines:"
        head -3 "$output_file" | sed 's/^/    /'
    else
        echo "  ✗ Failed to create output file"
    fi
    echo ""
done

echo "OCR processing complete!"
echo "Output files are in: $OUTPUT_DIR"