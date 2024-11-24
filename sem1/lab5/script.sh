#!/bin/bash

# �������� �� ������� ���������
if [ -z "$1" ]; then
    echo "�� ������ ���� � �����"
    exit 1
fi

# ���������� ���� � ����� ������� ��� ������ ��������
DIR="$1"

# �������� ������������� �����
if [ ! -d "$DIR" ]; then
    echo "������ ����� ���"
    exit 1
fi

tempFile=$(mktemp)

# ����� ��� .txt ����� � ������� 5-� ������ �������
find "$DIR" -type f -name "*.txt" | while IFS= read -r file; do
    # ��������� ����� ������ ����� (���� ��� ����������)
    line=$(sed -n '5p' "$file")
    if [ -n "$line" ]; then
        echo "$line" >> "$tempFile"
    fi
done

# ��������� ������ � ���������� � log.txt
sort "$tempFile" > log.txt
rm "$tempFile"
echo "��������� ������� � log.txt"