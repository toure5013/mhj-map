import os
import re

target_dir = '/Users/touresouleymane/Downloads/mhj_maps-main/packages/flutter'
root_readme = '/Users/touresouleymane/Downloads/mhj_maps-main/README.md'

replacements = [
    (re.compile(r'MhjMaps'), r'MhjMaps'),
    (re.compile(r'mhj_maps'), r'mhj_maps'),
    (re.compile(r'MHJ_MAPS'), r'MHJ_MAPS'),
]

# We also want to replace "MhjMaps" to "Mhj-maps" where it makes sense? No, let's just stick to MhjMaps and mhj_maps for simplicity and valid dart code.

# Step 1: Replace contents
def replace_contents(filepath):
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()

    new_content = content
    for pattern, repl in replacements:
        new_content = pattern.sub(repl, new_content)

    if new_content != content:
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(new_content)
        return True
    return False

# Directories to skip
skip_dirs = {'.git', 'node_modules', '.dart_tool', 'build', '.idea', 'ios', 'android', 'macos', 'web', 'windows', 'linux'}

files_modified = 0
for root, dirs, files in os.walk(target_dir):
    dirs[:] = [d for d in dirs if d not in skip_dirs]
    for file in files:
        if file.endswith(('.png', '.svg', '.lock', '.ttf')): 
            continue
        filepath = os.path.join(root, file)
        try:
            if replace_contents(filepath):
                files_modified += 1
        except Exception as e:
            print(f"Failed to read/write {filepath}: {e}")

# Also update the root README
try:
    if replace_contents(root_readme):
        files_modified += 1
except Exception as e:
    pass

print(f"Modified {files_modified} files.")

# Step 2: Rename files
files_renamed = 0
for root, dirs, files in os.walk(target_dir, topdown=False):
    dirs[:] = [d for d in dirs if d not in skip_dirs]
    for file in files:
        if 'mhj_maps' in file:
            old_path = os.path.join(root, file)
            new_name = file.replace('mhj_maps', 'mhj_maps')
            new_path = os.path.join(root, new_name)
            os.rename(old_path, new_path)
            files_renamed += 1

print(f"Renamed {files_renamed} files.")

# Step 3: Rename directories
dirs_renamed = 0
for root, dirs, files in os.walk(target_dir, topdown=False):
    dirs[:] = [d for d in dirs if d not in skip_dirs]
    for d in dirs:
        if 'mhj_maps' in d:
            old_path = os.path.join(root, d)
            new_name = d.replace('mhj_maps', 'mhj_maps')
            new_path = os.path.join(root, new_name)
            os.rename(old_path, new_path)
            dirs_renamed += 1

print(f"Renamed {dirs_renamed} directories.")
