import subprocess
import os
import argparse
import tempfile
from PIL import Image

def check_ffmpeg_installed():
    """检查系统是否安装了 FFmpeg"""
    try:
        subprocess.run(
            ["ffmpeg", "-version"],
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            check=True
        )
        return True
    except (subprocess.CalledProcessError, FileNotFoundError):
        print("错误: 未找到 FFmpeg。请确保 FFmpeg 已安装并添加到系统 PATH 中。")
        return False

def get_gif_dimensions(gif_path):
    """获取 GIF 的宽度和高度"""
    try:
        with Image.open(gif_path) as img:
            return img.size
    except Exception as e:
        print(f"无法获取 GIF 尺寸: {e}")
        return None, None

def make_dimensions_even(width, height):
    """确保宽度和高度都是偶数"""
    new_width = width if width % 2 == 0 else width + 1
    new_height = height if height % 2 == 0 else height + 1
    
    if new_width != width or new_height != height:
        print(f"调整尺寸: {width}x{height} -> {new_width}x{new_height}")
    
    return new_width, new_height

def convert_gif_to_mp4(input_path, output_path, fps=15, quality=23, resize=None):
    """
    使用 FFmpeg 将 GIF 转换为 MP4
    
    参数:
        input_path: 输入 GIF 文件路径
        output_path: 输出 MP4 文件路径
        fps: 输出视频的帧率
        quality: 视频质量参数 (CRF, 0-51, 越小质量越高)
        resize: 调整尺寸的参数，例如 "640:-1"
    """
    if not check_ffmpeg_installed():
        return False
    
    # 获取 GIF 尺寸并确保为偶数
    width, height = get_gif_dimensions(input_path)
    if width and height:
        width, height = make_dimensions_even(width, height)
        scale_filter = f"scale={width}:{height}"
    else:
        scale_filter = None
    
    # 构建 FFmpeg 命令
    cmd = [
        "ffmpeg",
        "-i", input_path,
        "-r", str(fps),
        "-c:v", "libx264",
        "-crf", str(quality),
        "-pix_fmt", "yuv420p",  # 确保兼容性
        "-y"  # 覆盖已存在文件
    ]
    
    # 添加尺寸调整
    if scale_filter:
        cmd.extend(["-vf", scale_filter])
    
    # 添加输出路径
    cmd.append(output_path)
    
    # 执行命令
    try:
        print(f"开始转换: {input_path} -> {output_path}")
        result = subprocess.run(
            cmd,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            text=True,
            check=True
        )
        print(f"转换成功: {output_path}")
        return True
    except subprocess.CalledProcessError as e:
        print(f"转换失败: {e.stderr}")
        return False
    except Exception as e:
        print(f"发生错误: {e}")
        return False

def main():
    parser = argparse.ArgumentParser(description="使用 FFmpeg 将 GIF 转换为 MP4")
    parser.add_argument("input", help="输入 GIF 文件路径")
    parser.add_argument("-o", "--output", help="输出 MP4 文件路径，默认为 input.mp4")
    parser.add_argument("-f", "--fps", type=int, default=15, help="输出视频的帧率 (默认: 15)")
    parser.add_argument("-q", "--quality", type=int, default=23, help="视频质量参数 (0-51, 越小质量越高, 默认: 23)")
    parser.add_argument("-s", "--scale", help="调整尺寸，例如 '640:-1'")
    
    args = parser.parse_args()
    
    # 检查输入文件是否存在
    if not os.path.isfile(args.input):
        print(f"错误: 输入文件 '{args.input}' 不存在")
        return 1
    
    # 生成输出文件名（如果未提供）
    if args.output:
        output_file = args.output
        # 确保输出文件扩展名为 .mp4
        if not output_file.lower().endswith('.mp4'):
            output_file += '.mp4'
    else:
        base_name, _ = os.path.splitext(args.input)
        output_file = f"{base_name}.mp4"
    
    # 执行转换
    success = convert_gif_to_mp4(
        args.input,
        output_file,
        fps=args.fps,
        quality=args.quality,
        resize=args.scale
    )
    
    return 0 if success else 1

if __name__ == "__main__":
    main()   