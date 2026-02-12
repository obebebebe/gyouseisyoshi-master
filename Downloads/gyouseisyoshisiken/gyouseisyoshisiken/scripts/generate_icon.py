"""
行政書士マスター2026 アプリアイコン生成スクリプト
"""
from PIL import Image, ImageDraw, ImageFont
import os

def create_icon(size=1024):
    """モダンでプロフェッショナルなアイコンを生成"""

    # 画像作成
    img = Image.new('RGBA', (size, size), (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)

    # 背景グラデーション風（深い青から紺へ）
    # 円形の背景
    padding = int(size * 0.05)

    # メインの背景色（深い青）
    main_color = (25, 55, 109)  # #19376D - プロフェッショナルな深い青
    accent_color = (162, 123, 92)  # #A27B5C - ゴールドアクセント

    # 角丸の四角形背景
    corner_radius = int(size * 0.2)

    # 背景を描画
    draw.rounded_rectangle(
        [padding, padding, size - padding, size - padding],
        radius=corner_radius,
        fill=main_color
    )

    # 装飾的な要素（上部にゴールドのアクセントライン）
    line_y = int(size * 0.18)
    line_height = int(size * 0.015)
    line_margin = int(size * 0.15)
    draw.rounded_rectangle(
        [line_margin, line_y, size - line_margin, line_y + line_height],
        radius=line_height // 2,
        fill=accent_color
    )

    # 「行」の文字を描画
    try:
        # Windows日本語フォントを試す
        font_paths = [
            "C:/Windows/Fonts/YuGothB.ttc",  # 游ゴシック Bold
            "C:/Windows/Fonts/meiryo.ttc",    # メイリオ
            "C:/Windows/Fonts/msgothic.ttc",  # MS ゴシック
            "C:/Windows/Fonts/msmincho.ttc",  # MS 明朝
        ]
        font = None
        for fp in font_paths:
            if os.path.exists(fp):
                font = ImageFont.truetype(fp, int(size * 0.5))
                break
        if font is None:
            font = ImageFont.load_default()
    except:
        font = ImageFont.load_default()

    text = "行"

    # テキストのバウンディングボックスを取得
    bbox = draw.textbbox((0, 0), text, font=font)
    text_width = bbox[2] - bbox[0]
    text_height = bbox[3] - bbox[1]

    # 中央に配置（少し下にオフセット）
    x = (size - text_width) // 2
    y = (size - text_height) // 2 + int(size * 0.05)

    # テキスト描画（白色）
    draw.text((x, y), text, font=font, fill=(255, 255, 255))

    # 下部にゴールドのアクセントライン
    line_y2 = int(size * 0.82)
    draw.rounded_rectangle(
        [line_margin, line_y2, size - line_margin, line_y2 + line_height],
        radius=line_height // 2,
        fill=accent_color
    )

    return img


def create_foreground(size=1024):
    """Adaptive icon用のフォアグラウンド画像（透明背景）"""
    img = Image.new('RGBA', (size, size), (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)

    # 「行」の文字
    try:
        font_paths = [
            "C:/Windows/Fonts/YuGothB.ttc",
            "C:/Windows/Fonts/meiryo.ttc",
            "C:/Windows/Fonts/msgothic.ttc",
        ]
        font = None
        for fp in font_paths:
            if os.path.exists(fp):
                font = ImageFont.truetype(fp, int(size * 0.35))
                break
        if font is None:
            font = ImageFont.load_default()
    except:
        font = ImageFont.load_default()

    text = "行"
    bbox = draw.textbbox((0, 0), text, font=font)
    text_width = bbox[2] - bbox[0]
    text_height = bbox[3] - bbox[1]

    x = (size - text_width) // 2
    y = (size - text_height) // 2

    draw.text((x, y), text, font=font, fill=(255, 255, 255))

    return img


def main():
    output_dir = "F:/Program/gyouseisyoshisiken/assets/icon"
    os.makedirs(output_dir, exist_ok=True)

    # メインアイコン（1024x1024）
    icon = create_icon(1024)
    icon.save(f"{output_dir}/app_icon.png", "PNG")
    print(f"Created: {output_dir}/app_icon.png")

    # Adaptive icon用フォアグラウンド
    foreground = create_foreground(1024)
    foreground.save(f"{output_dir}/app_icon_foreground.png", "PNG")
    print(f"Created: {output_dir}/app_icon_foreground.png")

    # Android用各サイズ
    android_sizes = {
        'mipmap-mdpi': 48,
        'mipmap-hdpi': 72,
        'mipmap-xhdpi': 96,
        'mipmap-xxhdpi': 144,
        'mipmap-xxxhdpi': 192,
    }

    android_res_dir = "F:/Program/gyouseisyoshisiken/android/app/src/main/res"

    for folder, size in android_sizes.items():
        folder_path = f"{android_res_dir}/{folder}"
        os.makedirs(folder_path, exist_ok=True)

        resized = icon.resize((size, size), Image.Resampling.LANCZOS)
        resized.save(f"{folder_path}/ic_launcher.png", "PNG")
        print(f"Created: {folder_path}/ic_launcher.png ({size}x{size})")

    print("\nAll icons generated successfully!")


if __name__ == "__main__":
    main()
